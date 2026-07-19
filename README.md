<div align="center">
  <img src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZ2Fva3lwOG01aDN5ZDM4aXE3dmk3a3NnOWp3MnAzNHZkb2l1d3Y1MCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3o7btNhMBytxAM6YBa/giphy.gif" width="600" alt="Agent Skills">
</div>

# Agent Skills & Subagents

Specialized AI agents for software development.

## Overview

A collection of expert agents that handle specific development tasks: security audits, code optimization, and design systems. Each agent knows its domain deeply and executes autonomously.

Two distribution formats available. Use subagents with Claude Code or install as universal skills for other frameworks. Same expertise, different packaging.

## Available Agents

| Name | Description | Skill | Subagent |
|------|-------------|-------|----------|
| security | OWASP Top 10 vulnerability detection | [security/](security) | [subagents/security.md](subagents/security.md) |
| docs | Stripe-style API documentation | [docs/](docs) | [subagents/docs.md](subagents/docs.md) |
| redteam | Challenge decisions with counter-arguments | [redteam/](redteam) | [subagents/redteam.md](subagents/redteam.md) |
| code-optimizer | Dead code, deduplication, consolidation | [code-optimizer/](code-optimizer) | [subagents/code-optimizer.md](subagents/code-optimizer.md) |
| design-vercel-shadcn | Vercel/shadcn minimalist design systems | [design-vercel-shadcn/](design-vercel-shadcn) | [subagents/design-vercel-shadcn.md](subagents/design-vercel-shadcn.md) |

## Usage

### Skills

Install via package manager:

```bash
npx skills add stevederico/skills
```

Invoke agents with slash commands like `/security`. Each skill has its own `SKILL.md` with priority matrices and structured rule IDs.

### Claude Code Subagents

Copy agent files to your subagents directory:

```bash
cp subagents/*.md ~/.claude/agents/
```

Claude Code auto-selects the right agent based on your request.

## Core Features

**Security**: Scans for OWASP Top 10 vulnerabilities (SQL injection, XSS, CSRF, auth issues, data exposure). Reviews authentication, validates sanitization, checks for hardcoded secrets, audits external API safety.

**Docs**: Writes Stripe-style API documentation with detailed endpoints, complete request/response examples, error formats, and auth requirements.

**Redteam**: Challenges technical decisions with counter-arguments, exposes trade-offs, stress-tests assumptions, surfaces failure modes.

**Code Optimizer**: Reduces code complexity, eliminates dead code, consolidates duplicate logic, creates reusable utilities without changing functionality.

**Design**: Creates minimalist, modern design systems inspired by Vercel and shadcn/ui with Tailwind CSS v4, semantic tokens, Lucide icons, and accessibility-first principles.

**Arch Docs**: Deep dives into codebase architecture with text explanations. Reads source code, traces data flows, and explains how systems work and why they're built that way. Outputs markdown with file:line references.

**TDD**: Runs tests, reads failures, implements minimum code to pass one test at a time, repeats until green. Tests are the spec — never modifies test files unless asked.

**SD Loop**: Autonomous task runner. Feeds a prompt in a loop until completion or max iterations. Defaults to reading SPEC.md and implementing everything in it.

**Code Count**: Parses Claude Code JSONL transcripts to report token usage, estimated API cost, daily breakdown charts, and per-project breakdowns.

## Related Projects

- [AGENTS.md](https://github.com/stevederico/agents-md) — Prompts for writing code with LLMs, Deno, Vite, React 19+

## Companion Skills

Standalone skills that pair well with this collection:

| Name | Description | Install |
|------|-------------|---------|
| [cartographer](https://github.com/stevederico/cartographer) | Architecture diagram generator | `npx skills add stevederico/cartographer` |

## Architecture

Each agent exists in two formats:

**Skills** (source of truth): Folders at the project root with `SKILL.md` files containing priority matrices, rule IDs, and structured guidance. Works with any framework supporting the skills spec.

**Subagents** (thin wrappers): Markdown files in `subagents/` with model/color frontmatter that invoke the corresponding skill. Claude Code spawns these as specialized workers. No duplicated logic — each subagent delegates to its skill via `/skill-name`.

## License

MIT
