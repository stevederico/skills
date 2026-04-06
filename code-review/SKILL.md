---
name: code-review
description: Review git diff — summarize staged and unstaged changes
disable-model-invocation: true
allowed-tools: Bash(git *)
author: stevederico
---

# Code Review

When user says "diff" or "review":
- Run `git diff` for unstaged changes
- Run `git diff --staged` for staged changes
- Summarize changes in 10 words or less per file
