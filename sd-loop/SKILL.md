---
name: sd-loop
description: Start an autonomous loop — re-feeds the same prompt until done
argument-hint: ["<prompt>"] [--max-iterations N] [--completion-promise "TEXT"]
disable-model-invocation: true
allowed-tools: Bash, Write, Read
author: stevederico
---

# Start Loop

Parse the user's arguments: `/sd-loop ["<prompt>"] [--max-iterations N] [--completion-promise "TEXT"]`

Defaults:
- prompt (if none provided): `Read SPEC.md and implement everything in it. When all items are complete, commit your work, push the branch, and submit a PR with gh pr create. Then output <promise>DONE</promise>.`
- max-iterations = 50
- completion-promise = "DONE" (when using default prompt), otherwise none

## Instructions

1. If using the default prompt (no custom prompt provided), check if `SPEC.md` exists in the current project directory. If not, create it with this starter template and tell the user to fill it in before running `/sd-loop` again — then stop:

```markdown
# Spec

## Requirements

-
```

2. Create `.claude/loop.local.md` in the current project directory:

```markdown
---
active: true
iteration: 0
max_iterations: <N>
completion_promise: "<TEXT or empty>"
started_at: <ISO timestamp>
---
<THE PROMPT>
```

3. Confirm to the user:
   - Loop started with their prompt
   - Max iterations: N
   - Completion promise: TEXT (if set) — output `<promise>TEXT</promise>` to exit early
   - To cancel: `/sd-loop-cancel`

4. Then immediately execute the prompt — begin working on it now.
