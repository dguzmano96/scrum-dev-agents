---
name: session-language
description: >-
  Sets the session UI/artifact language from the user's first chat message.
  Use before AskQuestion, writing HU/EPIC/reports, or launching any Task.
  Not for protocol tokens, IDs, paths, Gherkin keywords, or source code.
---

# Session language

Plugin instructions are **English**. User-facing chat, AskQuestion, and **new** artifacts use the **session language**.

## Detect (once per chat)

1. Use the language of the user's **first natural-language message** in this chat.
2. Ignore @-mentions, file paths, IDs (`HU-003`, `EP-001`), and code fences when detecting.
3. If that message is only IDs/commands (`Implement HU-003`) and no session language exists yet → **English**.
4. Explicit override wins: “answer in French”, “responde en español”, etc.
5. Hold it for the rest of the session. Do not switch because a later snippet is in another language (quotes, logs, diffs).
6. Pass `session language: {tag}` on **every** child `Task` prompt (same idea as `modo activo`).

`{tag}` = BCP-47 if obvious (`en`, `es`, `pt-BR`), otherwise the language name (`Spanish`).

## Write in session language

- Chat replies and AskQuestion prompts/options
- New backlog docs, reports, architecture briefs, diagram **labels**
- User-story sentence shape: equivalent of “As a **[role]**, I want **[goal]**, so that **[benefit]**.”

## Never localize (functionality)

| Keep | Examples |
|---|---|
| Paths / folders / filenames | `00-discovery/`, `01-backlog/`, `HU/HU-001-*.md` |
| IDs | `EP-001`, `HU-012`, `SPK-001`, `OPP-001` |
| Protocol tokens | `done-local`, `blocked`, `arch-ok`, `verify-ok`, `PASS`, `FAIL`, `needs-user`, `needs-scrum-update` |
| Phase codes | `W0`–`W8`, `I0`–`I9`, `Epi0`–`Epi8`, `R0`–`R8`, `O0`–`O10` |
| Framework words | MoSCoW, INVEST, AC, BDD, Must/Should/Could/Won't |
| Gherkin keywords | `Given` / `When` / `Then` / `And` / `But` |
| Agent and skill names | `agent-scrum`, `hu-implementer` |
| Source code | Follow the repo’s language; comments match neighboring files |

## Read existing artifacts

Match **structure**, not heading locale. These are the same sections:

| Meaning | EN heading (templates) | Common aliases |
|---|---|---|
| Story | Story | Historia |
| Acceptance criteria | Acceptance Criteria | Criterios de Aceptación |
| BDD scenarios | BDD Scenarios | Escenarios BDD |
| Business rules | Business rules | Reglas de negocio |
| In / out scope | In scope / Out of scope | Alcance IN / OUT |

Do **not** require Spanish. Do **not** rewrite an existing backlog into another language unless the user asks.

## Templates

Canonical templates are English. Fill **body text** in the session language. Keep Gherkin keywords in English.
