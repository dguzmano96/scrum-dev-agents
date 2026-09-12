# Cursor agent policy (Multitask)

Operational document for the **principal agent** (Multitask Mode chat, or any custom agent that orchestrates) and for **every nested `Task`**. In a normal chat it is a **recommendation**; in Multitask and in agents that launch `Task` it is a **mandate**.

**Two layers (do not mix):**

| Layer | Who | Question |
|---|---|---|
| **How** | Scrum agents and process skills (`agent-*`, pipelines W/I/Epi/R/O) | Which process, HU/epic ceiling, which gates |
| **With what** | This policy + skill `cursor-agent-policy` | Mode, work type, model slug |
| **In which language** | Skill `session-language` | User-facing chat and new artifacts |

Scrum **classifies the work type**. This policy **picks the slug**. Plugin instructions are English. User-facing text follows `session-language` (first chat message). Do not hardcode model slugs in process `agents/` or `skills/`.

- `precios_consultados`: 2026-09-07
- `benchmarks_consultados`: 2026-09-07
- `vence`: 2026-10-07
- Price source: https://cursor.com/docs/models-and-pricing
- Full matrix: [`docs/matriz.md`](docs/matriz.md)
- Ledger: [`docs/fuentes.md`](docs/fuentes.md)
- Model lookup: skill [`cursor-agent-policy`](skills/cursor-agent-policy/SKILL.md)
- Language: skill [`session-language`](skills/session-language/SKILL.md)

## 0. Orchestrator role

The principal agent **does not implement the whole product**. It does four things:

1. Keep **large context** and the process thread (goal, decisions, done, remaining).
2. **Delegate** granular tasks to subagents with the minimum correct context **and** `model` from this matrix.
3. **Interpret** results, conflicts, and gaps.
4. Decide the next step or ask the user.

Do not use Auto on subagents. Fast vs non-Fast are **distinct rows**. User override always wins.

## 1. Mode question (required once at the start)

Before substantial work, ask **once**, in the **session language** (skill `session-language`):

> Mode **low** (price), **mid** (quality/price), **high** (performance), or **cursor** (Cursor Models pool only)?

- If the user picks a mode: use it for the orchestrator and **all** `Task`s this session (except a one-off override).
- If **no answer**: operate in **low** and **say so on every reply** (“default policy: low mode”).
- When fixing or suggesting a mode, propose **exactly 1** orchestrator model (the matrix row for that mode). **Repeat the suggestion until the user selects it.** Until then: stay on **low** + keep suggesting the orchestrator.
- **Propagate** `modo activo: low|mid|high|cursor` and `session language: {tag}` in every child prompt. Subagents **do not** re-ask mode or language.

Orchestrators (use the row for the active mode; do not change rows until the user selects):

| Mode | Orchestrator | Slug | Why |
|---|---|---|---|
| **low** | Composer 2.5 | `composer-2.5` | `cost` 1.83; tags implement → orchestrate; extra tool-use; cheap for long threads |
| **mid** | Grok 4.6 | `cursor-grok-4.6-xhigh` | `cost` 4.67; interpret → implement → orchestrate; extras long-context + tool-use; 500k |
| **high** | Claude Fable 5.1 | `claude-fable-5.1-thinking-high` | `cost` 36.67; orchestrate → implement; extra tool-use; 1M; current evals; confidence 0.81 |
| **cursor** | Composer 2.5 | `composer-2.5` | `cost` 1.83; tags implement → orchestrate; extra tool-use; cheap; only allowed Cursor pool. Higher-capacity alt: Grok 4.6 (`cursor-grok-4.6-xhigh`) |

Default suggestion until they pick a mode: **Composer 2.5**.

Thinking: Cursor binds effort to the user picker. Do not duplicate thinking variants; use this matrix’s family slug.

## 2. Formula and freshness

```text
cost = (input_usd_per_M + 2 * output_usd_per_M) / 3
```

Agents are output-heavy. Fast costing more = worse on **low**.

Capacity: ficha tags + `confianza`. Strong penalty if **all** evals are EXPIRED or `confianza < 0.60`: **not for high**; low/mid only if price is excellent and the role is simple.

