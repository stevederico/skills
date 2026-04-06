---
name: frontend
description: "React 19 + Tailwind CSS v4 + Vite 7.1 frontend development. Also use when the user mentions 'build a component,' 'add a page,' 'fix the UI,' 'responsive layout,' 'form validation,' 'dark mode,' 'styling,' 'Tailwind,' 'shadcn,' or 'user interface.' Use this even if the user just says 'make it look better' or 'add a button that...'"
license: MIT
version: 1.0.0
author: stevederico
---

# Frontend Development Skill

Expert frontend engineer specializing in modern React development with clean, maintainable component architecture using React 19+, Vite 7.1+, and Tailwind CSS v4+.

## When to Use This Skill

Activate this skill when:
- Creating or modifying React components
- Implementing UI features
- Designing user interfaces
- Adding Tailwind CSS styling
- Building forms with validation
- Working on responsive layouts
- Improving UI/UX design patterns

Do NOT use when:
- Backend API work (use backend skill)
- Security audits (use security skill)
- Writing documentation (use docs skill)

## Priority Matrix

| Priority | Category | Rules |
|----------|----------|-------|
| CRITICAL | React & Architecture | F01-F04 |
| HIGH | Tailwind & Styling | F05-F08 |
| HIGH | Accessibility | F12-F14 |
| MEDIUM | Performance | F09-F11 |

## Core Principles

### Priority: CRITICAL

**[F01] Modern React Stack**
- Always use React 19 or newer with functional components and hooks
- Always use Vite 7.1+ as build tool
- Always use react-router-dom v7.9+ for routing
- Always use JavaScript (never TypeScript)
- Always use ES modules (import/export syntax)
- Never use require() for imports
- Use Deno for package management (never `npm install`)
- Kill port 5173 if occupied before starting dev server

**[F02] Native-First Development**
- Check if native browser APIs can accomplish the task before adding packages
- Use native fetch() for HTTP requests (no axios, ky, superagent)
- Use native localStorage/sessionStorage (no store.js for simple cases)
- Use native URLSearchParams (no query-string package)
- Use native Intl.DateTimeFormat (no moment/date-fns for simple formatting)
- Use native Clipboard API (no clipboard libraries)
- Use React useId hook for unique IDs (no uuid for component IDs)

**[F03] Component-First Design**
- Break UI into small, focused, reusable components
- Each component should have single responsibility
- Prefer composition over prop drilling
- Use custom hooks to extract and share stateful logic
- Keep components flat and readable

**[F04] Tailwind CSS v4+ Only**
- Add `@import "tailwindcss"` to index.css
- Use @tailwindcss/vite plugin
- Style using utility classes directly on elements
- Use semantic tokens (`bg-background`, `text-foreground`) — never raw colors or `dark:` overrides
- Never use postcss, autoprefixer, or tailwind.config.js
- Never use Tailwind CDN (`cdn.tailwindcss.com`) in production — it compiles in-browser

### Priority: HIGH

**[F05] Styling Approach**
- Apply utility classes directly to JSX elements
- Use responsive prefixes mobile-first (sm:, md:, lg:, xl:, 2xl:)
- Use state variants (hover:, focus:, active:, disabled:)
- Use `gap-*` not `space-*`; `size-*` for squares; `rounded-md/lg` from tokens
- Use `text-balance`/`text-pretty` on headings
- Use specific transitions not `transition-all`
- No decorative blobs; max 3-5 semantic colors; max 2 font families
- Scale values not arbitrary; `cn()` for conditionals

**[F06] Dark Mode Support**
- Always include dark mode variants for backgrounds, text, borders
- Use bg-background for primary backgrounds
- Use bg-accent for accent/highlight backgrounds
- Ensure sufficient contrast in both light and dark modes

**[F07] Responsive Design**
- Mobile-first approach (base styles, then sm:, md:, lg:)
- Test layouts at all breakpoints
- Use flexbox and grid utilities for layout
- Ensure touch targets are at least 44x44px on mobile

**[F08] State Management**
- Use useState for component-level state
- Use useEffect sparingly with proper dependencies
- Use useCallback for event handlers passed to children
- Use useMemo for expensive computations
- Create custom hooks for reusable stateful logic (prefix with 'use')
- Keep state close to where it's used

**[F08a] Icons**
- Use Lucide React for all icons; no emoji as icons
- Add `aria-label` on icon-only buttons
- Icon sizes: 16/18/24/48px only

**[F08b] UI Components**
- If `@stevederico/skateboard-ui` is installed, import from `@stevederico/skateboard-ui/shadcn/ui/<component>`
- Read component source before first use; use compound patterns not prop APIs
- Use `<Button>` not `<button>`, `<Dialog>` not custom div, `toast()` not `alert()`

### Priority: MEDIUM

