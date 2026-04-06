---
name: arch-docs
description: >
  Deep dive into codebase architecture with text explanations.
  Use when the user says: "explain the architecture", "how does X work",
  "refresh my memory", "deep dive into", "explain this system",
  "I forgot how X works", "walk me through".
allowed-tools: Read, Glob, Grep
metadata:
  author: stevederico
  version: "1.1.0"
  argument-hint: <subsystem> or "question"
---

# arch-docs

You provide text-based architecture explanations and deep dives. Unlike arch-diagram (which generates visual HTML), you explain *how* things work and *why* they're built that way. Output is in-conversation markdown with file:line references.

---

## Workflow

### Step 1: Determine Scope

Parse the user's request to determine what they need:

| Input | Action |
|-------|--------|
| `/arch-docs` (no args) | Full system overview |
| `/arch-docs <subsystem>` | Deep dive into that subsystem |
| `/arch-docs "question"` | Answer the specific question |

**Discover subsystems** by reading the project's `docs/ARCHITECTURE.md`, `CLAUDE.md`, or scanning the directory structure for top-level modules.

### Step 2: Gather Context

1. **Check for existing docs:**
   - Read `docs/ARCHITECTURE.md` if it exists (canonical reference)
   - Read `docs/DECISIONS.md` if it exists (the "why" behind decisions)
   - Read `CLAUDE.md` for project-specific conventions

2. **For subsystem deep dives, read the relevant source files:**
   - Use Glob to find related files
   - Use Grep to trace function calls and data flow
   - Read key files to understand implementation

3. **Build a mental model:**
   - Identify entry points
   - Trace data flow through the system
   - Note key classes/functions and their responsibilities
   - Identify cross-cutting concerns (auth, logging, errors)

### Step 3: Generate Explanation

Structure your response based on scope:

**Full system overview:**
```markdown
## The Big Picture
[1-2 paragraph summary of what the system does]

## Architecture Diagram (ASCII)
[Simple box diagram showing major components]

## Key Components
[Table of components with one-line descriptions]

## Data Flow
[How a typical request flows through the system]

## Quick Reference
[Ports, key files, common commands]
```

**Subsystem deep dive:**
```markdown
## [Subsystem Name] — What It Does
[1 paragraph summary]

## How It Works
[Step-by-step walkthrough with file:line references]

## Key Files
[Table: file path | responsibility]

## Data Flow
[Trace a request/action through the subsystem]

## Why It's Built This Way
[Architectural decisions and tradeoffs]

## Common Tasks
[How to modify/debug this subsystem]
```

**Specific question:**
```markdown
## [Restate question as heading]

[Direct answer with file:line references]

[Code snippets if helpful]

[Related context they might need]
```

### Step 4: Include References

Always include concrete references:
- `file.js:123` — line numbers for key code
- Link related subsystems: "See also: `/arch-docs <related>`"
- Mention relevant decisions from `docs/DECISIONS.md`

### Step 5: Offer Follow-ups

End with suggested next steps:
```markdown
---
**Related deep dives:**
- `/arch-docs <related-subsystem>`
- `/arch-diagram` for visual representation
```

---

## Output Guidelines

1. **Be concrete** — Always reference actual files and line numbers
2. **Trace data flows** — Show how data moves through the system
3. **Explain the "why"** — Don't just describe, explain decisions
4. **Use ASCII diagrams** — Simple boxes and arrows for flows
5. **Keep it scannable** — Use tables, headers, bullet points
6. **Stay current** — Read actual code, don't rely on outdated docs

---

## Example Outputs

### `/arch-docs` (full overview)
```markdown
## The Big Picture

TaskFlow is a project management app with a React frontend and Hono API backend...

## Architecture

┌──────────────┐     ┌─────────────────────────┐
│   React App  │────▶│  Hono API (:8000)       │
│   (Vite)     │     │  ┌───────┐  ┌───────┐   │
└──────────────┘     │  │ Auth  │  │ Tasks │   │
                     │  │       │  │       │   │
                     │  └───────┘  └───────┘   │
                     │         │                │
                     │    ┌────▼────┐           │
                     │    │ SQLite  │           │
                     │    └─────────┘           │
                     └─────────────────────────┘

## Key Components
| Component | Path | Purpose |
|-----------|------|---------|
| API Server | backend/server.js | Routes, middleware, auth |
| Task Service | backend/services/tasks.js | CRUD operations |
| Database | backend/db/ | SQLite schema and queries |
| Frontend | src/components/ | React views and forms |
```

### `/arch-docs auth`
```markdown
## Auth — What It Does

Handles user registration, login, and session management via JWT tokens...

## How It Works

1. **Registration** (`backend/routes/auth.js:15`)
   - Validates email/password
   - Hashes password with bcrypt
   - Stores user in SQLite

2. **Login** (`backend/routes/auth.js:45`)
   - Verifies credentials
   - Issues JWT with 24h expiry
   - Returns token in response body

3. **Protected routes** (`backend/middleware/auth.js:8`)
   - Extracts Bearer token from Authorization header
   - Verifies JWT signature
   - Attaches user to request context
```

### `/arch-docs "how does the task assignment work?"`
```markdown
## How Does Task Assignment Work?

Tasks are assigned via `PATCH /api/tasks/:id` (`backend/routes/tasks.js:67`).

The assignment flow:
1. Client sends `{ assigneeId: "user-123" }`
2. Route handler validates assignee exists (`services/users.js:23`)
3. Updates task record in SQLite (`services/tasks.js:45`)
4. Returns updated task with assignee details

The frontend reflects this in `TaskCard.jsx:34` which shows
the assignee avatar when `task.assigneeId` is set.
```

---

## Maintaining Architecture Docs

When you make significant changes to the codebase:

1. Update `docs/ARCHITECTURE.md` with structural changes
2. Update `docs/DECISIONS.md` with new architectural decisions
3. These become the canonical reference for future `/arch-docs` calls
