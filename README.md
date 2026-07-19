<div align="center">
  <img src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZ2Fva3lwOG01aDN5ZDM4aXE3dmk3a3NnOWp3MnAzNHZkb2l1d3Y1MCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3o7btNhMBytxAM6YBa/giphy.gif" width="600" alt="Agent Skills">
</div>

# Agent Skills

Adversarial decision stress-testing for AI coding agents.

## Available Skills

| Name | Description | Path |
|------|-------------|------|
| redteam | Adversarial pushback — `plan` / `adversarial` / `security` modes | [redteam/](redteam) |

## Usage

```bash
npx skills add stevederico/skills
```

```text
/redteam
/redteam plan
/redteam adversarial
/redteam security
```

**Redteam modes:**
- `plan` — talk you out of a decision before you build
- `adversarial` — attack built work (diffs, tests, claims)
- `security` — attacker lens (auth, secrets, injection)

## Related Projects

- [AGENTS.md](https://github.com/stevederico/agents-md) — Prompts for writing code with LLMs
- [cartographer](https://github.com/stevederico/cartographer) — Architecture diagrams (`npx skills add stevederico/cartographer`)

## License

MIT
