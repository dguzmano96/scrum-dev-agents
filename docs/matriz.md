# Matrix of Cursor models

`precios_consultados`: 2026-09-22  
`benchmarks_consultados`: 2026-09-22  
`vence`: 2026-10-22  

`vence` is **one calendar month** after `precios_consultados` and applies to the **price table only**. Benchmark dates are audit stamps. They do not expire scores and do not mark evals VENCIDAS.

Capacity math and the **open URL registry** are canonical in [`docs/fuentes.md`](fuentes.md). The original ten URLs are admitted examples, not a ceiling. Price refresh: [`AGENTS.md`](../AGENTS.md) §2.1 (must apply `bar_drain`, cheap cache, and no effort ranking). If today > `vence` or `precios_consultados` is more than one calendar month old, refresh prices (EN + ES contrast) **before** assigning a slug. Price-only refresh of models already in the set does not re-fetch benchmarks; it does re-check gates, dominance, and the `bar_drain` / list-`cost` tie-break under those three criteria. New Task slugs require registry + discovery and a whole-set percentile recompute.

**Collector vs orchestrator:** fetching facts ≠ assigning tiers. Used **only** in a model-policy update. The collector is chosen **at the start of that update** from the price list just fetched (cheapest Task slug that can web-search; tiers do not apply; do not pin a slug). Record it in that update’s log only — not a matrix cell. One collector per target model (parallel); the mode’s **orchestrator** row then applies this file’s math (deterministic). Full rule: [`AGENTS.md`](../AGENTS.md) §5.1. Collectors do not fill this matrix. Scrum agents never use this role.

## Formula

```text
cost = (input_usd_per_M + 2 * output_usd_per_M) / 3
pool_multiplier = 15 if Cursor Models pool else 1
bar_drain = cost / pool_multiplier
```

List `cost` is the published API price (USD / million tokens; EN table; ES matched 2026-09-22). Regional residency +10% is not in `cost`. **Tier gates and dominance/tie-break use `bar_drain`.** Cursor Models pool = Composer 2.5, Grok 4.5, Grok 4.6, Grok 4.7 (all efforts). `pool_multiplier_cursor = 15` is empirical from Spending snapshot 2026-09-26 (see [`docs/fuentes.md`](fuentes.md)).

## Scoring (this pass)

- Policy set = priced on https://cursor.com/docs/models-and-pricing **and** present in the Task catalog. Skip `auto`, Fast, and image-only.
- Blank slate: no prior ficha or matrix cell was copied. Only collector records + this file’s math.
- One tag per `benchmark_id` **only** by the closed map in [`docs/fuentes.md`](fuentes.md). Name matches no row → `sin-tag`, exclude. Composites (AA Intelligence Index, BenchLM overall, Coding Agent Index, Vals Index) stay `sin-tag`.
- Arena text preference → `redactar` (including Longer Query). AA-LCR / BrowseComp / MRCR → `explorar`. Arena Document would be `interpretar` (N&lt;2 this pass → empty `interpret`).
- Percentile among policy models that have that datum: `100 * (W + (T-1)/2) / (N-1)`. `N=1` is coverage, not a contest. Missing = unknown, not zero. Date does not enter the score.
- Tag score = simple mean of that tag’s percentiles. No coverage multiplier. Fewer than 2 ids = **WEAK**.
- `plan` = mean of `orquestar` and `decidir` the model has (one of two = weak). `research` = mean of `explorar` and `interpretar`. `review` = `verificar`.
- Effort is **not** a ranking criterion: do not match benchmark effort to the Task slug; collapse same-family effort variants into one candidate; do not copy scores across families. The matrix slug is the default non-Fast catalog id; the user chooses effort per task (override replaces the suffix when the catalog has that family).
- Dominance: if A is better on all shared ids of that tag and `bar_drain(A) ≤ bar_drain(B)`, B cannot occupy the cell. Tie-break: lower `bar_drain`, then lower list `cost`.
- Empty cell if no eligible model has even one tagged id. No proxy.
- Fichas and percentiles: collector pass **2026-09-22** (`gpt-5.6-luna-high`). **37** records. Cell reassignment **2026-09-26**: `bar_drain` + cheap-cache budget gate; tag scores unchanged.

## Assignment budget / low / mid / high / cursor

`—` = empty. `W` = weak evidence (1 tagged id, or `plan`/`research` with only one of the two tags). Reassignment **2026-09-26** (`bar_drain` + cheap cache). Tag scores from fichas 2026-09-22 unchanged.

