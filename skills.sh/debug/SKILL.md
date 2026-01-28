---
name: debug
description: Systematic error investigation and troubleshooting for React and Node.js
license: MIT
version: 1.0.0
---

# Debug Skill

Expert debugging specialist focused on systematically identifying and resolving software issues in React and Node.js applications.

## When to Use This Skill

Activate this skill when:
- Troubleshooting errors and unexpected behavior
- Investigating stack traces
- Analyzing network request failures
- Debugging React state issues
- Finding root causes of bugs
- Tracing infinite re-render loops

Do NOT use when:
- Doing code cleanup (use reviewer skill)
- Adding features (use frontend/backend skills)
- Security audits (use security skill)
- Writing documentation (use docs skill)

## Priority Matrix

| Priority | Category | Rules |
|----------|----------|-------|
| CRITICAL | Scientific Method | D01-D03 |
| HIGH | Error Analysis | D04-D07 |
| MEDIUM | Investigation Tools | D08-D10 |
| LOW | Logging Strategy | D11-D12 |

## Core Principles

### Priority: CRITICAL

**[D01] Scientific Method for Debugging**
- Observe the problem clearly
- Form a hypothesis about the cause
- Design a test to verify the hypothesis
- Execute the test and analyze results
- Repeat until root cause is found
- Never guess - always verify

**[D02] Understand Before Fixing**
- Reproduce the issue consistently first
- Isolate the problem to the smallest scope
- Check all assumptions with console.logs
- Fix the root cause, not symptoms

**[D03] Stack Trace Reading**
- First line: Error type and message (what went wrong)
- Second line: Where it happened (file, line, column)
- Remaining lines: Call stack (how we got there)
- Focus on YOUR code files, not library internals

### Priority: HIGH

**[D04] Common Error: "Cannot read property X of undefined"**
- Investigate where the undefined value comes from
- Check if data hasn't loaded yet (async timing)
- Verify API returned expected structure
- Add optional chaining: `user?.name`
- Add guard clauses: `if (!user) return <Loading />`

**[D05] Infinite Re-render Loop**
- Check for setState called directly in component body
- Verify useEffect has proper dependency array
- Look for object/array dependencies that recreate each render
- Use useMemo for object dependencies

**[D06] Network Request Failures**
- Log request URL, headers, and body
- Check response status, statusText, and headers
- Log error response body with `await response.text()`
- Check browser network tab for CORS errors
- Verify server is running and accessible

**[D07] State Not Updating**
- Never mutate state directly (creates same reference)
- Always create new arrays/objects: `setItems([...items, newItem])`
- Remember setState is async - use useEffect to see new value
- Check for stale closure capturing old state

### Priority: MEDIUM

**[D08] Strategic Log Placement**
- Entry point: Log function name and inputs
- Before external calls: Log what you're about to do
- After external calls: Log response/result
- At decision points: Log which path taken
- Exit point: Log final result

**[D09] Browser DevTools Usage**
- Console: Use console.group(), console.table(), console.time()
- Network tab: Inspect request/response headers, payload, timing
- React DevTools: Inspect component props, state, hooks
- Use conditional logging: `console.assert(condition, message)`

**[D10] Investigation Checklist**
1. Can you reproduce it consistently?
2. What are the exact steps?
3. What's the error message?
4. When did it start happening?
5. What changed recently?

### Priority: LOW

**[D11] Temporary Debug Code**
- Mark debug code clearly for easy removal
- Use `// DEBUG START` and `// DEBUG END` comments
- Remove all debug code before committing

**[D12] Debug Commands**
- `copy(object)` - Copy object to clipboard
- `$0` - Last selected DOM element
- `$r` - Last selected React component
- `getEventListeners(element)` - See all listeners

## Common Error Patterns

| Error | Common Cause |
|-------|--------------|
| "X is not a function" | Calling undefined or wrong type |
| "Cannot read property of undefined" | Missing null check, async timing |
| "Maximum update depth exceeded" | Infinite re-render loop |
| "Objects are not valid as React child" | Rendering object instead of primitive |
| "Each child should have unique key" | Missing or duplicate key in list |
| "Hook called conditionally" | Hook inside if/loop/nested function |
| "CORS error" | Server missing Access-Control headers |
| "Network request failed" | Server not running, wrong URL |

## Prohibited Practices

**[D-X01] Never make random changes** - Follow evidence
**[D-X02] Never delete code without understanding** - Understand why it fails
**[D-X03] Never ignore error messages** - They tell you what's wrong
**[D-X04] Never fix symptoms without root cause** - Find the real problem
**[D-X05] Never leave permanent console.logs** - Remove after debugging
**[D-X06] Never blame tools before checking code** - Usually it's your code

## Debugging Workflow

1. **Clarify the Problem** - What exactly is happening vs. what should happen?
2. **Reproduce** - Can you make it happen consistently?
3. **Gather Information** - Console errors, network tab, React DevTools, strategic logs
4. **Form Hypothesis** - What might be wrong based on evidence?
5. **Test Hypothesis** - Add logging to verify, make minimal change
6. **Fix and Verify** - Make the fix, verify bug is gone, check for new bugs

## References

See [references/debugging-guide.md](references/debugging-guide.md) for:
- Detailed stack trace examples
- React-specific debugging patterns
- Network debugging techniques
- Common pitfalls and solutions
