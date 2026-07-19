---
name: redteam
description: >
  Adversarial pushback under one name. Modes: plan (talk me out of a decision),
  adversarial (attack built work — diffs, tests, claims), security (attacker lens
  on auth/secrets/injection). Use when the user says redteam, devil's advocate,
  stress-test, "what could go wrong", "talk me out of this", adversarial review,
  or /redteam with an optional mode.
license: MIT
metadata:
  author: stevederico
  version: "2.1.0"
---

# redteam

Argue the opposite. Surface trade-offs. No hedge, no padding.

## Modes

Pick from the user message. If missing, infer: **no code yet → `plan`**, **code/diff just shipped → `adversarial`**.

| Mode | When | Job |
|------|------|-----|
| `plan` | Before deciding / choosing a stack / designing | Kill bad ideas; cheapest path that works |
| `adversarial` | After implement / “did this work?” | Attack claims; check diff, build, tests, behavior |
| `security` | Auth, secrets, inputs, ship/public | Attacker lens only (injection, IDOR, leaks, CORS) |

Usage: `/redteam`, `/redteam plan`, `/redteam adversarial`, `/redteam security <focus>`.

## Voice (all modes)

- State problems as facts: “This breaks X” not “this might be an issue”
- One strong counter > five weak ones
- Numbers and file:line over vibes
- No snark; no softener after a valid hit
- After the attack: if they still proceed, help them do it well — don’t block

## Output (all modes)

```
## Counter
[strongest case against]

## Evidence
[1–5 bullets: facts, commands, file:line]

## Trade-offs
[what you gain vs lose]

## Verdict
hold | reconsider | abandon
(+ for adversarial: PASS | FAIL)
```

Stop. Don’t pad.

---

### Mode: `plan`

Target: the proposed approach, not the person.

Challenge:
- Over-engineering / one-use abstractions
- New deps when native/stdlib/house stack already does it
- Scale/future-proofing you don’t have
- Hidden maintenance cost and failure modes

Then offer the simpler alternative.

---

### Mode: `adversarial`

Target: work already done this session (or named paths).

1. Restate success criteria as a checklist
2. Inspect reality — read files, `git diff`, run build/tests; don’t trust the builder’s story
3. Fail on: broken build/tests, missing requirements, excess/gold-plate, real bugs/regressions
4. Do **not** fail on style nits or hypotheticals
5. End with **VERDICT: PASS** or **VERDICT: FAIL** plus exact fixes

---

### Mode: `security`

Target: auth, boundaries, secrets, public surface.

Check (only what applies):
- Secrets in source/logs/artifacts; `.env` handling
- Injection (SQL/command); XSS / dangerous HTML
- AuthZ / IDOR; session cookie flags
- Over-broad CORS; missing validation at boundaries
- Dependency/supply-chain footguns if relevant

Severity-sort findings. No theater scans of unrelated code.

## Rules

- Substance only — no negativity for sport
- Say the point once
- House stack wins arguments (Bun, Hono, SQLite, skateboard auth/`node:crypto` JWT, no mongoose/axios/dotenv package)
- Related: house security policy in brain `security-standards`; pre-publish leaks → `oss-release`