| Type | budget | low | mid | high | cursor |
|---|---|---|---|---|---|
| **orchestrator** | `cursor-grok-4.6-medium` | `cursor-grok-4.6-medium` | `gpt-5.6-terra-medium` | `cursor-grok-4.6-medium` | `cursor-grok-4.6-medium` |
| `explore` | `cursor-grok-4.5-high` | `cursor-grok-4.5-high` | `kimi-k3-max` W | `cursor-grok-4.5-high` | `cursor-grok-4.5-high` |
| `implement` | `cursor-grok-4.6-medium` | `gemini-3.8-flash-high` | `kimi-k3-max` W | `claude-fable-5-1-thinking-high` | `cursor-grok-4.6-medium` |
| `decide` | `cursor-grok-4.6-medium` | `gemini-3.7-flash-high` | `kimi-k3-max` | `claude-fable-5-1-thinking-high` | `cursor-grok-4.6-medium` |
| `debug` | `grok-4.7-xhigh` W | `grok-4.7-xhigh` W | `gpt-5.6-terra-medium` W | `claude-fable-5-1-thinking-high` W | `grok-4.7-xhigh` W |
| `interpret` | — | — | — | — | — |
| `verify` | `grok-4.7-xhigh` W | `grok-4.7-xhigh` W | `gemini-3.1-pro` | `gemini-3.1-pro` | `grok-4.7-xhigh` W |
| `plan` | `cursor-grok-4.6-medium` | `gemini-3.8-flash-high` | `kimi-k3-max` | `claude-fable-5-1-thinking-high` | `cursor-grok-4.6-medium` |
| `research` | `cursor-grok-4.5-high` W | `gemini-3.7-flash-high` W | `kimi-k3-max` W | `kimi-k3-max` W | `cursor-grok-4.5-high` W |
| `review` | `grok-4.7-xhigh` W | `grok-4.7-xhigh` W | `gemini-3.1-pro` | `gemini-3.1-pro` | `grok-4.7-xhigh` W |
| `write` | `gemini-2.5-flash` W | `gemini-3.8-flash-high` W | `gpt-5.2` W | `claude-4.6-opus-high-thinking` | — |

**cursor** allow-list: `composer-2.5`, `grok-4.7-xhigh`, `cursor-grok-4.6-medium`, `cursor-grok-4.5-high`. Fast is out. Docs name “Grok 4.7”; Task accepts `grok-4.7-xhigh`, not `grok-4.7-high`.

Winner `bar_drain` (approx): pool Grok/Composer **0.31** / **0.12**; Gemini 3.7/3.8 **2.58**; Gemini 2.5 Flash **1.77**; Terra / Gemini 3.1 **8.67**; K3 **11.00**; GPT-5.2 **9.92**; Fable **36.67**; Opus 4.6 **18.33**.

### Why these cells (this pass)

| Cell | Winner | Shared / deciding tagged ids |
|---|---|---|
| orchestrator budget/low/high/cursor | Grok 4.6 | AutomationBench-AA + GDPval-AA, tag 94.44 (2). `bar_drain` ≈ 0.31 → budget+low. Dominates 4.5; 4.7 orquestar is 1 id (W). |
| orchestrator mid | Terra | Pool Grok not mid-eligible. Terra orquestar 36.51 (2). K3 orquestar GDPval-only (W) cannot beat ≥2 ids. |
| explore budget/low/high/cursor | Grok 4.5 | AA-LCR + BrowseComp (2), tag 68.75. `bar_drain` ≈ 0.31. |
| explore mid | Kimi K3 W | Pool 4.5 not mid. K3 LCR pct 100 (1 id). |
| implement budget | Grok 4.6 | implementar 60.40 (3); Gemini 3.8 not budget (`bar_drain` 2.58 ≥ 2). |
| implement low | Gemini 3.8 | CursorBench + DeepSWE + SciCode (3), tag 82.32 &gt; 4.6 60.40. |
| implement mid | Kimi K3 W | Pool/Fable not mid; K3 DeepSWE 80 (1 id). |
| implement high/cursor | Fable / Grok 4.6 | Fable 95.45 (2) high; cursor pool → 4.6 60.40 (3). |
| decide budget | Grok 4.6 | decidir 41.82 (3); Gemini 3.7 not budget. |
| decide low | Gemini 3.7 | HLE + ARC-1 + ARC-2 (3), tag 69.27 &gt; 4.6 41.82. |
| decide mid | Kimi K3 | ARC 2 ids, 43.18. Grok not mid. |
| decide high/cursor | Fable / Grok 4.6 | Fable 93.33 (3); cursor → 4.6. |
| debug budget/low/cursor | Grok 4.7 W | Terminal-Bench 83.3 (1). `bar_drain` ≈ 0.31. |
| debug mid | Terra W | Pool not mid; Terra TB 20 (1) among mid fichas. |
| debug high | Fable W | TB 100 (1). |
| verify/review budget/low/cursor | Grok 4.7 W | Omniscience 80.8 (1). Beats Mini/3.8 W on raw score among W. |
| verify/review mid/high | Gemini 3.1 Pro | Omniscience + FACTS (2), tag 41.67. |
| plan budget/cursor | Grok 4.6 | mean(orquestar 94.44, decidir 41.82) ≈ 68.1. |
| plan low | Gemini 3.8 | mean(76.19, 79.17) ≈ 77.7 &gt; 4.6 plan. |
| plan mid | Kimi K3 | mean(orq W, decidir 43.18); Grok not mid. |
| plan high | Fable | mean(82.94, 93.33) ≈ 88.1. |
| research budget/cursor | Grok 4.5 W | No `interpretar`; explorar 68.75 (2). |
| research low | Gemini 3.7 W | explorar 78.12 (1) &gt; 4.5 68.75 among research-W (missing interpretar). |
| research mid/high | Kimi K3 W | LCR pct 100 (1). 4.5 keeps **explore** (2 ids). |
| write budget | Gemini 2.5 Flash W | Arena Text 20 (1); only budget redactar among assigned. |
| write low | Gemini 3.8 W | Arena 80 (1). |
| write mid | GPT-5.2 W | Arena 40 (1); Opus not mid. |
| write high | Opus 4.6 | Arena Overall + Longer Query (2), tag 95. |
| interpret * | — | No `interpretar` contest (N≥2). |
| cursor write | — | No pool slug has `redactar`. |

