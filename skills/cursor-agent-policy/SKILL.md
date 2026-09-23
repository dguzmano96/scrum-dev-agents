---
name: cursor-agent-policy
description: >-
  Model lookup (with what) for any Task: mode budget/low/mid/high/cursor × type
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
3. **`model`** = cell `matrix[mode][type]`. In `cursor` mode, only the four Task-launchable Cursor Models slugs for matrix cells. If the cell is empty, do not invent a proxy; ask or wait for an override. Scrum agents and process skills never use a collector.
4. Set `model` on the `Task`. **Never omit it.**
5. Put `modo activo: {mode}` and `session language: {tag}` in the child prompt so its `Task`s look up the same way. Language: skill `session-language`.
6. User override (a named model, Fast, another mode) wins **on that** `Task`. The rest of the session returns to the matrix.

## Forbidden

- Omitting `model` (“judgment”, “inherit on the Task”).
- Hardcoding `composer-2.5`, Grok, or any other slug in a Scrum pipeline.
- “Nested = cheap” as a rule: cheap is the **row**, not the nesting level.
- Auto on subagents.
- Skipping §2.1 of `AGENTS.md` when the price table is stale (`vence` passed or `precios_consultados` older than one calendar month). Benchmark dates do not trigger a refresh and do not mark scores VENCIDAS.

## Ceilings

The **type** ceiling (one slice, one trade-off, one module) is this policy. The **domain** ceiling (one HU, one epic, one wizard) is Scrum. Honor **both**.

Catalog and freshness: `docs/matriz.md`, `docs/fuentes.md` (**canonical registry + math**), `AGENTS.md` at the plugin root. Capacity is **not** limited to a closed list of ten sites.

- `precios_consultados`: 2026-09-22
- `benchmarks_consultados`: 2026-09-22
- `vence`: 2026-10-22 (one month after `precios_consultados`; price table only; does not mark benchmarks expired)

## Price + registry refresh (monthly)

If today > `vence` or `precios_consultados` is more than one calendar month old, **do not assign a slug** until you run `AGENTS.md` §2.1 / `docs/fuentes.md`:

1. Open https://cursor.com/docs/models-and-pricing and contrast the Spanish variant.
2. Update in / out / cache write / cache read; recompute `cost = (input + 2 * output) / 3` (+10% residency stays out).
3. Re-check budget / low / mid / high / cursor gates; redo cells if eligibility, dominance, or cost tie-break moved. Set `vence` to one month after the new `precios_consultados`.
4. New models: **not** price-only. Score from the **admitted registry + discovery** in `docs/fuentes.md`, then recompute percentiles for the **whole** set. No proxy fill.
5. Price-only refresh of models already in the set: do **not** re-fetch benchmarks; **do** re-check gates, dominance, and tie-break.
6. Same pass: re-fetch every admitted URL; admit a new URL only if all gates in `docs/fuentes.md` pass; replace a score only with a newer number of the **same** `benchmark_id`.
7. **Collector vs orchestrator** (model-policy update only — `AGENTS.md` §5.1): pick the collector **this run** from the price list just fetched (cheapest Task slug that can web-search; tiers do not apply; do not pin a slug). One fact-fetch `Task` per target model, in parallel. Collectors do not assign tiers or edit files. After they return, the **mode’s orchestrator** row applies the written math (deterministic). This role is not a skill type and is not used by Scrum agents.

## Collector (model-policy update only)

Not a matrix cell. Not a skill type. Not used by Scrum agents or process skills. At the start of each **model-policy update**, fetch https://cursor.com/docs/models-and-pricing (contrast ES) and choose the cheapest `cost` among slugs the Task catalog accepts that can WebSearch/WebFetch. `cost = (input + 2 * output) / 3`. Tiers do not apply. Fast loses. Skip a row that cannot web-search or has no Task slug; note the skip in `docs/fuentes.md`. Record the chosen slug in **that update’s log only**. Do not pin a default. Full rule: `AGENTS.md` §5.1.
