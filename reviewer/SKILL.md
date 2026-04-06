---
name: reviewer
description: Code review including refactoring, performance optimization, and best practices
license: MIT
version: 1.0.0
author: stevederico
---

# Code Reviewer Skill

Expert code reviewer combining three specializations: code quality/refactoring, performance optimization, and best practices enforcement.

## When to Use This Skill

Activate this skill when:
- Reviewing code quality and structure
- Identifying refactoring opportunities
- Analyzing performance bottlenecks
- Checking consistency with project patterns
- Ensuring accessibility standards
- Looking for code smells and anti-patterns

Do NOT use when:
- Adding new features (use frontend/backend skills)
- Fixing bugs (use debug skill first)
- Security audits (use security skill)

## Priority Matrix

| Priority | Category | Rules |
|----------|----------|-------|
| CRITICAL | Code Smells | CR01-CR04 |
| HIGH | Refactoring Techniques | CR05-CR08 |
| HIGH | Accessibility | CR14 |
| HIGH | Image Optimization | CR17 |
| MEDIUM | Performance | CR09-CR12 |
| LOW | Best Practices | CR13, CR15-CR16 |

## Core Principles

### Priority: CRITICAL

**[CR01] Code Smells to Identify**
- Functions/components too long (>50 lines is a smell)
- Too many parameters (>4 suggests using options object)
- Deeply nested conditionals (use early returns/guard clauses)
- Magic numbers/strings (use named constants)
- Duplicated code (extract shared functions)
- Similar components with minor differences (generalize)

**[CR02] When to Refactor**
- Code is difficult to understand or follow
- Same logic appears in multiple places
- Functions/components doing too many things
- Poor naming that doesn't convey intent
- Outdated patterns with better modern alternatives

**[CR03] React-Specific Smells**
- Prop drilling through many levels (use Context or composition)
- Huge components (>100 lines - decompose)
- Repeated useEffect patterns (extract custom hook)
- Inline object/function creation causing re-renders

**[CR04] Refactoring Philosophy**
- Improve structure without changing external behavior
- Make small, incremental improvements
- Each change independently verifiable
- Prioritize readability and maintainability
- Never introduce new packages during refactoring

### Priority: HIGH

**[CR05] Extract Function**
- When code block does one distinct thing, extract it
- Give it a clear, descriptive name
- Keep functions small and focused
- Example: Extract validation logic, calculation logic, formatting logic

**[CR06] Extract Component**
- When JSX section is self-contained, extract to component
- Give it clear props interface
- Make it reusable where possible
- Keep parent component simpler

**[CR07] Extract Custom Hook**
- When stateful logic is reused across components
- Prefix with 'use' (useToggle, useDebounce, useFetch)
- Return stable API with useCallback
- Makes logic testable and reusable

**[CR08] Simplify Conditionals**
- Replace nested if/else with early returns (guard clauses)
- Use lookup tables instead of complex if/else chains
- Extract complex conditions to named variables
- Replace imperative loops with declarative array methods

### Priority: MEDIUM

**[CR09] Performance - Unnecessary Re-renders**
- Inline object creation: `<Child style={{ color: 'red' }} />`
- Use useMemo for stable object references
- Use useCallback for stable function references
- Don't create new arrays/objects on every render

**[CR10] Performance - Memoization**
- Use useMemo for expensive calculations
- Use React.memo for components rendering often with same props
- Use useCallback for event handlers passed to children
- Don't overuse - only when actual performance benefit

**[CR11] Performance - useEffect Optimization**
- Correct dependency arrays (include all dependencies)
- Primitive dependencies preferred over object dependencies
- Use useMemo for object dependencies
- Always include cleanup functions for subscriptions/intervals

**[CR12] Performance - List Rendering**
- Use stable, unique keys (never index as key)
- Use item.id or similar unique identifier
- Consider virtualization for 100+ item lists (pagination/infinite scroll)

### Priority: HIGH

**[CR14] Accessibility Checks (MANDATORY)**
- [ ] Every page has a `<main>` landmark
- [ ] Semantic `<header>`, `<footer>`, `<nav>` used correctly
- [ ] `<Label>` connected via `htmlFor`/`id` on all form inputs
- [ ] `aria-label` on all icon-only buttons
- [ ] Escape key closes modals
- [ ] Focus trapping in dialogs (focus stays within modal while open)
- [ ] WCAG 2.1 AA contrast ratios met
- [ ] Dark backgrounds use `text-slate-400` minimum (not `text-slate-500`/`600`)
- [ ] Honor `prefers-reduced-motion` (disable/reduce animations)
- [ ] All images have meaningful alt text
- [ ] Buttons/links have descriptive text
- [ ] Color not the only indicator (use icons/text too)
- [ ] Interactive elements keyboard accessible
- [ ] Focus states visible
- [ ] Heading hierarchy logical (h1 → h2 → h3)

