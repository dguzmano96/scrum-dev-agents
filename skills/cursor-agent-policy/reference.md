# Lookup mode × type

`precios_consultados`: 2026-09-22 · `benchmarks_consultados`: 2026-09-22 · `vence`: 2026-10-22 (one month; prices only)  
Canonical source: [`AGENTS.md`](../../AGENTS.md) §4, [`docs/matriz.md`](../../docs/matriz.md), and **registry + math** in [`docs/fuentes.md`](../../docs/fuentes.md). The original ten URLs are admitted examples, not a ceiling.

If today > `vence` or `precios_consultados` is more than one calendar month old: the price table is stale. Look for local snapshot at `~/.cursor/scrum-dev-agents/` first, then plugin baseline. If stale, ask the user once in the session language before assigning or refreshing (`AGENTS.md` §2.0). If they decline, continue with current table. If they agree, run the refresh locally with one subagent per model, in parallel, each using the cheapest Task-catalog slug that can WebSearch/WebFetch (not one subagent for all models). After they return, the same cheap slug applies the existing math in `docs/fuentes.md` and writes only to `~/.cursor/scrum-dev-agents/` (Windows: `%USERPROFILE%\.cursor\scrum-dev-agents\`). GitHub stays the baseline. No GitHub Action. Do not invent a slug. A price-only refresh of models already in the set does not re-fetch benchmarks. `benchmarks_consultados` is audit-only; `vence` does not mark scores VENCIDAS.

Empty cell = no eligible model had even one tagged benchmark for that task. Do not fill with a proxy. **emergencia** does not leave empty task cells: `interpret` and `write` are `composer-2.5`.

**Collector vs orchestrator** (full text: [`AGENTS.md`](../../AGENTS.md) §5.1): used **only** in a model-policy update. Not a matrix cell. Not a skill type. Scrum agents never launch it. At the start of that update, pick the cheapest Task-catalog slug that can web-search from the price list just fetched (`cost = (input + 2 * output) / 3`; tiers do not apply; Fast loses; skip and log in `docs/fuentes.md` if needed). Record the slug in **that update’s log only**. Do not pin a default. After collectors return, the orchestrator applies the written math (deterministic), including `bar_drain`, cheap cache, and no effort ranking.

## Matrix

Cell reassignment **2026-09-26** (`bar_drain` + cheap cache). Fichas 2026-09-22.

| Type | budget | low | mid | high | cursor | emergencia |
|---|---|---|---|---|---|---|
| **orchestrator** | `cursor-grok-4.6-medium` | `cursor-grok-4.6-medium` | `gpt-5.6-terra-medium` | `cursor-grok-4.6-medium` | `cursor-grok-4.6-medium` | `cursor-grok-4.6-medium` |
| `explore` | `cursor-grok-4.5-high` | `cursor-grok-4.5-high` | `kimi-k3-max` | `cursor-grok-4.5-high` | `cursor-grok-4.5-high` | `composer-2.5` |
| `implement` | `cursor-grok-4.6-medium` | `gemini-3.8-flash-high` | `kimi-k3-max` | `claude-fable-5-1-thinking-high` | `cursor-grok-4.6-medium` | `composer-2.5` |
| `decide` | `cursor-grok-4.6-medium` | `gemini-3.7-flash-high` | `kimi-k3-max` | `claude-fable-5-1-thinking-high` | `cursor-grok-4.6-medium` | `composer-2.5` |
| `debug` | `grok-4.7-xhigh` | `grok-4.7-xhigh` | `gpt-5.6-terra-medium` | `claude-fable-5-1-thinking-high` | `grok-4.7-xhigh` | `composer-2.5` |
| `interpret` | — | — | — | — | — | `composer-2.5` |
| `verify` | `grok-4.7-xhigh` | `grok-4.7-xhigh` | `gemini-3.1-pro` | `gemini-3.1-pro` | `grok-4.7-xhigh` | `composer-2.5` |
| `plan` | `cursor-grok-4.6-medium` | `gemini-3.8-flash-high` | `kimi-k3-max` | `claude-fable-5-1-thinking-high` | `cursor-grok-4.6-medium` | `composer-2.5` |
| `research` | `cursor-grok-4.5-high` | `gemini-3.7-flash-high` | `kimi-k3-max` | `kimi-k3-max` | `cursor-grok-4.5-high` | `composer-2.5` |
| `review` | `grok-4.7-xhigh` | `grok-4.7-xhigh` | `gemini-3.1-pro` | `gemini-3.1-pro` | `grok-4.7-xhigh` | `composer-2.5` |
| `write` | `gemini-2.5-flash` | `gemini-3.8-flash-high` | `gpt-5.2` | `claude-4.6-opus-high-thinking` | — | `composer-2.5` |

**cursor** mode: only `composer-2.5`, `grok-4.7-xhigh`, `cursor-grok-4.6-medium`, `cursor-grok-4.5-high`. Fast is out. Docs name Grok 4.7 without a Task slug `grok-4.7-high`; this catalog uses `grok-4.7-xhigh`. Effort is not a ranking criterion; the matrix slug is the default catalog id — the user picks effort per task.

**emergencia:** orquestador = `cursor-grok-4.6-medium` (el de budget). Todo otro tipo = `composer-2.5` (nunca Fast). Consignas más largas: ver §5.2 de `AGENTS.md` y el skill.

## Scrum agent → type

| `subagent_type` | Type |
|---|---|
| `agent-scrum` | `plan` |
| `agent-evolution` | `plan` |
| `agent-investigator-ideator` | `research` |
| `agent-epic-implementer` | `plan` |
| `agent-implementer` | `implement` |
| `agent-story-architect` | `decide` |
| `agent-verifier` | `verify` |
| `agent-opportunity-auditor` | `review` |
| `agent-refactor-bad-practices` | `review` |
| `agent-research-scout` | `research` |
| `agent-debate-advocate` | `decide` |
| `agent-debate-skeptic` | `decide` |
| `agent-debate-fit` | `decide` |
| native `explore` | `explore` |
| native `generalPurpose` (cohesive code) | `implement` |
| native `generalPurpose` (read/map) | `explore` |
| native `shell` | `debug` or `verify` |

## Task contract

```text
Task({
  subagent_type: "<agent or native>",
  model: "<cell slug>",
  prompt: "modo activo: {budget|low|mid|high|cursor|emergencia}\nsession language: {tag}\n..."
})
```

Do not omit `model`. A grandchild does **not** inherit the parent slug if its type differs. If the grandchild’s cell is empty, do not reuse the parent.

### Modo emergencia (consignas más largas)

Cuando `modo activo: emergencia`, el orquestador escribe consignas más descriptivas: da al subagente más contexto y material para que Composer 2.5 se pierda menos. El techo de cada Task sigue siendo uno (un archivo, una HU, un trade-off). Más material significa hechos ya decididos, rutas y símbolos exactos, el borde del slice, restricciones, un ejemplo breve de la forma esperada si la tarea es ambigua, el formato de retorno (campos que el orquestador leerá) y qué queda fuera de alcance en la misma consigna — no un alcance más ancho y no pegar el repo entero ni copiar `AGENTS.md` ni el hilo completo. Declara `modo activo: emergencia` y `session language: {tag}`. Repite las decisiones ya tomadas con una frase de motivo cuando eso evita que el subagente las reabra. Nombra paths, símbolos y el borde del slice. Incluye los hechos de entrada, las restricciones y un ejemplo pequeño de la forma deseada si la tarea es ambigua. Escribe el formato de retorno. Di qué está fuera de alcance en esa misma consigna. No partas un techo en varios Tasks solo para añadir palabras.
