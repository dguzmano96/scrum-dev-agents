# Lookup mode × type

`precios_consultados`: 2026-09-07 · `vence`: 2026-10-07  
Canonical source: [`AGENTS.md`](../../AGENTS.md) §4 and [`docs/matriz.md`](../../docs/matriz.md).

If today > `vence`: warn and offer a refresh. If the user continues, use this table.

## Matrix

| Type | low | mid | high | cursor |
|---|---|---|---|---|
| **orchestrator** | `composer-2.5` | `cursor-grok-4.6-xhigh` | `claude-fable-5.1-thinking-high` | `composer-2.5` |
| `explore` | `gpt-5.4-mini-medium` | `gemini-3.1-pro` | `gpt-5.6-sol-medium` | `cursor-grok-4.6-xhigh` |
| `implement` | `gemini-3.7-flash-high` | `cursor-grok-4.6-xhigh` | `claude-opus-5-thinking-high` | `cursor-grok-4.6-xhigh` |
| `decide` | `gemini-3.8-flash-high` | `gemini-3.1-pro` | `claude-opus-5-thinking-high` | `cursor-grok-4.6-xhigh` |
| `debug` | `composer-2.5` | `claude-sonnet-5-thinking-high` | `gpt-5.3-codex` | `cursor-grok-4.5-high` |
| `interpret` | `gpt-5.4-nano-medium` | `cursor-grok-4.6-xhigh` | `gemini-3.1-pro` | `cursor-grok-4.6-xhigh` |
| `verify` | `claude-4.5-haiku-thinking` | `claude-opus-4.8-thinking-high` | `claude-fable-5.1-thinking-high` | `cursor-grok-4.6-xhigh` |
| `plan` | `composer-2.5` | `cursor-grok-4.6-xhigh` | `claude-opus-5-thinking-high` | `composer-2.5` |
| `research` | `gpt-5.4-mini-medium` | `gemini-3.1-pro` | `gpt-5.6-sol-medium` | `cursor-grok-4.6-xhigh` |
| `review` | `claude-4.5-haiku-thinking` | `claude-sonnet-5-thinking-high` | `claude-opus-4.8-thinking-high` | `cursor-grok-4.5-high` |
| `write` | `gpt-5-mini` | `gemini-3.5-flash` | `claude-4.6-opus-high-thinking` | `composer-2.5` |

**cursor** mode: only `composer-2.5`, `composer-2.5-fast`, `cursor-grok-4.6-xhigh`, `cursor-grok-4.6-xhigh-fast`, `cursor-grok-4.5-high`, `cursor-grok-4.5-high-fast`. Fast only with override or interactive debug.

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
  prompt: "modo activo: {low|mid|high|cursor}\nsession language: {tag}\n..."
})
```

Do not omit `model`. A grandchild does **not** inherit the parent slug if its type differs (example: implementer on mid = Grok; architect = `decide` → `gemini-3.1-pro`; helper explore = `explore` → `gemini-3.1-pro`).
