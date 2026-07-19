<div align="center">
  <img src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZ2Fva3lwOG01aDN5ZDM4aXE3dmk3a3NnOWp3MnAzNHZkb2l1d3Y1MCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3o7btNhMBytxAM6YBa/giphy.gif" width="600" alt="Agent Skills">
</div>

# Agent Skills

Open catalog of Steve Derico agent skills. This repo holds **redteam**; other skills live in **dedicated repos** (install each from its source).

## In this repo

| Skill | Description | Install |
|------|-------------|---------|
| [redteam](redteam/) | Adversarial pushback — `plan` / `adversarial` / `security` | `npx skills add stevederico/skills` |

```text
/redteam
/redteam plan
/redteam adversarial
/redteam security
```

- **plan** — talk you out of a decision before you build  
- **adversarial** — attack built work (diffs, tests, claims)  
- **security** — attacker lens (auth, secrets, injection)  

## Dedicated skill repos

| Skill | Repo | Install |
|------|------|---------|
| **cartographer** | [stevederico/cartographer](https://github.com/stevederico/cartographer) | `npx skills add stevederico/cartographer` |
| **domain-checker** | [stevederico/domain-checker](https://github.com/stevederico/domain-checker) | `npx skills add stevederico/domain-checker` |
| **hon-maguro** | [stevederico/hon-maguro](https://github.com/stevederico/hon-maguro) | `npx skills add stevederico/hon-maguro` |
| **skateboard** | [stevederico/skateboard](https://github.com/stevederico/skateboard) | `npx skills add stevederico/skateboard` |
| **video-understanding** | [stevederico/video-understanding](https://github.com/stevederico/video-understanding) | `npx skills add stevederico/video-understanding` |

**cartographer** modes: `diagram` (HTML) · `docs` (text deep-dive) · auto if omitted.

### Related app (skill still local / later)

| Project | Repo | Notes |
|---------|------|--------|
| **session-review** | [stevederico/session-review](https://github.com/stevederico/session-review) | Usage/cost UI; agent skill not published from this repo yet |

## Install all (dedicated + redteam)

```bash
npx skills add stevederico/skills
npx skills add stevederico/cartographer
npx skills add stevederico/domain-checker
npx skills add stevederico/hon-maguro
npx skills add stevederico/skateboard
npx skills add stevederico/video-understanding
```

## Related

- [AGENTS.md](https://github.com/stevederico/agents-md) — prompts for writing code with LLMs  
- [local-ai-cli](https://github.com/stevederico/local-ai-cli) — local whisper / LLM for video-understanding  

## License

MIT
