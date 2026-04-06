---
name: backend
description: "Node.js/Hono backend development with native-first approach. Also use when the user mentions 'create an API,' 'add an endpoint,' 'build a REST API,' 'database schema,' 'server-side,' 'middleware,' 'route handler,' or 'backend logic.' Use this even if the user just says 'I need an API for...' or 'add a POST route.'"
license: MIT
version: 1.0.0
author: stevederico
---

# Backend Development Skill

Expert Node.js backend engineering with Hono, focusing on clean, component-based architecture with minimal dependencies.

## When to Use This Skill

Activate this skill when:
- Creating or modifying Node.js backend code with Hono
- Building REST APIs
- Implementing database operations (SQLite/MongoDB)
- Structuring backend components
- Refactoring existing server-side code

Do NOT use when:
- Working on React/UI (use frontend skill)
- Security audits (use security skill)
- Writing documentation (use docs skill)
- Troubleshooting errors (use debug skill)

## Priority Matrix

| Priority | Category | Rules |
|----------|----------|-------|
| CRITICAL | Native-First Development | B01-B03 |
| HIGH | Database & API Design | B04-B06 |
| MEDIUM | Runtime & Security | B07-B08 |
| LOW | Code Organization | B09-B12 |

## Core Principles

### Priority: CRITICAL

**[B01] Native-First Development**
- Always check if native Node.js can accomplish the task before adding packages
- Use native `fetch()` for HTTP requests (no axios, node-fetch, got, request)
- Use native `fs/promises` for file operations (no fs-extra)
- Use native `crypto` for hashing/encryption (no bcryptjs when native works)
- Use native `path`, `url`, `querystring` modules
- Ask: "Can I do this with native Node.js?" before adding any package

**[B02] ES Modules Only**
- Always use `import/export` syntax
- Never use `require()` for imports
- Ensure package.json has `"type": "module"`

**[B03] Component-Based Architecture**
- Design reusable, modular components that do one thing well
- Keep route handlers thin - delegate business logic to service modules
- Group related functionality into logical service layers
- Export functions and middleware that can be easily imported and reused

### Priority: HIGH

**[B04] Database Strategy**
- First choice: SQLite for lightweight, embedded database needs
- Alternative: MongoDB when SQLite is insufficient
- When using MongoDB, always use native `mongodb` package - never Mongoose
- Write direct SQL queries for SQLite - no ORM layers
- Use parameterized queries to prevent SQL injection

**[B05] RESTful API Design**
- Use standard HTTP methods: GET (read), POST (create), PUT/PATCH (update), DELETE (remove)
- Structure URLs: `/api/resource` for collections, `/api/resource/:id` for specific items
- Return appropriate status codes: 200 (OK), 201 (Created), 400 (Bad Request), 404 (Not Found), 500 (Server Error)
- Use JSON for all request/response bodies
- Include proper error messages in consistent format: `{ error: "Description" }`

**[B06] Error Handling**
- Use try/catch for all asynchronous operations
- Return meaningful error messages to clients
- Never expose stack traces in production responses
- Log errors server-side for debugging

### Priority: MEDIUM

**[B07] Runtime & Package Management**
- Use Deno v2.2+ for package management
- Install packages with: `deno install` (never `npm install`)
- Run with: `deno run start` or `deno run dev`
- Always run `deno install` before starting the server
- Kill port 8000 if occupied before starting the server

**[B08] Security Practices**
- Store secrets in environment variables (never hardcode)
- Validate and sanitize all user inputs
- Use parameterized queries for all database operations
- Never log credentials, tokens, or secrets

### Priority: LOW

**[B09] Code Quality**
- Write self-documenting code with clear variable and function names
- Keep functions small and focused on single responsibilities
- Use async/await for all asynchronous operations
- Add comments only when logic is not self-evident

**[B10] Project Structure**
- Organize code: `server.js` (entry), `routes/`, `services/`, `db/`, `middleware/`
- One concern per module
- Co-locate related functionality

**[B11] External API Safety**
- Exponential backoff on 429/5xx responses (1s, 2s, 4s, 8s — max 3-5 retries)
- Never loop without throttling; never call batch endpoints in a loop
- Circuit breaker after 3 consecutive external API failures
- Log rate limit headers; read API docs before writing integration

**[B12] Error Handling**
- Handle errors at system boundaries; never swallow errors
- Toast for transient errors, inline for forms, empty states for failed fetches
- Human-readable messages with recovery actions
- Loading indicators for operations >200ms
- Graceful degradation when external services fail

## Prohibited Practices

**[B-X01] Never use TypeScript** - Only vanilla JavaScript
**[B-X02] Never use ESLint** - No ESLint packages or globals package
**[B-X03] Never use dotenv** - Use native env var loading
**[B-X04] Never use `require()`** - ES modules only
**[B-X05] Never install @types packages** - No TypeScript types
**[B-X06] Never use Mongoose** - Use native MongoDB driver only
**[B-X07] Never read .env files** - Security restriction
**[B-X08] Never execute delete/move commands** - File safety
**[B-X09] Never use axios** - Native fetch only

## When External Packages ARE Justified

Only add packages when native Node.js truly cannot handle the task:
- Complex validation (zod, valibot for comprehensive rules)
- Database drivers (better-sqlite3, mongodb native driver)
- Authentication (jsonwebtoken for JWT, bcrypt for password hashing)
- Framework essentials (hono middleware)
- Specialized tasks native APIs can't handle efficiently

## Native Alternatives Reference

See [references/native-apis.md](references/native-apis.md) for detailed examples of:
- HTTP requests with native fetch
- File operations with fs/promises
- URL parsing with native URL/URLSearchParams
- UUID generation with crypto.randomUUID()
- Hashing with native crypto
- Date/time with native Date and Intl APIs

## Implementation Workflow

1. **Understand Requirements**: Clarify the endpoint purpose, data flow, and expected behavior
2. **Design Components**: Identify reusable services and middleware needed
3. **Implement Routes**: Create clear, RESTful endpoints
4. **Add Business Logic**: Build service functions with proper error handling
5. **Database Integration**: Implement queries with appropriate connection management
6. **Test Manually**: Verify endpoints work as expected
7. **Review**: Ensure code follows all requirements and prohibitions

## Task-Specific Questions

1. What endpoints or resources are needed?
2. SQLite or MongoDB? (SQLite is default unless specified)
3. Does this need authentication or authorization?
4. Are there existing routes or patterns in the project to follow?
5. Any external APIs this needs to integrate with?

## Output Format

Structure deliverables as:
1. **Endpoint Summary** — table of method, path, purpose
2. **Implementation** — routes, services, middleware in order
3. **Database** — schema or collection design if applicable

## Related Skills

- **frontend**: For React UI that consumes these APIs
- **deployer**: For deploying the backend to Railway
- **security**: For auditing authentication and input validation
- **docs**: For documenting the API endpoints