### Budget models (`bar_drain` &lt; 2 + cheap cache)

| slug | in | out | cost | bar_drain | cache write | cache read | notes |
|---|---:|---:|---:|---:|---|---:|---|
| `cursor-grok-4.6-medium` | 2.00 | 6.00 | 4.67 | **0.31** | `-` | 0.50 | budget+low orchestrator / implement / decide / plan |
| `cursor-grok-4.5-high` | 2.00 | 6.00 | 4.67 | **0.31** | `-` | 0.50 | budget+low explore / research |
| `grok-4.7-xhigh` | 2.00 | 6.00 | 4.67 | **0.31** | `-` | 0.50 | budget+low debug / verify / review |
| `composer-2.5` | 0.50 | 2.50 | 1.83 | **0.12** | `-` | 0.20 | CursorBench only → not assigned |
| `gpt-5.6-luna-high` | 0.20 | 1.20 | 0.87 | 0.87 | 0.25 | 0.02 | **passes** cheap cache; no cell (tags lose) |
| `gpt-5.4-nano-xhigh` | 0.20 | 1.25 | 0.90 | 0.90 | `-` | 0.02 | eligible; dominated on orquestar by pool Grok |
| `gpt-5-mini` | 0.25 | 2.00 | 1.42 | 1.42 | `-` | 0.025 | eligible; verify lost to 4.7 W |
| `gemini-2.5-flash` | 0.30 | 2.50 | 1.77 | 1.77 | `-` | 0.03 | budget write |

## Dominance discards (this pass)

| B | A | Tag | Shared `benchmark_id` | bar_drain |
|---|---|---|---|---|
| `cursor-grok-4.5-high` | `cursor-grok-4.6-medium` | orquestar | AutomationBench-AA (63&gt;58), GDPval-AA (1605&gt;1430) | 0.31 ≤ 0.31 |
| `grok-4.7-xhigh` | `cursor-grok-4.6-medium` | orquestar | 4.7 has only GDPval-AA (1 id). Weak cannot occupy against 4.6’s 2 ids | 0.31 = 0.31 |
| `grok-4.7-xhigh` | `cursor-grok-4.6-medium` | implementar | 4.7 has only CursorBench-4.0. Weak cannot occupy against 4.6’s 3 ids | 0.31 = 0.31 |
| `kimi-k3-max` | `cursor-grok-4.6-medium` | orquestar | only shared GDPval-AA (1605&gt;1584); K3 has no AutomationBench (W) | 0.31 ≤ 11.00 |
| Mid Arena-only write rivals | `gpt-5.2` | redactar | same Arena-Text-Overall, worse Elo | mid write stays 5.2 W |

Gemini 3.8 vs Grok 4.6 on implementar: 3.8 better on shared CursorBench + DeepSWE, but `bar_drain` 2.58 ≰ 0.31 → **no** dominance either way. Higher tag score (82.32 &gt; 60.40) keeps **low** implement for 3.8; 4.6 still wins **budget** implement (3.8 not budget-eligible).

Luna vs Nano: Luna passes cheap cache (`cw` 0.25 ≤ 1.25×0.20 and ≤ $1). They share AutomationBench (tie 6%) and GDPval (Luna 1319 &gt; Nano 937) — Luna does not strictly beat on **all** shared orquestar ids. Both lose budget orquestar to Grok 4.6.

## Price inventory (Task slugs)

EN/ES Cursor tables agreed on listed rows. `cw` / `cr` = cache write / read. Orchestrator page fetch used when a collector missed the row (Gemini 2.5 Flash, Gemini 3 Flash, GPT-5.2).

