---
name: code-count
description: Count Claude Code tokens and estimate API cost from local JSONL transcripts. Use when the user asks about usage, token counts, API cost, or billing stats.
allowed-tools: Bash(python3:*)
author: stevederico
---

# Claude Code Usage Stats

Count tokens and estimate equivalent API cost from local Claude Code JSONL transcripts stored in `~/.claude/projects/`.

## How it works

Claude Code stores conversation transcripts as JSONL files in `~/.claude/projects/<encoded-path>/*.jsonl`. Each line is a JSON object. Lines with assistant messages contain a `message` object with a `usage` block tracking token consumption for that API call.

### Deduplication

Streaming responses write multiple JSONL lines for the same API call with **cumulative** token counts. To avoid double-counting, deduplicate using `messageId:requestId` as a composite key and keep only the **last** entry per key.

- `messageId` = `message.id` field
- `requestId` = top-level `requestId` field
- If either is missing, the entry is always counted (never deduped)

### Token fields

| Field | Description |
|-------|-------------|
| `input_tokens` | Direct input tokens (small — most context hits cache) |
| `cache_creation_input_tokens` | Tokens written to prompt cache (costs 1.25x input) |
| `cache_read_input_tokens` | Tokens read from prompt cache (costs 0.1x input) |
| `output_tokens` | Generated output tokens |

### Timestamps

All timestamps in the JSONL are UTC. Always convert to the user's **local timezone** before bucketing by date. Use `datetime.now(timezone.utc).astimezone().tzinfo` to auto-detect local timezone.

### Optional: `costUSD`

Some transcripts include a pre-calculated `costUSD` field per entry. If present, sum those instead of computing from tokens. Pro/Max subscriptions typically don't populate this field.

### Opus API pricing (per 1M tokens)

| Type | Cost |
|------|------|
| Input | $15 |
| Cache creation | $18.75 |
| Cache read | $1.50 |
| Output | $75 |

## When the user asks for usage stats

Run the following script via `python3 -c`. Adjust the `days` variable if the user specifies a time range (default: 30 days). Present results as a formatted table.

```python
import json, os, glob
from datetime import datetime, timedelta, timezone

LOCAL_TZ = datetime.now(timezone.utc).astimezone().tzinfo
days = 30
cutoff = (datetime.now(timezone.utc) - timedelta(days=days)).isoformat()

def to_local_date(ts):
    if not ts:
        return None
    if ts.endswith('Z'):
        dt = datetime.fromisoformat(ts.replace('Z', '+00:00'))
    elif '+' in ts[10:] or ts.count('-') > 2:
        dt = datetime.fromisoformat(ts)
    else:
        dt = datetime.fromisoformat(ts).replace(tzinfo=timezone.utc)
    return dt.astimezone(LOCAL_TZ).strftime('%Y-%m-%d')

messages = {}

for path in glob.glob(os.path.expanduser('~/.claude/projects/*/*.jsonl')):
    with open(path) as f:
        for line in f:
            try:
                obj = json.loads(line.strip())
                mid = obj.get('message', {}).get('id')
                rid = obj.get('requestId')
                if not mid or not rid:
                    continue
                u = obj.get('message', {}).get('usage', {})
                cost = obj.get('costUSD')
                if not u:
                    continue
                ts = obj.get('timestamp') or obj.get('message', {}).get('created_at') or ''
                if ts < cutoff:
                    continue
                date = to_local_date(ts) or datetime.fromtimestamp(os.path.getmtime(path)).strftime('%Y-%m-%d')
                messages[f'{mid}:{rid}'] = {'usage': u, 'costUSD': cost, 'date': date}
            except:
                pass

total_in = total_out = total_cache_create = total_cache_read = 0
total_cost = 0.0
cost_entries = 0

for v in messages.values():
    u = v['usage']
    total_in += u.get('input_tokens', 0)
    total_out += u.get('output_tokens', 0)
    total_cache_create += u.get('cache_creation_input_tokens', 0)
    total_cache_read += u.get('cache_read_input_tokens', 0)
    if v['costUSD'] is not None:
        total_cost += v['costUSD']
        cost_entries += 1

print(f'Last {days} days ({LOCAL_TZ})')
print(f'Unique API calls:     {len(messages):>15,}')
print(f'Input tokens:         {total_in:>15,}')
print(f'Cache creation:       {total_cache_create:>15,}')
print(f'Cache reads:          {total_cache_read:>15,}')
print(f'Output tokens:        {total_out:>15,}')
if cost_entries > 0:
    print(f'Pre-calculated cost:  ${total_cost:>14,.2f}')
else:
    cost = (total_in/1e6*15 + total_cache_create/1e6*18.75 + total_cache_read/1e6*1.50 + total_out/1e6*75)
    print(f'Estimated API cost:   ${cost:>14,.2f}  (Opus rates)')
```

## When the user asks for a daily breakdown

Run the same parsing logic above, then bucket by local date and display a bar chart:

```python
from collections import defaultdict

daily = defaultdict(float)
for v in messages.values():
    u = v['usage']
    cost = (u.get('input_tokens',0)/1e6*15 + u.get('cache_creation_input_tokens',0)/1e6*18.75
            + u.get('cache_read_input_tokens',0)/1e6*1.50 + u.get('output_tokens',0)/1e6*75)
    daily[v['date']] += cost

start = datetime.strptime(min(daily.keys()), '%Y-%m-%d')
end = datetime.strptime(max(daily.keys()), '%Y-%m-%d')
all_days = []
d = start
while d <= end:
    ds = d.strftime('%Y-%m-%d')
    all_days.append((ds, daily.get(ds, 0)))
    d += timedelta(days=1)

max_cost = max(c for _, c in all_days)
for date, cost in all_days:
    bars = int((cost / max_cost) * 50) if max_cost > 0 else 0
    day = datetime.strptime(date, '%Y-%m-%d').strftime('%a')
    print(f'{date} {day}  {"█" * bars} ${cost:>7,.0f}')
print(f'\nTotal: ${sum(c for _, c in all_days):>,.0f}')
```

## When the user asks for per-project breakdown

```python
from collections import defaultdict

projects = defaultdict(lambda: {'calls': 0, 'in': 0, 'out': 0, 'cache_create': 0, 'cache_read': 0})

for path in glob.glob(os.path.expanduser('~/.claude/projects/*/*.jsonl')):
    project = os.path.basename(os.path.dirname(path))
    file_msgs = {}
    with open(path) as f:
        for line in f:
            try:
                obj = json.loads(line.strip())
                mid = obj.get('message', {}).get('id')
                rid = obj.get('requestId')
                if not mid or not rid:
                    continue
                u = obj.get('message', {}).get('usage', {})
                if not u:
                    continue
                file_msgs[f'{mid}:{rid}'] = u
            except:
                pass
    p = projects[project]
    for u in file_msgs.values():
        p['calls'] += 1
        p['in'] += u.get('input_tokens', 0)
        p['out'] += u.get('output_tokens', 0)
        p['cache_create'] += u.get('cache_creation_input_tokens', 0)
        p['cache_read'] += u.get('cache_read_input_tokens', 0)

for name in sorted(projects, key=lambda k: projects[k]['out'], reverse=True):
    p = projects[name]
    short = name.split('-')[-1] if name.count('-') > 3 else name
    cost = (p['in']/1e6*15 + p['cache_create']/1e6*18.75 + p['cache_read']/1e6*1.5 + p['out']/1e6*75)
    print(f'{short:<30} {p["calls"]:>6} calls  {p["out"]:>10,} out tokens  ${cost:>8,.2f}')
```
