---
name: sd-loop-cancel
description: Cancel active loop
disable-model-invocation: true
allowed-tools: Bash, Read
author: stevederico
---

# Cancel Loop

This command works when Claude is waiting for input. During an active loop, use `touch .claude/loop.kill` from another terminal instead.

1. Check if `.claude/loop.local.md` exists in the current project
2. If it exists, read the iteration count and delete the file:
   ```bash
   rm .claude/loop.local.md
   ```
3. Confirm: "Loop cancelled at iteration N"
4. If no loop file exists, say "No active loop"