| display | slug | in | out | cost | cw | cr | notes |
|---|---|---:|---:|---:|---|---:|---|
| Auto | auto | var | var | — | — | — | excluded |
| GPT-5.6 Luna | gpt-5.6-luna-high | 0.20 | 1.20 | 0.87 | 0.25 | 0.02 | **this run’s collector**; budget-eligible (cheap cache); no cell |
| GPT-5.4 Nano | gpt-5.4-nano-xhigh | 0.20 | 1.25 | 0.90 | - | 0.02 | budget-eligible; no cell after pool Grok |
| GPT-5 Mini | gpt-5-mini | 0.25 | 2.00 | 1.42 | - | 0.025 | budget-eligible; verify lost to 4.7 |
| Gemini 2.5 Flash | gemini-2.5-flash | 0.30 | 2.50 | 1.77 | - | 0.03 | budget write |
| Composer 2.5 | composer-2.5 | 0.50 | 2.50 | 1.83 | - | 0.20 | budget + cursor pool; no cell |
| Gemini 3 Flash | gemini-3-flash | 0.50 | 3.00 | 2.17 | - | 0.05 | low (`bar_drain` 2.17) |
| Gemini 3.7 Flash | gemini-3.7-flash-high | 0.75 | 3.50 | 2.58 | - | 0.075 | low decide / research |
| Gemini 3.8 Flash | gemini-3.8-flash-high | 0.75 | 3.50 | 2.58 | - | 0.075 | low implement / plan / write |
| Kimi K2.7 Code | kimi-k2.7-code | 0.95 | 4.00 | 2.98 | - | 0.19 | low; orquestar 21.83 (2) — no cell |
| GPT-5.4 Mini | gpt-5.4-mini-high | 0.75 | 4.50 | 3.25 | - | 0.075 | low; Mini; no high |
| Muse Spark 1.3 | muse-spark-1.3-high | 1.25 | 4.25 | 3.25 | - | 0.15 | low; CursorBench-4.0 33.4% only (W) — no cell |
| GLM 5.2 | glm-5.2-high | 1.40 | 4.40 | 3.40 | - | 0.26 | low; no admitted High-effort primary row |
| Claude 4.5 Haiku | claude-4.5-haiku-thinking | 1.00 | 5.00 | 3.67 | 1.25 | 0.10 | low; not budget (cw $1.25 &gt; $1/M) |
| Grok 4.7 | grok-4.7-xhigh | 2.00 | 6.00 | 4.67 | - | 0.50 | budget/low/cursor (`bar_drain` ≈ 0.31); debug/verify |
| Grok 4.6 | cursor-grok-4.6-medium | 2.00 | 6.00 | 4.67 | - | 0.50 | budget/low/high/cursor orchestrator (`bar_drain` ≈ 0.31) |
| Grok 4.5 | cursor-grok-4.5-high | 2.00 | 6.00 | 4.67 | - | 0.50 | budget/low/high/cursor explore |
| Gemini 3.6 Flash | gemini-3.6-flash-medium | 1.50 | 7.50 | 5.50 | - | 0.15 | mid |
| Gemini 3.5 Flash | gemini-3.5-flash | 1.50 | 9.00 | 6.50 | - | 0.15 | mid |
| Claude Sonnet 5 | claude-sonnet-5-thinking-medium | 2.00 | 10.00 | 7.33 | 2.50 | 0.20 | mid |
| Gemini 3.1 Pro | gemini-3.1-pro | 2.00 | 12.00 | 8.67 | - | 0.20 | mid/high verify |
| GPT-5.6 Terra | gpt-5.6-terra-medium | 2.00 | 12.00 | 8.67 | 2.50 | 0.20 | mid orchestrator / debug (`bar_drain` 8.67) |
| GPT-5.2 | gpt-5.2 | 1.75 | 14.00 | 9.92 | - | 0.175 | mid write |
| GPT-5.3 Codex | gpt-5.3-codex | 1.75 | 14.00 | 9.92 | - | 0.175 | mid |
| GPT-5.4 | gpt-5.4-medium | 2.50 | 15.00 | 10.83 | - | 0.25 | mid |
| Claude 4 Sonnet | claude-4-sonnet | 3.00 | 15.00 | 11.00 | 3.75 | 0.30 | mid |
| Claude 4.6 Sonnet | claude-4.6-sonnet-medium-thinking | 3.00 | 15.00 | 11.00 | 3.75 | 0.30 | mid; LiveBench only → `sin-tag` |
| Kimi K3 | kimi-k3-max | 3.00 | 15.00 | 11.00 | - | 0.30 | mid explore/implement/decide/plan; mid/high research W |
| Composer 2.5 Fast | composer-2.5-fast | 3.00 | 15.00 | 11.00 | - | 0.50 | Fast; not assigned |
| GPT-5.6 Sol | gpt-5.6-sol-medium | 4.00 | 20.00 | 14.67 | 5.00 | 0.40 | high; out $20 ≥ 18 → not mid; verify 40.00 (2) &lt; 3.1 |
| Claude Opus 5.5 | claude-opus-5-5-medium | 4.00 | 20.00 | 14.67 | 5.00 | 0.20 | high |
| Claude Opus 5 / 4.8 / 4.6 | claude-opus-5-thinking-high / claude-opus-4-8-thinking-high / claude-4.6-opus-high-thinking | 5.00 | 25.00 | 18.33 | 6.25 | 0.50 | high |
| GPT-5.5 | gpt-5.5-medium | 5.00 | 30.00 | 21.67 | - | 0.50 | high |
| Claude Fable 5 / 5.1 | claude-fable-5-thinking-high / claude-fable-5-1-thinking-high | 10.00 | 50.00 | 36.67 | 12.50 | 1.00 / 0.25 | high only ($10/$50) |
| Claude Opus 4.7 fast | claude-opus-4-7-thinking-xhigh | 30.00 | 150.00 | 110.00 | 37.50 | 3.00 | preview; outside all tiers; no xhigh row |
| Gemini 3 Pro Image | gemini-3-pro-image-preview | 2.00 | 12.00 | 8.67 | - | 0.20 | image; outside code matrix |

