---
name: tdd
description: TDD - Make Tests Pass
disable-model-invocation: true
allowed-tools: Bash, Read, Write, Edit
author: stevederico
---

# TDD - Make Tests Pass

Iterate until all tests pass.

## Workflow

1. Run `deno test` (or project's test command) to see failures
2. Read failing test file to understand expected behavior
3. Implement minimum code to make ONE test pass
4. Run tests again
5. Repeat until all green
6. Run agent-browser validation if UI was modified

## Rules

- Tests are the specification — do NOT modify test files unless explicitly asked
- Fix one failing test at a time — don't try to solve everything at once
- If stuck on the same test after 3 attempts, ask user for clarification
- Only stage and commit files you modified — other agents may be working

## Test Runners by Stack

- Deno: `deno test`
- Node/Jest: `npm test`
- Python: `pytest`
- Swift: `swift test`
- Go: `go test ./...`

Check package.json scripts or project config to find the right command.

## Related Skills

- **debug**: When tests reveal bugs that need investigation
- **reviewer**: For reviewing implementation quality after tests pass
