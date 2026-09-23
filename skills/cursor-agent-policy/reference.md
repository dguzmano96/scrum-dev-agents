# Lookup mode × type

`precios_consultados`: 2026-09-22 · `benchmarks_consultados`: 2026-09-22 · `vence`: 2026-10-22 (one month; prices only)  
Canonical source: [`AGENTS.md`](../../AGENTS.md) §4, [`docs/matriz.md`](../../docs/matriz.md), and **registry + math** in [`docs/fuentes.md`](../../docs/fuentes.md). The original ten URLs are admitted examples, not a ceiling.

If today > `vence` or `precios_consultados` is more than one calendar month old: the price table is stale. **Before assigning a slug**, run `AGENTS.md` §2.1 / `docs/fuentes.md` (open the EN pricing page, contrast ES, recompute `cost`, re-check gates / dominance / tie-break; new models need registry + discovery and a whole-set percentile recompute). A price-only refresh of models already in the set does not re-fetch benchmarks. `benchmarks_consultados` is audit-only; `vence` does not mark scores VENCIDAS. If the user continues after a stale warning *and* you have not yet refreshed, still do not invent a slug — refresh first or wait.

Empty cell = no eligible model had even one tagged benchmark for that task. Do not fill with a proxy.

**Collector vs orchestrator** (full text: [`AGENTS.md`](../../AGENTS.md) §5.1): used **only** in a model-policy update. Not a matrix cell. Not a skill type. Scrum agents never launch it. At the start of that update, pick the cheapest Task-catalog slug that can web-search from the price list just fetched (`cost = (input + 2 * output) / 3`; tiers do not apply; Fast loses; skip and log in `docs/fuentes.md` if needed). Record the slug in **that update’s log only**. Do not pin a default. After collectors return, the orchestrator applies the written math (deterministic).

## Matrix

| Type | budget | low | mid | high | cursor |
|---|---|---|---|---|---|
| **orchestrator** | `gpt-5.4-nano-xhigh` | `gemini-3.8-flash-high` | `cursor-grok-4.6-medium` | `cursor-grok-4.6-medium` | `cursor-grok-4.6-medium` |
| `explore` | `gpt-5.4-nano-xhigh` | `gemini-3.7-flash-high` | `cursor-grok-4.5-high` | `cursor-grok-4.5-high` | `cursor-grok-4.5-high` |
| `implement` | `gpt-5.4-nano-xhigh` | `gemini-3.8-flash-high` | `cursor-grok-4.6-medium` | `claude-fable-5-1-thinking-high` | `cursor-grok-4.6-medium` |
| `decide` | `gpt-5.4-nano-xhigh` | `gemini-3.7-flash-high` | `kimi-k3-max` | `claude-fable-5-1-thinking-high` | `cursor-grok-4.6-medium` |
| `debug` | `gpt-5.4-nano-xhigh` | `gemini-3.8-flash-high` | `grok-4.7-xhigh` | `claude-fable-5-1-thinking-high` | `grok-4.7-xhigh` |
| `interpret` | — | — | — | — | — |
| `verify` | `gpt-5-mini` | `gemini-3.8-flash-high` | `gemini-3.1-pro` | `gemini-3.1-pro` | `grok-4.7-xhigh` |
| `plan` | `gpt-5.4-nano-xhigh` | `gemini-3.8-flash-high` | `cursor-grok-4.6-medium` | `claude-fable-5-1-thinking-high` | `cursor-grok-4.6-medium` |
| `research` | `gpt-5.4-nano-xhigh` | `gemini-3.7-flash-high` | `kimi-k3-max` | `kimi-k3-max` | `cursor-grok-4.5-high` |
| `review` | `gpt-5-mini` | `gemini-3.8-flash-high` | `gemini-3.1-pro` | `gemini-3.1-pro` | `grok-4.7-xhigh` |
| `write` | `gemini-2.5-flash` | `gemini-3.8-flash-high` | `gpt-5.2` | `claude-4.6-opus-high-thinking` | — |

**cursor** mode: only `composer-2.5`, `grok-4.7-xhigh`, `cursor-grok-4.6-medium`, `cursor-grok-4.5-high`. Fast is out. Docs name Grok 4.7 without a Task slug `grok-4.7-high`; this catalog uses `grok-4.7-xhigh`.

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
  prompt: "modo activo: {budget|low|mid|high|cursor}\nsession language: {tag}\n..."
})
```

Do not omit `model`. A grandchild does **not** inherit the parent slug if its type differs. If the grandchild’s cell is empty, do not reuse the parent.