Not assigned (no Task slug): GPT-5 / Codex family except 5.3, Gemini 3 Pro (text), Grok Fast / 500k, Claude 4.5 Sonnet, Claude 4.7 Opus.

## Fichas (assigned + budget)

Percentile among policy models with that datum. Date = collector snapshot 2026-09-22 unless noted. Rejected: vendor system cards, listicles, sibling-effort rows.

### gpt-5.4-nano-xhigh

in 0.20 · out 1.25 · cost 0.90 · cw `-` · cr 0.02

| page | benchmark_id | score | url | tag | percentile |
|---|---|---|---|---|---:|
| AA | SciCode-AA | 47% (xhigh) | https://artificialanalysis.ai/ | implementar | 20 (N=11) |
| AA | Terminal-Bench-4.0 | 1% (xhigh) | AA comparison | depurar | 16.7 (N=13) |
| AA | AutomationBench-AA | 6% (xhigh) | AA comparison | orquestar | 13.6 (N=12) |
| AA | GDPval-AA-v2.1 | 937 Elo (xhigh) | https://artificialanalysis.ai/evaluations/gdpval-aa | orquestar | 21.4 (N=15) |
| AA | AA-LCR-v1.1 | 77% (xhigh) | AA comparison | explorar | 30.8 (N=14) |
| AA | HLE-AA | 28% (xhigh) | AA | decidir | 20 (N=11) |
| AA | AA-Omniscience-Index | −29 (xhigh) | AA | verificar | 0 (N=14) |

Tag (rescored N after late records): orquestar 13.69 (2, **strong**); implementar 16.67 (1, W); explorar 25.00 (1, W); decidir 16.67 (1, W); depurar 20.00 (1, W).

### gpt-5-mini

in 0.25 · out 2.00 · cost 1.42 · cw `-` · cr 0.025

| page | benchmark_id | score | url | tag | percentile |
|---|---|---|---|---|---:|
| AA | AutomationBench-AA | 6% (high) | AA | orquestar | 13.6 (N=12) |
| AA | GDPval-AA-v2.1 | 754 Elo | AA | orquestar | 7.1 (N=15) |
| AA | AA-Omniscience-Index | −17 | AA | verificar | 7.7 (N=14) |
| Arena | Arena-Text-Overall | 1390±5 | https://arena.ai/leaderboard/text | redactar | 0 (N=11) |

Tag (rescored): orquestar 8.13 (2, **strong**); verificar 6.67 (1, W); redactar 0 (1, W).

### gemini-2.5-flash

in 0.30 · out 2.50 · cost 1.77 · cw `-` · cr 0.03

| page | benchmark_id | score | url | tag | percentile |
|---|---|---|---|---|---:|
| Arena | Arena-Text-Overall | 1410±2 | https://arena.ai/leaderboard/text | redactar | 20 (N=11) |
| BenchLM / AA | AA-LCR-v1.1 | 49.9% | https://benchlm.ai/models/gemini-2-5-flash | explorar | 7.7 (N=14) |

Tag (rescored): redactar 20 (1, W); explorar 6.25 (1, W).

### composer-2.5

in 0.50 · out 2.50 · cost 1.83 · cw `-` · cr 0.20

| page | benchmark_id | score | url | tag | percentile |
|---|---|---|---|---|---:|
| CursorBench | CursorBench-4.0 | 27.7% | https://cursor.com/cursorbench | implementar | 9.09 (N=12) |

Tag: implementar 9.09 (1, W). orquestar unknown.

### gemini-3.7-flash-high

in 0.75 · out 3.50 · cost 2.58 · cw `-` · cr 0.075

| page | benchmark_id | score | url | tag | percentile |
|---|---|---|---|---|---:|
| AA | AutomationBench-AA | 62% (high) | https://artificialanalysis.ai/evaluations/automationbench-aa | orquestar | 90.9 (N=12) |
| AA | GDPval-AA-v2.1 | 1371 Elo | https://artificialanalysis.ai/evaluations/gdpval-aa | orquestar | 57.1 (N=15) |
| AA | AA-LCR-v1.1 | 82% | AA | explorar | 80.8 (N=14) |
| AA | HLE-AA | 48% | AA | decidir | 75 (N=11) |
| ARC Prize | ARC-AGI-2 | 84.6% | https://arcprize.org/results/google-gemini-3-7-flash | decidir | 50 (N=9) |
| ARC Prize | ARC-AGI-1 | 95.5% | same | decidir | 50 (N=8) |
| AA | SciCode-AA | 57% | AA | implementar | 85 (N=11) |
| AA / Vals median | Terminal-Bench-4.0 | 9.85% | AA 13.636 + Vals 6.06 | depurar | 50 (N=13) |

Tag (rescored): orquestar 74.21 (2, **strong**); decidir 69.27 (3, **strong**); explorar 78.12 (1, W); implementar 83.33 (1, W). Not low orchestrator: 3.8 76.19 on orquestar (neither dominates).

### gemini-3.8-flash-high

in 0.75 · out 3.50 · cost 2.58 · cw `-` · cr 0.075