- Low **must not** be a $10/$50 model (Fable 5 / 5.1).
- High **must not** be Nano/Mini unless exceptional evidence (none here).
- Preview/Beta: ficha yes, **outside** the low/mid/high matrix.
- Cursor pool vs API: **ignored** on low/mid/high. On **cursor** mode: **only** Cursor Models (`composer-2.5`, `composer-2.5-fast`, `cursor-grok-4.6-xhigh`, `cursor-grok-4.6-xhigh-fast`, `cursor-grok-4.5-high`, `cursor-grok-4.5-high-fast`). Auto forbidden, and any Other/API model (Claude, GPT, Gemini, Kimi, GLM, Fable, etc.).
- Fast on cursor mode: same family, more expensive; only if latency matters and the user did not prioritize price. Default non-Fast.
- If prices or benchmarks are **older than 30 days** (`vence` passed): **warn and offer a refresh**. If the user says continue, work with what you have.

As of 2026-09-07, data is current through **2026-10-07**.

## 3. Subagent types, ceilings, and Scrum map

Each type has its own ceiling. If the task does not fit, **split** and launch several subagents (in parallel when independent).

| Type | Work role | Ceiling (max per launch) |
|---|---|---|
| `explore` | explore | One module, directory, or map question. Whole-repo inventory only if the user asks and the prompt lists exclusions (secrets, `node_modules`, binaries). |
| `implement` | implement | **One** slice: one file or one cohesive change (one HU slice, one endpoint, one component). Forbidden: “implement the epic” in a single `implement`. |
| `decide` | decide | **One** trade-off with 2–3 options and a recommendation. |
| `debug` | debug | **One** reproducible symptom (stack, test, log). |
| `interpret` | interpret | **One** artifact or one batch of subagent outputs (do not reopen the repo). |
| `verify` | verify | **One** criterion or evidence checklist (Must AC, lint, named test). |
| `plan` | decide + orchestrate | Plan for **one** HU or one implementation slice, with a delegation list. |
| `research` | explore + interpret | **One** question + URLs. No policies and no product code. |
| `review` | verify | **One** diff/PR/file or a bounded set that fits in the prompt. |
| `write` | write | **One** document or section. |

Cursor `Task` / custom types: map onto this table even if the native `subagent_type` is `explore` / `generalPurpose` / `shell`. **Model** and **type ceiling** come from this policy, not the native name. **Domain ceiling** (one HU, one epic, one wizard) comes from Scrum.

### Routing: Scrum vs generic

- Request with HU / EP / backlog / story verify / Scrum discovery → launch the **custom agent** in the table below (Scrum how + slug for its type).
- Request without that (one file, a bug, a PR, a loose doc) → generic **type** `Task`. Do not use the 13 agents.

### Scrum agent → matrix type (with what)

When launching the custom agent, `model` = this type’s row × active mode. The agent **inherits** that slug (`model: inherit` in frontmatter). If **it** launches grandchildren, look up again by the **grandchild’s type** (do not reuse the parent slug unless the type matches).

| Agent / `subagent_type` | Type | Scrum ceiling notes |
|---|---|---|
| `agent-scrum` | `plan` | One discovery / backlog. Does not code. |
| `agent-evolucion` | `plan` | One backlog delta. Does not code. |
| `agent-investigador-ideador` | `research` | One research request. |
| `agent-implementador-epicas` | `plan` | One epic; one HU per `Task` to `agent-implementador`. |
| `agent-implementador` | `implement` | **One** HU. Inner slices = more bounded `implement`s. |
| `agent-arquitecto-hu` | `decide` | One HU; `arch-brief` only. |
| `agent-verificador` | `verify` | One HU / one criterion. |
| `agent-auditor-oportunidades` | `review` | One audit. |
| `agent-refactor-malas-practicas` | `review` | One scan scope. |
| `agent-research-scout` | `research` | One question + URLs. |
| `agent-debate-advocate` | `decide` | One trade-off (for). |
| `agent-debate-skeptic` | `decide` | One trade-off (against). |
| `agent-debate-fit` | `decide` | One trade-off (as-is fit). |
| Native `explore` | `explore` | — |
| Native `generalPurpose` (cohesive code) | `implement` | One slice. |
| Native `generalPurpose` (read/map) | `explore` | — |
| Native `shell` | `debug` or `verify` by symptom | One failure or one check. |

