<div align="center">
  <img src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZ2Fva3lwOG01aDN5ZDM4aXE3dmk3a3NnOWp3MnAzNHZkb2l1d3Y1MCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3o7btNhMBytxAM6YBa/giphy.gif" width="600" alt="Agent Skills">
</div>

# Agent Skills & Subagents

Specialized AI agents for software development.

## Overview

A collection of expert agents that handle specific development tasks: frontend work, backend APIs, debugging, security audits, and deployments. Each agent knows its domain deeply and executes autonomously.

Two distribution formats available. Use subagents with Claude Code or install as universal skills for other frameworks. Same expertise, different packaging.

## Available Agents

| Name | Description | Subagent | Skill |
|------|-------------|----------|-------|
| frontend | React 19 + Tailwind CSS + Vite | [frontend.md](frontend.md) | [skills.sh/frontend/](skills.sh/frontend) |
| backend | Node.js/Express API development | [backend.md](backend.md) | [skills.sh/backend/](skills.sh/backend) |
| debug | Error investigation & troubleshooting | [debug.md](debug.md) | [skills.sh/debug/](skills.sh/debug) |
| reviewer | Code review & refactoring | [reviewer.md](reviewer.md) | [skills.sh/reviewer/](skills.sh/reviewer) |
| security | OWASP Top 10 vulnerability detection | [security.md](security.md) | [skills.sh/security/](skills.sh/security) |
| docs | Stripe-style API documentation | [docs.md](docs.md) | [skills.sh/docs/](skills.sh/docs) |
| deployer | Railway platform deployment | [deployer.md](deployer.md) | [skills.sh/deployer/](skills.sh/deployer) |
| redteam | Challenge decisions with counter-arguments | [redteam.md](redteam.md) | [skills.sh/redteam/](skills.sh/redteam) |

## Usage

### Claude Code

Copy agent files to your subagents directory:

```bash
cp *.md ~/.claude/subagents/
```

Claude Code auto-selects the right agent based on your request. Ask to "build a login form" and it triggers the frontend agent. Say "investigate this API error" and the debug agent handles it.

### skills.sh

Install via package manager:

```bash
npx skills add stevederico/skills
```

Invoke agents with slash commands like `/frontend`, `/debug`, or `/security`. Each skill has the same capabilities as its subagent version.

## Core Features

**Frontend**: Builds React 19 apps with Vite, Tailwind CSS v4, and react-router-dom v7.2+. Implements shadcn/ui components, handles form validation, manages dark mode with proper theming, and reviews component architecture after changes.

**Backend**: Creates Node.js/Express APIs with authentication (JWT or sessions), designs SQLite/MongoDB schemas, writes middleware for validation and errors, follows security best practices.

**Debug**: Investigates errors by reading stack traces, analyzing network requests, tracing React renders, and finding root causes. Provides strategic debugging approaches instead of quick fixes.

**Reviewer**: Analyzes code quality, finds performance issues, suggests refactoring patterns, checks project consistency, extracts reusable code, ensures accessibility standards.

**Security**: Scans for OWASP Top 10 vulnerabilities (SQL injection, XSS, CSRF, auth issues, data exposure). Reviews authentication, validates sanitization, checks for hardcoded secrets.

**Docs**: Writes Stripe-style API documentation with detailed endpoints, complete request/response examples, error formats, and auth requirements.

**Deployer**: Handles Railway deployments including environment config, database provisioning, custom domains, CORS verification, and PORT variable setup.

**Redteam**: Challenges technical decisions with counter-arguments, exposes trade-offs, stress-tests assumptions, surfaces failure modes.

## Architecture

Each agent exists in two formats:

**Subagents**: Markdown files in the root directory that Claude Code's Task tool reads and spawns as specialized subprocesses.

**Skills**: Files in `skills.sh/*/SKILL.md` that work with any framework supporting the skills.sh spec.

Both contain identical expertise and behavior. The difference is invocation: subagents are automatic, skills use slash commands.

## License

MIT
