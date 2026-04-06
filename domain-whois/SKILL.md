---
name: domain-whois
description: Check domain name availability across 12 TLDs via direct WHOIS/RDAP lookups. No external service needed. Use when the user asks about domain availability, wants to find a domain name, or mentions registering a domain.
compatibility: Requires bash, whois CLI (built into macOS, install via apt on Linux), and curl.
metadata:
  author: stevederico
  version: "1.0"
---

# Domain WHOIS Checker

Check domain availability across 12 TLDs via direct WHOIS and RDAP lookups. No API dependency.

## When to use

- User asks "is example.com available?"
- User wants to find available domain names
- User is brainstorming project names and wants to check domains

## How to check

Run the bundled script:

```bash
scripts/check.sh <domain>
```

Pass the base name only (no TLD). The script checks all 12 TLDs in parallel:
`.com`, `.net`, `.org`, `.io`, `.dev`, `.app`, `.co`, `.xyz`, `.ai`, `.shop`, `.site`, `.tech`

## Output format

Pipe-delimited, sorted available first:

```
example.dev|Available
example.app|Available
example.com|Taken
example.shop|Unknown
```

## Presenting results

Format as a table:

| Domain | Status |
|--------|--------|
| example.dev | Available |
| example.app | Available |
| example.com | Taken |

## Checking multiple names

Run the script once per name. Can run in parallel:

```bash
scripts/check.sh name1 &
scripts/check.sh name2 &
wait
```

## How it works

- 10 TLDs checked via `whois -h <server>` (port 43 TCP)
- `.dev` and `.app` checked via RDAP (HTTP to Google registry)
- All 12 lookups run in parallel
- Results parsed for known available/taken patterns
