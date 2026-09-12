---
name: cursor-agent-policy
description: >-
  Model lookup (with what) for any Task: mode low/mid/high/cursor × type
  explore/implement/decide/debug/interpret/verify/plan/research/review/write.
  ALWAYS use before launching a Task or custom agent. Scrum does not pick slugs.
---

# Cursor Agent Policy (with what)

**Scrum / process skills = how. This skill = with what.**

Do not pick a model by intuition, by “it is nested”, or by a hardcoded Composer/Grok. Read [`reference.md`](reference.md) and set `model`.

## When

Before **every** `Task` (principal, child, or grandchild). Also when launching an `agent-*`.

## Steps

1. **Mode** = `modo activo` from the prompt. If missing → `low` and declare it.
2. **Type** = map in [`reference.md`](reference.md) (Scrum agent or native type).
3. **`model`** = cell `matrix[mode][type]`. In `cursor` mode, Cursor Models pool only.
4. Set `model` on the `Task`. **Never omit it.**
5. Put `modo activo: {mode}` and `session language: {tag}` in the child prompt so its `Task`s look up the same way. Language: skill `session-language`.
6. User override (a named model, Fast, another mode) wins **on that** `Task`. The rest of the session returns to the matrix.

## Forbidden

- Omitting `model` (“judgment”, “inherit on the Task”).
- Hardcoding `composer-2.5`, Grok, or any other slug in a Scrum pipeline.
- “Nested = cheap” as a rule: cheap is the **row** (`explore`, `write`, `interpret` on low), not the nesting level.
- Auto on subagents.
- Relaunching price/benchmark researchers unless `vence` has passed and the user asks to refresh.

## Ceilings

The **type** ceiling (one slice, one trade-off, one module) is this policy. The **domain** ceiling (one HU, one epic, one wizard) is Scrum. Honor **both**.

Catalog and freshness: `docs/matriz.md`, `docs/fuentes.md`, `AGENTS.md` at the plugin root. `vence`: 2026-10-07.
