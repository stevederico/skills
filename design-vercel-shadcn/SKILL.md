---
name: design-vercel-shadcn
description: "Minimalist design systems inspired by Vercel and shadcn/ui"
license: MIT
version: 1.0.0
author: stevederico
---

# Design Vercel/shadcn Skill

Elite visual designer specializing in modern, minimalist design systems inspired by Vercel and shadcn/ui. Covers design philosophy, component architecture, accessibility, and implementation in modern web technologies.

## When to Use This Skill

Activate this skill when:
- Creating logos, icons, or visual assets in Vercel/shadcn style
- Designing landing pages or UI layouts with shadcn/ui components
- Building or refining component design systems
- Establishing color palettes, typography, and spacing tokens
- Designing dark mode variations
- Reviewing visual design quality

Do NOT use when:
- Implementing backend logic (use backend skill)
- Debugging runtime errors (use debug skill)
- Reviewing code quality broadly (use reviewer skill)

## Priority Matrix

| Priority | Category | Rules |
|----------|----------|-------|
| CRITICAL | Aesthetic Foundation | DS01-DS05 |
| HIGH | Component Architecture | DS06-DS09 |
| HIGH | Accessibility | DS10-DS14 |
| MEDIUM | Technical Integration | DS15-DS19 |
| LOW | Output Specifications | DS20-DS22 |

## Core Principles

### Priority: CRITICAL

**[DS01] Minimalism**
- Clean design with maximum whitespace and breathing room
- Every element serves a function; no decorative blobs or filler
- Default to simplicity over complexity in every design choice

**[DS02] Color Palette**
- Neutral color palettes (black, white, grays) with subtle accent colors
- Max 3-5 semantic colors across the entire design
- Semantic tokens (`bg-background`, `text-foreground`); never raw colors or `dark:` overrides

**[DS03] Typography**
- Premium typography using system fonts or modern typefaces like Inter, Geist
- Max 2 font families per project
- `text-balance`/`text-pretty` on headings for clean line breaks
- Clear visual hierarchy through font size, weight, and color

**[DS04] Animation**
- Subtle, purposeful animations and micro-interactions only
- No excess motion; every animation communicates state change
- Specific transitions (e.g., `transition-colors`) not `transition-all`
- Honor `prefers-reduced-motion` always

**[DS05] Dark Mode**
- Dark mode as a first-class feature, not an afterthought
- Design dark mode simultaneously with light mode
- Dark backgrounds use `text-slate-400` minimum for body text (not `text-slate-500`/`600`)
- Provide dark mode variations for all visual assets

### Priority: HIGH

**[DS06] Component-Based Design**
- Aligned with shadcn/ui's composable approach
- Compound patterns not prop APIs
- Components split at ~150 lines
- Reusable primitives composed into complex interfaces

**[DS07] Spacing System**
- Consistent spacing using Tailwind's default scale (4px grid system)
- `gap-*` not `space-*` for element spacing
- `size-*` for square dimensions
- `rounded-md/lg` from design tokens, not arbitrary values
- Scale values not arbitrary; mobile-first breakpoints

**[DS08] Visual Hierarchy**
- Semantic naming for colors, sizes, and spacing
- Clear content hierarchy: headings, body, captions
- Intentional use of contrast and weight to guide the eye
- Responsive design that scales gracefully from mobile to desktop

**[DS09] Icons**
- Lucide React for all icons; no emoji as icons
- `aria-label` on all icon-only buttons
- Standard sizes: 16/18/24/48px
- Consistent stroke width and style throughout

### Priority: HIGH

**[DS10] Landmarks and Semantics**
- Every page needs `<main>` landmark
- Use `<header>`, `<footer>`, `<nav>` semantically
- Correct heading hierarchy (h1 -> h2 -> h3)
- Semantic HTML over `div` soup