**[CR17] Image Optimization (MANDATORY)**
- [ ] Serve WebP with `<picture>` fallback to PNG/JPG for older browsers
- [ ] Explicit `width`/`height` attributes on all `<img>` (prevents CLS)
- [ ] Size images to 2x display size max (e.g., 176px display → 352px file)
- [ ] Meaningful `alt` text on every image
- [ ] Compress aggressively (`cwebp -q 85` for WebP; `sips -z` to resize on macOS)

### Priority: LOW

**[CR13] Consistency Checklist**
- [ ] Components use PascalCase (UserProfile, ProductCard)
- [ ] Functions/variables use camelCase (handleClick, isLoading)
- [ ] Constants use UPPER_SNAKE_CASE (API_URL, MAX_RETRIES)
- [ ] Boolean variables start with is/has/can (isActive, hasError)
- [ ] Event handlers prefixed with handle (handleSubmit, handleChange)

**[CR15] Mobile Responsiveness**
- [ ] Touch targets minimum 44x44px
- [ ] Text readable without zooming
- [ ] No horizontal scroll on mobile
- [ ] Forms usable on mobile keyboards
- [ ] Images scale properly
- [ ] Navigation works on small screens

**[CR16] Code Style**
- [ ] Consistent quote style (single/double)
- [ ] Consistent semicolon usage
- [ ] Consistent spacing and indentation
- [ ] No commented-out code
- [ ] Clear, descriptive variable names

## Refactoring Techniques

### Extract Function
```javascript
// Before
function processOrder(order) {
  // 20 lines of validation
  // 30 lines of calculation
  // 15 lines of database operations
}

// After
function validateOrder(order) { /* ... */ }
function calculateTotal(items) { /* ... */ }
function saveOrder(order) { /* ... */ }

function processOrder(order) {
  validateOrder(order)
  const total = calculateTotal(order.items)
  return saveOrder({ ...order, total })
}
```

### Simplify Conditionals
```javascript
// Before
if (user.isPremium) {
  if (order.total > 100) return 0.2
  else return 0.1
} else {
  if (order.total > 100) return 0.05
  else return 0
}

// After - Lookup table
const DISCOUNT = {
  premium: { high: 0.2, low: 0.1 },
  regular: { high: 0.05, low: 0 }
}
const tier = user.isPremium ? 'premium' : 'regular'
const size = order.total > 100 ? 'high' : 'low'
return DISCOUNT[tier][size]
```

### Extract Custom Hook
```javascript
// Before - Repeated in multiple components
const [isOpen, setIsOpen] = useState(false)
const open = () => setIsOpen(true)
const close = () => setIsOpen(false)
const toggle = () => setIsOpen(prev => !prev)

// After - Reusable hook
function useToggle(initial = false) {
  const [isOpen, setIsOpen] = useState(initial)
  const open = useCallback(() => setIsOpen(true), [])
  const close = useCallback(() => setIsOpen(false), [])
  const toggle = useCallback(() => setIsOpen(prev => !prev), [])
  return { isOpen, open, close, toggle }
}
```

## Review Workflow

When reviewing code:

1. **Correctness** - Does it do what it's supposed to? Edge cases handled?
2. **Code Quality** - Easy to understand? Code smells? Duplication? Clear names?
3. **Performance** - Unnecessary re-renders? Expensive calculations memoized? Bundle size?
4. **Consistency** - Follows project patterns? Naming consistent? Style consistent?
5. **Accessibility** - Keyboard navigation? Screen readers? Contrast?
6. **Security** - (Flag for security skill) Input validated? Injection risks?

## Review Output Format

**Summary:** One-line overall assessment

**Critical Issues:** (must fix)
- Issue, location, suggested fix

**Improvements:** (should fix)
- Issue, location, suggested fix

**Suggestions:** (nice to have)
- Enhancement ideas

**Positive Notes:**
- What's done well

## When NOT to Refactor

- Code is working and rarely touched
- Deadline pressure (schedule for later)
- Don't understand the code well enough
- No way to verify behavior is preserved
- The improvement is purely cosmetic

## Quality Checklist

After refactoring:
- [ ] External behavior unchanged
- [ ] Code easier to read and understand
- [ ] No new dependencies added
- [ ] Functions/components focused (single responsibility)
- [ ] No duplicated code remains
- [ ] Naming clear and descriptive
- [ ] Complex logic simplified or commented
- [ ] Follows existing project patterns

## Prohibited Practices

**[CR-X01] Never add new features during refactoring** - Separate concerns
**[CR-X02] Never add external packages** - Work with existing dependencies
**[CR-X03] Never change public APIs without discussion** - Breaking changes need approval
**[CR-X04] Never make large-scale changes without verification** - Incremental is safer
**[CR-X05] Never refactor critical code without tests** - Too risky

## References

See [references/refactoring-patterns.md](references/refactoring-patterns.md) for:
- Detailed refactoring examples
- Performance optimization techniques
- Common code smell patterns
- Before/after comparisons