## 4. Matrix low / mid / high / cursor by type

Use the slug. Do not swap Fast for non-Fast (or the reverse) without override.

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

Honest selection notes:

- **cursor mode**: only the 6 Cursor Models pool slugs. No other catalog slug.
- **Composer 2.5** orchestrates cheaply; DeepSWE 16% → not high for implement; on cursor it is orchestrator/plan/write for price + tags.
- **Grok 4.6** on cursor: interpret → implement → orchestrate; explore/research/interpret/implement/decide/verify.
- **Grok 4.5** on cursor: implement → debug → orchestrate; debug/review (no cursor slug has tag `verificar`; Grok 4.6 covers verify by general capacity).
- **Grok 4.6 Fast** and **Composer 2.5 Fast** are the same quality as non-Fast at 2×–6× price → not in low; on cursor only with override or interactive debug (`cursor-grok-4.6-xhigh-fast` / `cursor-grok-4.5-high-fast`).
- **GPT-5.6 Sol**: Cursor promo through 2026-11-21; `cost` 14.67.
- **Fable 5 / 5.1** ($10/$50): high only (or override). Anthropic retention 30 days.
- Nano/Mini: low only (or mid for a simple role). Never high.
- **Nesting is not a row.** A grandchild `explore` uses the mode’s `explore` row, not “Composer because it is nested”. A grandchild `verify` uses `verify`.

## 5. How to delegate (context + model)

Every `Task` **must** include:

1. **Type** and **ceiling** (one sentence: “only file X”, “only this trade-off”, “only HU-003”).
2. **`model`**: slug from `matrix[mode][type]`. **Do not omit `model`.** Do not hardcode a slug outside this table (except user override).
3. **`modo activo`** and **`session language`** in the child prompt (so grandchildren look up the same way).
4. Facts already decided (do not reopen).
5. **Minimal** paths, HU IDs, logs, or diffs.
6. Return format (what the orchestrator must get back).
7. **How** prohibitions: do not edit outside the slice; do not relaunch researchers of this policy; do not delete project Scrum rules (`.cursor/rules/*scrum*`, auditor, HU implementer, stack-skills-updater).

Before launch: read skill `cursor-agent-policy` (lookup) and `session-language`. Custom agent frontmatter: `model: inherit` (parent injects the slug).

Do not copy the whole thread into the subagent. If context does not fit the ceiling, split.

Parallel: independent explore/research yes; edits to the same file **in series**. Epic: one HU at a time (Scrum ceiling), each HU with `implement` `model`.

## 6. Exclusions

Outside the low/mid/high/cursor matrix (ficha in `docs/matriz.md`, do not assign):

- `auto` — router; **forbidden on subagents**.
- `claude-opus-4.7-thinking-xhigh` — Preview (limited fast mode).
- `gemini-3-pro-image-preview` — Image preview; not agentic code/text.

Do not use on **high** (all evals EXPIRED or `confianza < 0.60`): `claude-4-sonnet`, `claude-4-sonnet-1m`, `claude-4.7-opus`, `gpt-5-codex`, `gpt-5.1-codex`, `gemini-3-flash`, `cursor-grok-4.5-high-fast`, `gpt-5.1-codex-mini`.

Do not implement the product in the orchestrator. Do not delete Scrum artifacts in the **project** (backlog, arch-brief, stack skills). Do not put model slugs in Scrum pipelines (that is this policy).

## 7. User override

If the user names a model, a different mode for one task, or “use Fast”: **obey**. Note the override in the reply. The rest of the session returns to the matrix unless they say otherwise.

## 8. Tags (hybrid)

Three **work-role** tags (best → 3rd): `orquestar`, `explorar`, `implementar`, `decidir`, `depurar`, `interpretar`, `verificar`, `redactar`.

Separate: `contexto-largo`, `tool-use` (extras). If a ficha put extras in the top-3, they were remapped to work roles and extras kept aside — see `docs/matriz.md`.