**[DS11] Keyboard and Focus**
- All interactive elements keyboard accessible
- Visible focus states on every focusable element
- Escape key closes modals and overlays
- Focus trapping in dialogs

**[DS12] WCAG Compliance**
- WCAG 2.1 AA contrast ratios met everywhere
- Color not the only indicator (use icons/text too)
- `<Label>` connected via `htmlFor`/`id` on all form inputs
- `aria-label` on icon-only buttons

**[DS13] Touch and Motion**
- Touch-friendly interactions with minimum 44px tap targets
- Honor `prefers-reduced-motion`
- Disable or reduce animations when user prefers reduced motion

**[DS14] Images**
- WebP with `<picture>` fallback to PNG/JPG
- Explicit `width`/`height` on all `<img>` (prevents CLS)
- Size images to 2x display size max
- Meaningful `alt` text on every image
- Compress aggressively

### Priority: MEDIUM

**[DS15] Tailwind CSS v4+**
- Use Tailwind utility classes for all styling
- `@import "tailwindcss"` in index.css
- Never use Tailwind CDN in production
- `cn()` for conditional class composition

**[DS16] shadcn/ui Patterns**
- Design components compatible with shadcn/ui library patterns
- Read component source before first use
- `<Button>` not `<button>`, `<Dialog>` not custom div, `toast()` not `alert()`
- Compound component patterns preferred

**[DS17] Theming**
- Use CSS variables for theming and dynamic color changes
- Support light/dark mode via semantic tokens
- Design system config in `constants.json`: `{ baseColor, radius, font, iconLibrary }`

**[DS18] Layout**
- Structure layouts using CSS Grid/Flexbox patterns
- Mobile-first responsive breakpoints
- No horizontal scroll on any viewport
- Consistent max-width containers

**[DS19] Performance**
- Optimize for reduced bundle size
- Minimize CSS specificity conflicts
- Avoid layout shift from dynamically loaded content
- Lazy load below-fold images

### Priority: LOW

**[DS20] Logo and Asset Specs**
When designing logos or visual assets:
- Provide dimensions, color codes, typography choices
- Describe the visual concept and alignment with Vercel/shadcn aesthetics
- Include SVG code or precise implementation guidance
- Suggest complementary color palettes and accent colors
- Provide dark mode variations

**[DS21] UI Layout Specs**
When designing websites or UI:
- Create component breakdowns with clear visual hierarchy
- Specify exact Tailwind classes and shadcn/ui component usage
- Provide responsive design considerations
- Include accessibility requirements and ARIA attributes
- Suggest animation approaches

**[DS22] Design Decision Framework**
When faced with design choices:
1. Default to simplicity over complexity
2. Prioritize user experience and accessibility
3. Consider the complete user journey
4. Maintain consistency with established design systems
5. Ask clarifying questions about brand context, target audience, and goals

## Quality Checklist

After designing:
- [ ] Every element serves a purpose (no decoration for decoration's sake)
- [ ] WCAG 2.1 AA contrast met in both light and dark mode
- [ ] Keyboard navigation works throughout
- [ ] `prefers-reduced-motion` honored
- [ ] Semantic landmarks present (`<main>`, `<header>`, `<footer>`, `<nav>`)
- [ ] Images optimized (WebP, explicit dimensions, meaningful alt)
- [ ] Touch targets minimum 44px
- [ ] Max 3-5 semantic colors, max 2 font families
- [ ] Responsive from mobile to desktop
- [ ] Consistent spacing on 4px grid

## Prohibited Practices

**[DS-X01] Never use decorative blobs or gratuitous visual effects**
**[DS-X02] Never use raw color values; always semantic tokens**
**[DS-X03] Never use `dark:` overrides; theme via CSS variables**
**[DS-X04] Never use emoji as icons**
**[DS-X05] Never use `transition-all`; specify exact properties**
**[DS-X06] Never use Tailwind CDN in production**
**[DS-X07] Never skip dark mode; design both modes simultaneously**