| page | benchmark_id | score | url | tag | percentile |
|---|---|---|---|---|---:|
| CursorBench | CursorBench-4.0 | 39.6% (High) | https://cursor.com/cursorbench | implementar | 50 (N=9) |
| DeepSWE | DeepSWE-v1.1 | 74% (high) | https://deepswe.datacurve.ai/ | implementar | 100 (N=5) |
| AA | SciCode-AA | 57% (high) | AA | implementar | 85 (N=11) |
| AA | AutomationBench-AA | 60% | AA | orquestar | 81.8 (N=12) |
| AA | GDPval-AA-v2.1 | 1412 Elo | AA (comparison 1412; eval page 1464 — used comparison) | orquestar | 64.3 (N=15) |
| AA | Terminal-Bench-4.0 | 20% | AA | depurar | 75 (N=13) |
| AA | HLE-AA | 48% | AA | decidir | 75 (N=11) |
| AA | AA-LCR-v1.1 | 81% | AA | explorar | 65.4 (N=14) |
| AA | AA-Omniscience-Index | 30 | AA | verificar | 69.2 (N=14) |
| Arena | Arena-Text-Overall | 1493±9 | https://arena.ai/leaderboard/text | redactar | 80 (N=11) |

Tag (rescored): implementar 82.32 (3, **strong** — **low implement**); orquestar 76.19 (2, **strong**, lost orchestrator to pool Grok `bar_drain` 0.31); redactar 80 (1, W — **low write**); depurar 80 (1, W); verificar 73.33 (1, W); decidir 79.17 (1, W); explorar 65.62 (1, W). **low plan**.

### cursor-grok-4.6-medium

in 2.00 · out 6.00 · cost 4.67 · cw `-` · cr 0.50

| page | benchmark_id | score | url | tag | percentile |
|---|---|---|---|---|---:|
| AA | AutomationBench-AA | 63% (medium) | AA | orquestar | 100 (N=12) |
| AA | GDPval-AA-v2.1 | 1605 Elo | AA | orquestar | 85.7 (N=15) |
| CursorBench | CursorBench-4.0 | 36.1% | https://cursor.com/cursorbench | implementar | 37.5 (N=9) |
| DeepSWE | DeepSWE-v1.1 | 67% | https://deepswe.datacurve.ai/ | implementar | 75 (N=5) |
| AA | SciCode-AA | 56% | AA | implementar | 70 (N=11) |
| AA | HLE-AA | 42% | AA | decidir | 45 (N=11) |
| ARC Prize | ARC-AGI-2 | 61.3% | https://arcprize.org/results/xai-grok-4-6 | decidir | 37.5 (N=9) |
| ARC Prize | ARC-AGI-1 | 87.5% | same | decidir | 28.6 (N=8) |
| AA | Terminal-Bench-4.0 | 13% | AA | depurar | 66.7 (N=13) |

Tag (rescored): orquestar 94.44 (2, **strong** — **budget/low/high/cursor orchestrator**); implementar 60.40 (3, **strong** — **budget/cursor implement**); decidir 41.82 (3, **strong** — **budget decide**; mid decide stays K3). `bar_drain` ≈ 0.31 (not mid).

### cursor-grok-4.5-high

in 2.00 · out 6.00 · cost 4.67 · cw `-` · cr 0.50

| page | benchmark_id | score | url | tag | percentile |
|---|---|---|---|---|---:|
| AA | AutomationBench-AA | 58% (high) | AA | orquestar | 72.7 (N=12) |
| AA | GDPval-AA-v2.1 | 1430 Elo | AA | orquestar | 71.4 (N=15) |
| AA | AA-LCR-v1.1 | 79% | AA | explorar | 42.3 (N=14) |
| Mercor | BrowseComp | 75.8% (High) | https://www.mercor.com/apex/oss-benchmarks/oss-browsecomp-leaderboard/ | explorar | 100 (N=3) |
| AA | HLE-AA | 43% | AA | decidir | 60 (N=11) |
| ARC Prize | ARC-AGI-2 | 52.6% | https://arcprize.org/results/xai-grok-4-5 | decidir | 25 (N=9) |
| ARC Prize | ARC-AGI-1 | 85.7% | same | decidir | 14.3 (N=8) |

Tag (rescored): explorar 68.75 (2, **strong** — **budget/low/high/cursor explore** + **budget/cursor research** W); orquestar 75.40 (2, **strong**, **dominated** by 4.6); decidir 37.98 (3). Research mid/high lost to K3 (both W; K3 LCR pct 100). `bar_drain` ≈ 0.31 (not mid).

### grok-4.7-xhigh

in 2.00 · out 6.00 · cost 4.67 · cw `-` · cr 0.50

| page | benchmark_id | score | url | tag | percentile |
|---|---|---|---|---|---:|
| CursorBench | CursorBench-4.0 | 46.3% (Extra High) | https://cursor.com/cursorbench | implementar | 75 (N=9) |
| Vals | Terminal-Bench-4.0 | 28.28% (xhigh) | https://www.vals.ai/ | depurar | 83.3 (N=13) |
| AA | GDPval-AA-v2.1 | 1695 Elo (xhigh) | AA article | orquestar | 100 (N=15) |
| AA | AA-Omniscience-Index | 32 (xhigh) | AA article | verificar | 80.8 (N=14) |

