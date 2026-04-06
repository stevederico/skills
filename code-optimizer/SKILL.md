---
name: code-optimizer
description: "Reduce code complexity, eliminate dead code, consolidate duplicate logic. Also use when the user mentions 'dead code,' 'unused functions,' 'duplicated logic,' 'too complex,' 'simplify this,' 'consolidate,' 'reduce bundle size,' 'clean up,' or 'refactor for maintainability.' Use this even if the user just says 'this feels bloated' or 'there must be dead code in here.'"
license: MIT
version: 1.0.0
author: stevederico
---

# Code Optimizer Skill

Expert code optimizer with deep expertise in software architecture, design patterns, and clean code principles. Makes codebases leaner, more maintainable, and easier to extend without breaking existing functionality.

## When to Use This Skill

Activate this skill when:
- Reducing code complexity or eliminating dead code
- Consolidating duplicate logic into reusable utilities
- Refactoring after completing a feature
- Codebase feels bloated or hard to navigate
- Identifying unused exports, imports, or functions

Do NOT use when:
- Adding new features (use frontend/backend skills)
- Reviewing code quality broadly (use reviewer skill)
- Debugging issues (use debug skill)

## Priority Matrix

| Priority | Category | Rules |
|----------|----------|-------|
| CRITICAL | Core Principles | CO01-CO03 |
| HIGH | Dead Code Detection | CO04-CO07 |
| HIGH | Consolidation Strategies | CO08-CO11 |
| MEDIUM | Refactoring Patterns | CO12-CO15 |
| LOW | Utility Creation | CO16-CO18 |

## Core Principles

### Priority: CRITICAL

**[CO01] Preserve Functionality**
- Never remove or alter user-facing behavior
- Every optimization must be functionally equivalent
- Verify behavior before and after each change

**[CO02] Reduce, Don't Remove**
- Eliminate redundancy, not features
- Simplify without sacrificing capability
- Less code is better only when it does the same job

**[CO03] Measure Twice, Cut Once**
- Verify code is truly dead before removal
- Trace all usages across imports, exports, and dynamic references
- When uncertain, investigate further rather than remove

### Priority: HIGH

**[CO04] Unused Functions and Variables**
- Identify functions never called from any code path
- Find variables assigned but never read
- Detect parameters accepted but never used
- Trace through re-exports and barrel files

**[CO05] Unreachable Code Paths**
- Find conditions that always evaluate the same way
- Detect code after unconditional returns or throws
- Identify obsolete feature flags and their guarded code

**[CO06] Commented-Out Code**
- Remove commented-out code blocks (git has history)
- Distinguish comments from disabled code
- Preserve meaningful TODO/FIXME annotations

**[CO07] Orphaned Assets**
- Find unused CSS classes and styles
- Detect orphaned components not rendered anywhere
- Identify unused imports that add to bundle size

### Priority: HIGH

**[CO08] Extract Shared Utilities**
- Extract repeated logic into shared functions
- Identify 3+ occurrences as strong utility candidates
- Group related utilities into cohesive modules

**[CO09] Higher-Order Functions**
- Create higher-order functions for common patterns
- Wrap shared behavior (logging, error handling, caching)
- Keep the abstraction simple and documented

**[CO10] Merge Similar Components**
- Generalize similar components with configurable props
- Avoid merging when differences are fundamental, not cosmetic
- Keep the merged component under 150 lines

**[CO11] Consolidate API Calls**
- Merge duplicate API calls and data transformations
- Centralize shared fetch logic into service modules
- Eliminate redundant data normalization steps

### Priority: MEDIUM

**[CO12] Replace Verbose Conditionals**
- Use lookup objects or maps instead of long if/else chains
- Convert switch statements to object lookups where cleaner
- Extract complex conditions into named boolean variables

**[CO13] Modernize Async Patterns**
- Convert callback chains to async/await
- Replace `.then()` chains with await sequences
- Consolidate sequential awaits into `Promise.all` when independent

**[CO14] Extract Constants**
- Replace magic numbers and strings with named constants
- Group related constants into configuration objects
- Use UPPER_SNAKE_CASE for constant names

**[CO15] Flatten Nested Code**
- Simplify nested ternaries into early returns
- Flatten deeply nested code with guard clauses
- Reduce indentation levels (max 3 levels deep)

### Priority: LOW

**[CO16] Utility Design**
- Create pure, testable utility functions (no side effects)
- Accept inputs as parameters, return outputs explicitly
- Keep utilities small and single-purpose

**[CO17] Utility Organization**
- Group related utilities into cohesive modules
- Export only what other modules need
- Name utility files by domain (e.g., `formatters.js`, `validators.js`)

**[CO18] Utility Documentation**
- Document utility functions with clear parameter/return descriptions
- Include usage examples for non-obvious utilities
- Specify edge case behavior

## Optimization Workflow

1. **Analyze** - Read and understand the target code thoroughly
2. **Map Dependencies** - Trace imports, exports, and function calls
3. **Identify Opportunities** - List specific optimizations with line references
4. **Verify Safety** - Confirm no functionality will be lost
5. **Implement** - Apply changes incrementally
6. **Validate** - Ensure the optimized code produces identical results

## Output Format

For each optimization, provide:
- **What**: Specific change being made
- **Why**: Benefit (reduced lines, improved readability, easier maintenance)
- **Before/After**: Code snippets showing the transformation
- **Risk Assessment**: Low/Medium/High with justification

## Quality Checklist

After optimizing:
- [ ] All imports/exports still resolve correctly
- [ ] No runtime errors introduced
- [ ] Functionality remains identical
- [ ] Code is more readable, not just shorter
- [ ] New utilities are properly exported and documented
- [ ] No dynamically referenced code was removed

## Prohibited Practices

**[CO-X01] Never remove dynamically referenced code** - Check for string-based lookups, reflection, and dynamic imports
**[CO-X02] Never break circular dependencies blindly** - Understand the dependency graph before restructuring
**[CO-X03] Never over-abstract** - Simple code should stay simple; don't create complex utilities for one-off logic
**[CO-X04] Never optimize without context** - Understand the full codebase before making sweeping changes
**[CO-X05] Never change public API signatures** - External consumers depend on existing interfaces

## Task-Specific Questions

1. Target specific files/directories or scan the whole project?
2. Should the public API (exports, function signatures) be preserved?
3. Any known dead code or unused features?
4. Are there performance concerns driving this optimization?
5. Is this post-feature cleanup or proactive maintenance?

## Output Format

For each optimization:

| What | Why | Before | After | Risk |
|------|-----|--------|-------|------|
| Change description | Benefit | Code snippet | Code snippet | Low/Med/High |

Then: Summary of total lines removed, files changed, and risk assessment.

## Related Skills

- **reviewer**: For broader code quality review
- **frontend**: For implementing component-level optimizations
- **backend**: For implementing server-side optimizations