**[F09] Performance - Avoid Unnecessary Re-renders**
- Don't create objects/arrays inline for props: `<Child style={{ color: 'red' }} />`
- Use useMemo for stable object references
- Use useCallback for stable function references
- Use proper dependency arrays in useEffect

**[F10] Performance - Memoization**
- Use useMemo for expensive calculations
- Use React.memo for components that render often with same props
- Don't overuse memo - only when there's actual performance benefit

**[F11] List Rendering**
- Always use stable, unique keys (never index)
- Use item.id or similar unique identifier
- Consider virtualization for 100+ item lists

### Priority: HIGH

**[F12] Semantic HTML & Landmarks**
- Use proper heading hierarchy (h1-h6)
- Use semantic elements (`<nav>`, `<main>`, `<article>`, `<aside>`, `<header>`, `<footer>`)
- Every page needs a `<main>` landmark
- Use `<Label>` via `htmlFor`/`id` for form inputs
- Add `aria-label` on icon-only buttons
- Escape closes modals; implement focus trapping

**[F13] Keyboard Navigation**
- All interactive elements must be keyboard accessible
- Visible focus indicators on all focusable elements
- Logical tab order
- Support common keyboard shortcuts

**[F14] Color & Contrast (WCAG 2.1 AA)**
- Minimum 4.5:1 contrast ratio for normal text
- Minimum 3:1 contrast ratio for large text
- Dark backgrounds: `text-slate-400` minimum for body text (not `text-slate-500`/`600`)
- Don't rely solely on color to convey information
- Test contrast in both light and dark modes
- Honor `prefers-reduced-motion`

## Form Handling

**[F15] Form Best Practices**
- Use controlled components with useState
- Implement real-time validation with clear error messages
- Show validation feedback on blur and submit, not every keystroke
- Disable submit buttons during async operations
- Clear validation errors when users correct inputs
- Use appropriate input types (email, tel, number)

## Images (MANDATORY)

**[F16] Image Best Practices**
- Always serve WebP with `<picture>` fallback to PNG/JPG for older browsers
- Explicit `width`/`height` attributes on all `<img>` to prevent layout shift (CLS)
- Size images to 2x display size max (e.g., 176px display = 352px file), not larger
- Meaningful `alt` text on all images

## Prohibited Practices

**[F-X01] Never use TypeScript** - JavaScript only
**[F-X02] Never use ESLint** - No ESLint packages or globals package
**[F-X03] Never use @types packages** - No TypeScript types
**[F-X04] Never run delete/move commands** - File safety
**[F-X05] Never use postcss or tailwind.config.js** - Tailwind v4 doesn't need them

## Native Alternatives Reference

See [references/native-alternatives.md](references/native-alternatives.md) for:
- HTTP requests with fetch
- Form handling without libraries
- Local storage usage
- URL manipulation
- Date formatting
- Clipboard access
- Debouncing without lodash
- Click outside detection
- Animation with Tailwind

## When External Packages ARE Justified

- Complex state management across large apps (consider Context first)
- Rich text editing (TipTap, Slate)
- Data visualization (D3.js, Recharts)
- Complex forms with extensive validation rules
- Specialized tasks native APIs can't handle efficiently

## Component Architecture

**File Organization:**
- Place components in descriptive files (ProductCard.jsx, UserProfile.jsx)
- Co-locate related components when tightly coupled
- Use clear, semantic naming that reflects purpose

**Hooks Usage:**
- useState for component-level state
- useEffect sparingly with proper dependencies
- useCallback for event handlers passed to children
- useMemo for expensive computations
- useRef for DOM references and mutable values
- Custom hooks for reusable stateful logic

## Quality Standards

**Readability:**
- Write self-documenting code with clear names
- Keep functions small and focused
- Use destructuring for props and state
- Format JSX with proper indentation
- Add comments only for complex logic

**Error Handling:**
- Wrap async operations in try-catch blocks
- Provide fallback UI for error states
- Log errors appropriately for debugging
- Never leave users in broken states

## Implementation Workflow

1. **Understand Requirements** - Component purpose, props, state needs, interactions
2. **Design Structure** - Plan component hierarchy and data flow
3. **Build Incrementally** - Start with basic structure, add state, add styling, add validation
4. **Verify Quality** - Test interactivity, responsive behavior, dark mode, accessibility
5. **Optimize** - Remove unnecessary code, ensure efficient re-renders

## Task-Specific Questions

1. New component or modifying an existing one?
2. Does this need dark mode support?
3. Mobile-first or desktop-focused?
4. Any specific shadcn/ui components to use?
5. Is there an existing design or mockup to match?

## Output Format

Structure deliverables as:
1. **Component Hierarchy** — parent/child structure if multiple components
2. **Implementation** — component code with Tailwind styling
3. **Verification** — responsive behavior, dark mode, accessibility checks

## Related Skills

- **backend**: For API endpoints the frontend consumes
- **design-vercel-shadcn**: For design system decisions and visual direction
- **reviewer**: For code review and performance optimization