Tag: orquestar 100 (1, W, cannot occupy vs 4.6); implementar 75 (1, W); depurar 83.3 (1, W); verificar 80.8 (1, W). Official DeepSWE had **no** xhigh row.

### claude-fable-5-1-thinking-high

in 10.00 · out 50.00 · cost 36.67 · cw 12.50 · cr 0.25 · high only

| page | benchmark_id | score | url | tag | percentile |
|---|---|---|---|---|---:|
| CursorBench | CursorBench-4.0 | 49.2% (High) | https://cursor.com/cursorbench | implementar | 87.5 (N=9) |
| AA | SciCode-AA | 58.7% | https://artificialanalysis.ai/evaluations/scicode | implementar | 100 (N=11) |
| AA | AutomationBench-AA | 55% | AA | orquestar | 63.6 (N=12) |
| AA | GDPval-AA-v2.1 | 1650 Elo | AA | orquestar | 92.9 (N=15) |
| AA | HLE-AA | 55.9% | https://artificialanalysis.ai/evaluations/humanitys-last-exam | decidir | 100 (N=11) |
| ARC Prize | ARC-AGI-2 | 88.8% | https://arcprize.org/results/anthropic-claude-fable-5-1 | decidir | 100 (N=9) |
| ARC Prize | ARC-AGI-1 | 96.0% | same | decidir | 71.4 (N=8) |
| AA | Terminal-Bench-4.0 | 52% | AA | depurar | 100 (N=13) |

Tag (rescored): implementar 95.45 (2); orquestar 82.94 (2); decidir 93.33 (3); depurar 100 (1, W).

### claude-4.6-opus-high-thinking

in 5.00 · out 25.00 · cost 18.33 · cw 6.25 · cr 0.50

| page | benchmark_id | score | url | tag | percentile |
|---|---|---|---|---|---:|
| LMArena | Arena-Text-Overall | 1505±4 | https://lmarena.ai/leaderboard/text | redactar | 90 (N=11) |
| Arena | Arena-Text-LongerQuery | 1524±5 | https://arena.ai/leaderboard/text/longer-query | redactar | 100 (N=2) |

Tag: redactar 95 (2, **strong**).

### gemini-3.1-pro

in 2.00 · out 12.00 · cost 8.67 · cw `-` · cr 0.20

| page | benchmark_id | score | url | tag | percentile |
|---|---|---|---|---|---:|
| AA | AA-Omniscience-Index | 32 | AA | verificar | 80.8 (N=14) |
| Kaggle | FACTS-Grounding-v2 | 67% | https://www.kaggle.com/benchmarks/google/facts-grounding/leaderboard | verificar | 0 (N=4) |
| AA | AutomationBench-AA | 35% | AA | orquestar | 27.3 (N=12) |
| AA | GDPval-AA-v2.1 | 904 Elo | AA | orquestar | 14.3 (N=15) |

Tag (rescored): verificar 41.67 (2, **strong** — Omni 83.33 N=16 + FACTS 0 N=4); orquestar 23.41 (2).

### gpt-5.2

in 1.75 · out 14.00 · cost 9.92 · cw `-` · cr 0.175

| page | benchmark_id | score | url | tag | percentile |
|---|---|---|---|---|---:|
| Kaggle | FACTS-Grounding-v2 | 76.2% | https://www.kaggle.com/benchmarks/google/facts-grounding/leaderboard | verificar | 100 (N=4) |
| Arena | Arena-Text-Overall | 1436±3 | https://arena.ai/leaderboard/text | redactar | 40 (N=11) |
| BenchLM | BrowseComp | 65.8% | https://benchlm.ai/benchmarks/browsecomp | explorar | 50 (N=3) |

Tag: redactar 40 (1, W); verificar 100 (1, W). Weak verificar cannot beat 3.1’s 2 ids.

### claude-opus-5-thinking-high

in 5.00 · out 25.00 · cost 18.33 · cw 6.25 · cr 0.50

Tag (rescored): decidir 92.53 (3); orquestar 71.03 (2); implementar 61.36 (2); depurar 93.33 (1, W). Did not win a cell (Fable 5.1 higher on decide/implement/debug; 4.6 higher on orquestar).

### kimi-k3-max

in 3.00 · out 15.00 · cost 11.00 · cw `-` · cr 0.30 · mid + high

| page | benchmark_id | score | url | tag | percentile |
|---|---|---|---|---|---:|
| AA | AA-LCR-v1.1 | 88.7% (max) | https://artificialanalysis.ai/evaluations/artificial-analysis-long-context-reasoning | explorar | 100 (N=17) |
| AA | GDPval-AA-v2.1 | 1584 Elo | https://artificialanalysis.ai/evaluations/gdpval-aa | orquestar | 83.33 (N=19) |
| DeepSWE | DeepSWE-v1.1 | 69% (max) | https://deepswe.datacurve.ai/ | implementar | 80 (N=6) |
| ARC Prize | ARC-AGI-2 | 60.4% | https://arcprize.org/ | decidir | 36.36 (N=12) |
| ARC Prize | ARC-AGI-1 | 94.5% | https://arcprize.org/ | decidir | 50 (N=11) |

