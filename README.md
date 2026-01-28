![](https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZ2Fva3lwOG01aDN5ZDM4aXE3dmk3a3NnOWp3MnAzNHZkb2l1d3Y1MCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3o7btNhMBytxAM6YBa/giphy.gif)

# Agent Skills & Subagents

Professional AI agent configurations for software development workflows.

Browse this repository to see both formats side-by-side.

## Available Agents

| Name | Description | Subagent | Skill |
|------|-------------|----------|-------|
| backend | Node.js/Express API development | [backend.md](backend.md) | [skills.sh/backend/](skills.sh/backend) |
| debug | Error investigation & troubleshooting | [debug.md](debug.md) | [skills.sh/debug/](skills.sh/debug) |
| docs | Stripe-style API documentation | [docs.md](docs.md) | [skills.sh/docs/](skills.sh/docs) |
| frontend | React 19 + Tailwind CSS + Vite | [frontend.md](frontend.md) | [skills.sh/frontend/](skills.sh/frontend) |
| deployer | Railway platform deployment | [deployer.md](deployer.md) | [skills.sh/deployer/](skills.sh/deployer) |
| redteam | Challenge decisions with counter-arguments | [redteam.md](redteam.md) | [skills.sh/redteam/](skills.sh/redteam) |
| reviewer | Code review & refactoring | [reviewer.md](reviewer.md) | [skills.sh/reviewer/](skills.sh/reviewer) |
| security | OWASP Top 10 vulnerability detection | [security.md](security.md) | [skills.sh/security/](skills.sh/security) |

## Usage

### For Claude Code
Copy `.md` files from root to your Claude Code directory:
```bash
cp *.md ~/.claude/subagents/
```

### For skills.sh
Install the skills collection:
```bash
npx skills add yourusername/agent-skills
```

## Two Formats, Same Power

| Format | Files | Use Case |
|--------|-------|----------|
| **Subagents** | `*.md` in root | Claude Code `Task` tool invocation |
| **Skills** | `skills.sh/*/SKILL.md` | Universal agent framework compatibility |

Same expertise, different packaging.


## License

MIT
