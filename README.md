<div align="center">
  <img src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZ2Fva3lwOG01aDN5ZDM4aXE3dmk3a3NnOWp3MnAzNHZkb2l1d3Y1MCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3o7btNhMBytxAM6YBa/giphy.gif" width="600" alt="Agent Skills">
</div>

# Agent Skills & Subagents

Specialized AI agents for software development.

## Overview

A collection of expert agents that handle specific development tasks: frontend work, backend APIs, debugging, security audits, code optimization, design systems, and deployments. Each agent knows its domain deeply and executes autonomously.

Two distribution formats available. Use subagents with Claude Code or install as universal skills for other frameworks. Same expertise, different packaging.

## Available Agents

| Name | Description | Skill | Subagent |
|------|-------------|-------|----------|
| frontend | React 19 + Tailwind CSS v4 + Vite 7.1 | [frontend/](frontend) | [subagents/frontend.md](subagents/frontend.md) |
| backend | Node.js/Hono API development | [backend/](backend) | [subagents/backend.md](subagents/backend.md) |
| debug | Error investigation & troubleshooting | [debug/](debug) | [subagents/debug.md](subagents/debug.md) |
| reviewer | Code review & refactoring | [reviewer/](reviewer) | [subagents/reviewer.md](subagents/reviewer.md) |
| security | OWASP Top 10 vulnerability detection | [security/](security) | [subagents/security.md](subagents/security.md) |
| docs | Stripe-style API documentation | [docs/](docs) | [subagents/docs.md](subagents/docs.md) |
| deployer | Railway platform deployment | [deployer/](deployer) | [subagents/deployer.md](subagents/deployer.md) |
| redteam | Challenge decisions with counter-arguments | [redteam/](redteam) | [subagents/redteam.md](subagents/redteam.md) |
| code-optimizer | Dead code, deduplication, consolidation | [code-optimizer/](code-optimizer) | [subagents/code-optimizer.md](subagents/code-optimizer.md) |
| design-vercel-shadcn | Vercel/shadcn minimalist design systems | [design-vercel-shadcn/](design-vercel-shadcn) | [subagents/design-vercel-shadcn.md](subagents/design-vercel-shadcn.md) |
| domain-whois | Domain availability via WHOIS/RDAP | [domain-whois/](domain-whois) | — |
| arch-docs | Architecture explanations and deep dives | [arch-docs/](arch-docs) | — |

## Usage

### Skills

Install via package manager:

```bash
npx skills add stevederico/skills
```

Invoke agents with slash commands like `/frontend`, `/debug`, or `/security`. Each skill has its own `SKILL.md` with priority matrices and structured rule IDs.

### Claude Code Subagents

Copy agent files to your subagents directory:

```bash
cp subagents/*.md ~/.claude/agents/
```

Claude Code auto-selects the right agent based on your request. Ask to "build a login form" and it triggers the frontend agent. Say "investigate this API error" and the debug agent handles it.

## Core Features

**Frontend**: Builds React 19 apps with Vite 7.1, Tailwind CSS v4, and react-router-dom v7.9+. Implements shadcn/ui components, handles form validation, manages dark mode with semantic tokens, enforces WCAG 2.1 AA accessibility, and optimizes images.

**Backend**: Creates Node.js/Hono APIs with authentication (JWT or sessions), designs SQLite/MongoDB schemas, writes middleware for validation and errors, enforces rate limiting with exponential backoff and circuit breakers.

**Debug**: Investigates errors by reading stack traces, analyzing network requests, tracing React renders, and finding root causes. Provides strategic debugging approaches instead of quick fixes.

**Reviewer**: Analyzes code quality, finds performance issues, suggests refactoring patterns, checks project consistency, enforces WCAG 2.1 AA accessibility standards, and audits image optimization.

**Security**: Scans for OWASP Top 10 vulnerabilities (SQL injection, XSS, CSRF, auth issues, data exposure). Reviews authentication, validates sanitization, checks for hardcoded secrets, audits external API safety.

**Docs**: Writes Stripe-style API documentation with detailed endpoints, complete request/response examples, error formats, and auth requirements.

**Deployer**: Handles Railway deployments including environment config, database provisioning, custom domains, CORS verification, and production verification.

**Redteam**: Challenges technical decisions with counter-arguments, exposes trade-offs, stress-tests assumptions, surfaces failure modes.

**Code Optimizer**: Reduces code complexity, eliminates dead code, consolidates duplicate logic, creates reusable utilities without changing functionality.

**Design**: Creates minimalist, modern design systems inspired by Vercel and shadcn/ui with Tailwind CSS v4, semantic tokens, Lucide icons, and accessibility-first principles.

**Domain WHOIS**: Checks domain availability across 12 TLDs (.com, .net, .org, .io, .dev, .app, .co, .xyz, .ai, .shop, .site, .tech) via direct WHOIS and RDAP lookups. No external API dependency.

**Arch Docs**: Deep dives into codebase architecture with text explanations. Reads source code, traces data flows, and explains how systems work and why they're built that way. Outputs markdown with file:line references.

## Related Projects

- [AGENTS.md](https://github.com/stevederico/agents-md) — Prompts for writing code with LLMs, Deno, Vite, React 19+

## Companion Skills

Standalone skills that pair well with this collection:

| Name | Description | Install |
|------|-------------|---------|
| [cartographer](https://github.com/stevederico/cartographer) | Architecture diagram generator | `npx skills add stevederico/cartographer` |

## Architecture

Each agent exists in two formats:

**Skills**: Folders at the project root with `SKILL.md` files containing priority matrices, rule IDs, and structured guidance. Works with any framework supporting the skills spec.

**Subagents**: Markdown files in `subagents/` that Claude Code reads and spawns as specialized workers. Includes model and color configuration in frontmatter.

Both contain identical expertise and behavior. The difference is invocation: subagents are automatic, skills use slash commands.

## License

MIT