Tag: decidir 43.18 (2, **strong** — **mid decide** / **mid plan**); explorar 100 (1, W — **mid explore** + **mid/high research** W); orquestar 83.33 (1, W, dominated on the shared GDPval by 4.6); implementar 80 (1, W — **mid implement**). Rejected: Vals Index (`sin-tag`); τ-bench N=1; Arena English ≠ Overall.

### gpt-5.6-sol-medium

in 4.00 · out 20.00 · cost 14.67 · cw 5.00 · cr 0.40 · high only (out ≥ $18)

| page | benchmark_id | score | url | tag | percentile |
|---|---|---|---|---|---:|
| AA | AutomationBench-AA | 51% | AA | orquestar | 57.14 (N=15) |
| AA | GDPval-AA-v2.1 | 1403 Elo | AA | orquestar | 61.11 (N=19) |
| CursorBench | CursorBench-4.0 | 31.1% | https://cursor.com/cursorbench | implementar | 36.36 (N=12) |
| AA | SciCode-AA | 57% | AA | implementar | 83.33 (N=13) |
| AA | Terminal-Bench-4.0 | 15% | AA | depurar | 73.33 (N=16) |
| AA | HLE-AA | 42% | AA | decidir | 50 (N=13) |
| ARC Prize | ARC-AGI-2 | 67.1% | https://arcprize.org/ | decidir | 54.55 (N=12) |
| ARC Prize | ARC-AGI-1 | 92.5% | https://arcprize.org/ | decidir | 40 (N=11) |
| AA | AA-Omniscience-Index | 19 | AA | verificar | 46.67 (N=16) |
| Kaggle | FACTS-Grounding-v2 | 68.7% | https://www.kaggle.com/benchmarks/google/facts-grounding/leaderboard | verificar | 33.33 (N=4) |
| AA | AA-LCR-v1.1 | 80% | AA | explorar | 53.12 (N=17) |

Tag: orquestar 59.13 (2); implementar 59.85 (2); decidir 48.18 (3); verificar 40.00 (2, **strong** — below 3.1 41.67). Terminal-Bench-Hard-AA medium 62.9% is N=1 → coverage only.

### gpt-5.6-terra-medium

in 2.00 · out 12.00 · cost 8.67 · cw 2.50 · cr 0.20 · mid + high (not budget: cw billed)

| page | benchmark_id | score | url | tag | percentile |
|---|---|---|---|---|---:|
| AA | AutomationBench-AA | 34% | AA | orquestar | 28.57 (N=15) |
| AA | GDPval-AA-v2.1 | 1318 Elo | AA | orquestar | 44.44 (N=19) |
| CursorBench | CursorBench-4.0 | 27.6% | https://cursor.com/cursorbench | implementar | 0 (N=12) |
| AA | Terminal-Bench-4.0 | 1% | AA | depurar | 20 (N=16) |
| ARC Prize | ARC-AGI-2 | 37.5% | https://arcprize.org/ | decidir | 0 (N=12) |
| ARC Prize | ARC-AGI-1 | 77.0% | https://arcprize.org/ | decidir | 0 (N=11) |

Tag: orquestar 36.51 (2 — **mid orchestrator**); decidir 0 (2); depurar 20 (1, W — **mid debug**). Rejected: SciCode / τ² from OpenRouter (aggregator).

### kimi-k2.7-code

in 0.95 · out 4.00 · cost 2.98 · cw `-` · cr 0.19 · low + high (cost ≥ 2 → not budget)

| page | benchmark_id | score | url | tag | percentile |
|---|---|---|---|---|---:|
| AA | AutomationBench-AA | 24% | AA | orquestar | 21.43 (N=15) |
| AA | GDPval-AA-v2.1 | 1114 Elo | AA | orquestar | 22.22 (N=19) |
| AA | SciCode-AA | 48% | AA | implementar | 25 (N=13) |
| AA | Terminal-Bench-4.0 | 1% | AA | depurar | 20 (N=16) |
| AA | HLE-AA | 35% | AA | decidir | 33.33 (N=13) |
| AA | AA-Omniscience-Index | −10 | AA | verificar | 20 (N=16) |
| AA | AA-LCR-v1.1 | 79% | AA | explorar | 37.50 (N=17) |

Tag: orquestar 21.83 (2, **strong**); others W. No cell. Rejected: Moonshot system-card benches; BenchLM CursorBench 3.2 (not official 4.0); LiveCodeBench / SWE-Verified Vals as N=1 coverage only.

### muse-spark-1.3-high

in 1.25 · out 4.25 · cost 3.25 · cw `-` · cr 0.15 · low + high

| page | benchmark_id | score | url | tag | percentile |
|---|---|---|---|---|---:|
| CursorBench | CursorBench-4.0 | 33.4% (High) | https://cursor.com/cursorbench | implementar | 45.45 (N=12) |

Tag: implementar 45.45 (1, W). Integration-Bench = `sin-tag`. No cell.
