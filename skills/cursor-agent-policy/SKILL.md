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

If today > `vence` or `precios_consultados` is more than one calendar month old: the price table is stale. Look for local snapshot at `~/.cursor/scrum-dev-agents/AGENTS.md` (or `%USERPROFILE%\.cursor\scrum-dev-agents\AGENTS.md`) first, then plugin baseline. If stale, ask the user once in session language before assigning or refreshing. If the user declines, continue with current table. If the user agrees, run the refresh locally with the cheapest web-search Task slug (§2.0 / §2.1) and write results to the user's directory. Benchmark dates do **not** expire scores and do **not** mark evals VENCIDAS.

Whenever the refresh recomputes eligibility, dominance, tie-break, or cells, apply these **three mandatory criteria** (do not fall back to list-`cost`-only gates, free-cache-write-only budget, or effort-matching):

1. **`bar_drain`**: recompute list `cost = (input + 2 * output) / 3`, then `bar_drain = cost / pool_multiplier` (15 for Cursor Models pool: Composer 2.5, Grok 4.5/4.6/4.7; 1 otherwise). Numeric budget/low/mid gates and dominance/tie-break use `bar_drain`. Keep publishing list `cost`. Do not drop the multiplier; change 15 only if a new Spending snapshot is recorded in `docs/fuentes.md`.
2. **Cheap cache (budget)**: cache read < uncached input; cache write free/`-`/$0 **or** (cw ≤ 1.25× input **and** cw ≤ $1/M). Luna can pass. Do not restore “cache write must be `−`/$0”.
3. **Effort is not a criterion**: do not match benchmark effort to the Task slug; do not prefer higher effort; collapse same-checkpoint variants. Matrix slug = default catalog id; user picks effort per task.

Steps:

1. Open https://cursor.com/docs/models-and-pricing and contrast the Spanish variant.
2. Update in / out / cache write / cache read; recompute `cost` then `bar_drain` (+10% residency stays out of `cost`).
3. Re-check budget / low / mid / high / cursor under the three criteria; redo cells if eligibility, dominance, or `bar_drain` / list-`cost` tie-break moved. Set `vence` to one month after the new `precios_consultados`.
4. New models: **not** price-only. Score from the **admitted registry + discovery** in `docs/fuentes.md`, then recompute percentiles for the **whole** set. No proxy fill.
5. Price-only refresh of models already in the set: do **not** re-fetch benchmarks; **do** re-check gates, dominance, and tie-break under the three criteria.
6. Same pass: re-fetch every admitted URL; admit a new URL only if all gates in `docs/fuentes.md` pass; replace a score only with a newer number of the **same** `benchmark_id`.
7. **Collector vs orchestrator** (model-policy update only — `AGENTS.md` §5.1): pick the collector **this run** from the price list just fetched (cheapest Task slug that can web-search; tiers do not apply; do not pin a slug). One fact-fetch `Task` per target model, in parallel. Collectors do not assign tiers or edit files. After they return, the **mode’s orchestrator** row applies the written math (deterministic), including the three criteria. This role is not a skill type and is not used by Scrum agents.

## Collector (model-policy update only)

Not a matrix cell. Not a skill type. Not used by Scrum agents or process skills. At the start of each **model-policy update**, fetch https://cursor.com/docs/models-and-pricing (contrast ES) and choose the cheapest `cost` among slugs the Task catalog accepts that can WebSearch/WebFetch. `cost = (input + 2 * output) / 3`. Tiers do not apply. Fast loses. Skip a row that cannot web-search or has no Task slug; note the skip in `docs/fuentes.md`. Record the chosen slug in **that update’s log only**. Do not pin a default. Full rule: `AGENTS.md` §5.1.
