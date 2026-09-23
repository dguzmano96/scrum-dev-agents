# Sources ledger

Summary snapshot: **2026-09-22**.  
`precios_consultados`: 2026-09-22  
`benchmarks_consultados`: 2026-09-22  
`vence`: 2026-10-22 (**one month** after `precios_consultados`; price table only).

`benchmarks_consultados` is an audit stamp. Benchmark scores do **not** expire by date. `vence` does **not** mark benchmarks as VENCIDAS.

**Canonical methodology** for capacity lives in this file. `AGENTS.md`, `rules/cursor-agent-policy.mdc`, `docs/matriz.md`, and skill `cursor-agent-policy` **point here**. They must not restate a closed list of ten sites as the only allowed scores.

## Methodology (closed math, open registry)

The **math** is closed and deterministic. The **source set** is an open registry. A URL is admitted only when **every** gate is true. The original ten URLs stay as already-admitted examples. They are **not** a ceiling and not the only place a score may come from.

### Admission gates (all required)

1. Public page with **per-model numeric scores** for a named benchmark.
2. The **benchmark name** is visible and, when the site separates them, the **variant** and **harness** are visible.
3. The page is the benchmark’s **primary host** (the project that runs that eval) **or** an independent leaderboard that shows those per-model numbers and **points at** that host.
4. It is **not** a listicle, newsletter, SEO roundup, or a single-vendor **system card**. A system card may be cited on a ficha and **does not** add a score.
5. Scores are for **named models**, not an anonymous average.

### Dedup

Several URLs for the same `benchmark_id` are **one** observation.

```text
benchmark_id = normalized name + variant + harness
```

The **primary host** supplies the number. Extra copies do not increase coverage and are not averaged with a different benchmark. Terminal-Bench 2.x ≠ Terminal-Bench 4.0. SWE-bench Verified ≠ CursorBench.

If two **primary-class** sources disagree on the **same** `benchmark_id`, record both, use the **median**, and record the **spread**. Never average different `benchmark_id`s.

### Closed tag map

A benchmark receives a tag **only** by this table. If the name matches no row, tag `sin-tag`, list it, and **exclude** it from the score. Do not force a tag. Do not fill a cell with a different tag.

| Tag | Exact name families |
|---|---|
| implementar | SWE-bench and named variants, CursorBench, SciCode, LiveCodeBench, DeepSWE |
| depurar | Terminal-Bench (each version is its own `benchmark_id`) |
| orquestar | AutomationBench, OSWorld, tau-bench, agentic GDPval |
| explorar | AA-LCR, BrowseComp, MRCR |
| decidir | HLE, GPQA, ARC-AGI, AIME |
| interpretar | document-reading benchmarks **that the page names as that task** (AA-LCR and MRCR stay **explorar** if that is what the page calls them) |
| verificar | AA-Omniscience and equivalents whose page states hallucination, omniscience, or factual-error / factuality rate |
| redactar | text Arena preference (separate ids when the page separates them) |

Composites stay `sin-tag`: AA Intelligence Index, BenchLM overall, Coding Agent Index, any overall index.

Task mapping (unchanged): orchestrator → orquestar; explore → explorar; implement → implementar; decide → decidir; debug → depurar; interpret → interpretar; verify → verificar; plan = mean of orquestar and decidir (weak if only one exists); research = mean of explorar and interpretar (same); review → verificar; write → redactar.

### Math

For each `benchmark_id`, among the **N** policy models that have that datum (missing = unknown, not zero):

```text
percentile = 100 * (W + (T - 1) / 2) / (N - 1)
```

- `W` = count of those models with a **strictly worse** raw score
- `T` = size of the tie group including self
- Higher raw score is better unless the page says lower is better (invert)
- If `N = 1`: coverage only; **not** a contest; that id cannot decide a cell by itself against a model that lacks it

Tag score = simple mean of percentiles of that tag’s `benchmark_id`s the model has. **Do not multiply by coverage.** Missing a source does not lower the score.

Publish coverage: distinct `benchmark_id`s of that tag with data, and how many **admitted** sources mention the model.

Weak = fewer than 2 distinct `benchmark_id`s. A weak score does not beat a same-tag score with ≥2 ids. If the rival has **zero** data on that tag, the weak score **may** be used and the cell says so.

Unknown is not zero. Do not copy a sibling checkpoint (effort, Fast, medium vs high) unless the page says it is the same checkpoint; then reuse the row and mark it.

Cell fill, dominance, and tie-break: see [`docs/matriz.md`](matriz.md). Dominance: if A is better on **all** shared `benchmark_id`s of that tag and `cost(A) ≤ cost(B)`, B cannot occupy the cell. Empty cell if nobody eligible has even one tagged id. No proxy.

Score date does **not** penalize. `vence` does **not** mark benchmarks VENCIDAS.

### Refresh (prices + registry)

Keep the monthly price procedure (`vence` 2026-10-22). The **same** pass also:

1. Re-fetch **every** admitted URL.
2. **Discover** new URLs for the families in the tag map. Admit one only if the gates pass. Append it with date, `benchmark_id`s, and tag.
3. Replace a score only with a **newer published number of the same** `benchmark_id`.
4. If new models appear on the Cursor price page, score them from the registry (and discovery), then recompute percentiles for the **whole** policy set (percentiles are relative).
5. Reassign a cell only when eligibility, a percentile, dominance, or the cost tie-break changed.

A **price-only** change of models already in the set does **not** require new benchmarks; it **does** re-check gates, dominance, and tie-break. A **new model** or a **new admitted** `benchmark_id` does require rescoring.

A dead URL is marked **dead**. Replace it only with the **same** benchmark’s new official host. Do not substitute a different test to fill a hole.

**Who fetches vs who decides** (full text: [`AGENTS.md`](../AGENTS.md) §5.1): only during a **model-policy update**. The collector model is **chosen at the start of that update** from the Cursor list just fetched (https://cursor.com/docs/models-and-pricing, contrast ES). Criterion: cheapest `cost` among slugs the Task catalog accepts that can web-search. `cost = (input + 2 * output) / 3`. Tiers do **not** apply (not the active mode’s column, not the four-model cursor pool). Fast loses. If the cheapest row cannot web-search or has no Task slug, **skip it here** and take the next. Record the chosen slug in **that update’s log only**. Do not pin a default. One collector per target model (parallel); facts only (price row + admitted-source rows; `unknown` if missing). No tiers, percentiles, dominance, or file edits. Scrum agents and process skills never use this role. After collectors return, the **mode’s orchestrator row** applies the written math (deterministic).

### Price refresh steps (when `vence` passed)

1. If today > `vence` or `precios_consultados` is more than one calendar month old: stale on price. Before assigning a slug, open https://cursor.com/docs/models-and-pricing and contrast https://cursor.com/es/docs/models-and-pricing.
2. Update input, output, cache write, cache read. `cost = (input + 2 * output) / 3`. Regional +10% stays out.
3. Re-check budget / low / mid / high / cursor eligibility. Redo cells if eligibility, dominance, or cost tie-break changed. New `precios_consultados`; `vence` = that date + one month.
4. New models: not price-only. Score from this registry + discovery. Same `benchmark_id` only; unknown stays unknown; no sibling copy unless same checkpoint; one tag; percentile among policy models with that datum; recompute the **whole** set. No proxy fill.
5. Price-only refresh of models already in the set: do **not** re-fetch benchmarks; **do** re-check gates, dominance, and tie-break.

## Run log (blank slate 2026-09-22)

Collector for **this run only** (not a default, not a matrix cell):

| field | value |
|---|---|
| slug | `gpt-5.6-luna-high` |
| input | $0.20/M |
| output | $1.20/M |
| cache write | $0.25/M (billed) |
| cache read | $0.02/M |
| `cost` | 0.87 |
| why | Cheapest Task slug that passed a live WebSearch probe. Beat next candidate `gpt-5.4-nano-xhigh` (`cost` 0.90). Docs do not list Luna/Nano as collectors; probe required. |

Skips before Luna: none (Luna is cheapest Task row; Fast siblings lose). Probe: one WebSearch (`Cursor GPT-5.6 Luna pricing`) → WEBSEARCH_OK.

Collectors launched: **37** (one Task per non-Fast, non-auto, non-image Task slug). Returned: **37**. Failed: **0**. Late records (second wave): `gpt-5.6-sol-medium`, `gpt-5.6-terra-medium`, `kimi-k2.7-code`, `kimi-k3-max`, `muse-spark-1.3-high`. Whole-set percentiles recomputed after those five.

Each collector searched **admitted sources**, not only the Cursor price row.

Target skips (no collector): Fast rows; `auto`; `gemini-3-pro-image-preview`; priced names with no Task slug (GPT-5, Gemini 3 Pro text, Claude 4.5 Sonnet, Claude 4.7 Opus, Grok 500k / Fast). `claude-opus-4-7-thinking-xhigh` was collected; stays outside every tier (preview).

## Pricing (Cursor docs, EN vs ES)

| Date | URL | What was used |
|---|---|---|
| 2026-09-22 | https://cursor.com/docs/models-and-pricing | Official EN table (primary). Input / cache write / cache read / output per million tokens. |
| 2026-09-22 | https://cursor.com/es/docs/models-and-pricing | ES variant. Numeric table **matched EN** (same `$` figures, including cache `-` vs billed cache write). Used EN. |
| 2026-09-22 | https://cursor.com/docs/enterprise/privacy-and-data-governance | Regional residency +10% noted; **not** in `cost`. |

### Formula

```text
cost = (input_usd_per_M + 2 * output_usd_per_M) / 3
```

Cache write / cache read are recorded per model. If the page does not publish cache prices for that model, the model is **not** eligible for `budget`.

### Budget gates (all three required)

Read from the 2026-09-22 table (`-` = no separate cache-write price / treated as free):

1. `cost` < 2
2. cache write has no price (`-`, 0, included)
3. cache read < that model’s uncached input

Models that passed all three **and** have a Task slug:

| slug | in | out | cost | cache write | cache read | gates |
|---|---:|---:|---:|---|---:|---|
| `gpt-5.4-nano-xhigh` | 0.20 | 1.25 | 0.90 | `-` | 0.02 | 1+2+3 |
| `gpt-5-mini` | 0.25 | 2.00 | 1.42 | `-` | 0.025 | 1+2+3 |
| `gemini-2.5-flash` | 0.30 | 2.50 | 1.77 | `-` | 0.03 | 1+2+3 |
| `composer-2.5` | 0.50 | 2.50 | 1.83 | `-` | 0.20 | 1+2+3 |

`gpt-5.6-luna-high`: in 0.20, out 1.20, `cost` 0.87, cache write **$0.25**, cache read $0.02. Fails gate 2 (billed cache write). Eligible **low**, not budget. **This run’s collector** (log only).

Gemini 3.8 Flash: EN/ES list output **$3.50**. **Used Cursor $3.50.** `cost` = (0.75 + 7.00) / 3 = **2.58**.

## Registry (admitted)

### Already-admitted examples (original 10; not a cap)

| # | URL | Date | Status | benchmark_id(s) | Tag |
|---|---|---|---|---|---|
| 1 | https://artificialanalysis.ai/ | 2026-09-22 | Live (JS charts). Independent store; component pages below | many AA evals; `AA-Intelligence-Index-v4.3.2` | store; Index = `sin-tag` |
| 2 | https://cursor.com/cursorbench | 2026-09-22 | Live | `CursorBench-4.0` | implementar |
| 3 | https://www.swebench.com/ | 2026-09-22 | Live tabs; **no numeric rows** in fetched HTML | SWE-bench Verified (official) | implementar; score **unknown** |
| 4 | https://www.vals.ai/ | 2026-09-22 | Live | `Vals-Index`; `Terminal-Bench-4.0-Vals` | `Vals-Index` = `sin-tag` (name matches no row); TB 4.0 = depurar |
| 5 | https://lmarena.ai/leaderboard | 2026-09-22 | Live (landing `/` is a builder) | Arena text / longer-query | redactar (preference; separate ids if the page separates them) |
| 6 | https://arena.ai/leaderboard | 2026-09-22 | Live | `Arena-Text-Overall`; `Arena-Text-LongerQuery`; `Arena-Document`; `Arena-Agent` | Text* = redactar; Document = interpretar (page names Document); Agent = `sin-tag` (not in orquestar families) |
| 7 | https://labs.scale.com/leaderboard/swe_bench_pro_public | 2026-09-22 | Live | `SWE-Bench-Pro-public` | implementar |
| 8 | https://leaderboard.steel.dev/leaderboards/swe-bench-verified/ | 2026-09-22 | Live 2026-09-04 | `SWE-bench-Verified` | implementar; mix of Vals harness + **system cards** — card rows do not score |
| 9 | https://benchlm.ai/ | 2026-09-22 | Live | BenchAlign overall | `sin-tag` |
| 10 | https://deepswe.datacurve.ai/ | 2026-09-22 | Live v1.1 | `DeepSWE-v1.1` | implementar |

This blank-slate pass applies the closed map only. `Vals-Index`, `Arena-Agent`, and composites stay `sin-tag`. `Arena-Text-LongerQuery` is **redactar**. `orquestar` came from AutomationBench-AA + GDPval-AA (2 ids). `explorar` from AA-LCR + BrowseComp. `interpretar` had no N≥2 contest.

### AA component pages (same store as #1; not a new site)

Admitted 2026-09-22 as independent AA evals that point at the benchmark host. Charts are JS; **per-model numbers used only when the fetch showed them**.

| URL | benchmark_id | Tag | Numeric rows this fetch |
|---|---|---|---|
| https://artificialanalysis.ai/evaluations/humanitys-last-exam | `HLE-AA` | decidir | Leaders only: Opus 5.5 **Max** 61.4%; Fable 5.1 **Max** 59.1%; Fable 5.1 **Xhigh** 58.7%. Task slugs `claude-opus-5-5-medium` / `claude-fable-5-1-thinking-high` ≠ those efforts → **unknown** for catalog slugs |
| https://artificialanalysis.ai/evaluations/gpqa-diamond | `GPQA-Diamond-AA` | decidir | No per-model numbers in HTML → **unknown**; do not score (need ≥2 effort-matched policy rows) |
| https://artificialanalysis.ai/evaluations/omniscience | `AA-Omniscience-Index` | verificar | Index table not in HTML. Accuracy leaders are **Max** (Fable 5.1 67%; Opus 5.5 66%) — Accuracy is **not** a second id; Max ≠ Task effort → Index **unknown** |
| https://artificialanalysis.ai/evaluations/artificial-analysis-long-context-reasoning | `AA-LCR-v1.1` | explorar (page: long-context reasoning) | Kimi K3 **(max)** 88.7% plus 16 other policy rows this pass → **N=17**. K3 pct 100 (1 id → research W) |
| https://artificialanalysis.ai/evaluations/terminalbench-hard | `Terminal-Bench-Hard-AA` | depurar | Sol **max** 65.9%; Fable 5 **Max** 62.9%; Sol **medium** 62.9%. Only `gpt-5.6-sol-medium` effort-matches → **N=1**; no cell change |
| https://artificialanalysis.ai/evaluations/terminalbench-4-0 | `Terminal-Bench-4.0` | depurar | **Same id** as Vals TB 4.0 — copy, not a second depurar id |
| https://artificialanalysis.ai/leaderboards/models | `AA-Intelligence-Index-v4.3.2` | `sin-tag` | Composite; audit only |

Old paths `/evaluations/swe-bench-verified` and `/evaluations/terminal-bench-hard` were **dead** (404) on 2026-09-22. Replaced only by the same-eval live path `terminalbench-hard` (above). Not substituted with a different test.

### New URL admitted this pass (gates passed)

| URL | Date | benchmark_id | Tag | Why admitted |
|---|---|---|---|---|
| https://www.kaggle.com/benchmarks/google/facts-grounding/leaderboard | 2026-09-22 | `FACTS-Grounding-v2` | verificar | Primary/official FACTS board (Google/Kaggle). Per-model numeric table, updated 2026-09-10. Page states factuality / inaccurate rate. ≥2 policy models. Site does not separate effort — one published checkpoint per model name. |

`FACTS-Grounding-v2` rows **this collectors’ return** only (page-default name; not copied from the old ficha):

| display | slug | score |
|---|---|---:|
| GPT-5.2 | `gpt-5.2` | 76.2% |
| Gemini 3.5 Flash | `gemini-3.5-flash` | 73.2% |
| Gemini 3.1 Pro | `gemini-3.1-pro` | 67% |
| GPT-5.6 Sol | `gpt-5.6-sol-medium` | 68.7% |

N=4. Sol 68.7% sits between 3.5 Flash and 3.1 Pro. Gemini 3.1 Pro also has AA-Omniscience → verificar **strong** (2 ids, tag 41.67). Sol also 2 ids (tag 40.00).

### Rejected this discovery (2026-09-22)

| URL / candidate | Reason |
|---|---|
| https://lastexam.ai/leaderboard | No per-model numeric table (contributors only) |
| BenchLeader, LLMBoard, AI Atlas | Listicle / SEO aggregator |
| https://github.com/vectara/Hallucination-leaderboard | Not required this pass (vendor HHEM; not used to fill the zero) |
| AIME 2025 (AA) | Live but saturated (leaders at 1.0); Preview / effort mismatch |
| LiveCodeBench (AA) | Preview-heavy leaders; implementar already has 3 ids |
| SciCode (AA) | Live; left out of scoring this pass (no forced extra implementar id) |
| Steel τ-bench | Aggregator mixing cards / OpenRouter |
| https://the-agent-company.com/ | Empty JS table; no per-model numbers in fetch |
| BrowseComp blogs / LLMBoard | System card / SEO |
| ARC-AGI (arcprize.org), FrontierMath (Epoch), OSWorld | Live families; **not required** this pass to fill the zero (listed, not scored) |
| AA Terminal-Bench 4.0 as a **second** depurar id | Duplicate of `Terminal-Bench-4.0-Vals` |
| OpenAI GDPval / vendor cards | System card; GDPval-AA is the independent store if later extracted |
| OpenRouter (Terra SciCode / τ²) | Aggregator; not primary host |
| Moonshot K2.7 system-card benches | Vendor card; not admitted |
| BenchLM CursorBench 3.2 as CB4 | Different `benchmark_id`; official CursorBench-4.0 had no K2.7 row |

## Dominance recorded (tagged ids; this blank-slate pass)

| B rejected | A | Shared ids | cost |
|---|---|---|---|
| `cursor-grok-4.5-high` on `orquestar` | `cursor-grok-4.6-medium` | AutomationBench-AA (63&gt;58), GDPval-AA (1605&gt;1430) | 4.67 ≤ 4.67 |
| `grok-4.7-xhigh` on `orquestar` | `cursor-grok-4.6-medium` | 4.7 only GDPval-AA (1 id); weak cannot beat 4.6’s 2 ids | 4.67 = 4.67 |
| `grok-4.7-xhigh` on `implementar` | `cursor-grok-4.6-medium` | 4.7 only CursorBench-4.0; weak cannot beat 4.6’s 3 ids | 4.67 = 4.67 |
| `cursor-grok-4.6-medium` on **low** `implementar` | `gemini-3.8-flash-high` | CursorBench 4.0 (39.6&gt;36.1), DeepSWE v1.1 (74&gt;67) | 2.58 ≤ 4.67 |
| `kimi-k3-max` on `orquestar` | `cursor-grok-4.6-medium` | only shared GDPval-AA (1605&gt;1584); K3 has no AutomationBench | 4.67 ≤ 11.00 |

Vals Index is `sin-tag` this pass. Do not copy a sibling’s score unless the page says same checkpoint.

### Task slug vs docs

Pricing page names “Grok 4.7”. Task catalog has `grok-4.7-xhigh`, **not** `grok-4.7-high`. Old slug `cursor-grok-4.6-xhigh` is not in the catalog; use `cursor-grok-4.6-medium`.

---

# Ledger de fuentes

Consulta de síntesis: **2026-09-22**.  
`precios_consultados`: 2026-09-22  
`benchmarks_consultados`: 2026-09-22  
`vence`: 2026-10-22 (**un mes** después de `precios_consultados`; solo tabla de precios).

`benchmarks_consultados` es sello de auditoría. Los scores **no** caducan por fecha. `vence` **no** marca benchmarks como VENCIDAS.

**Metodología canónica** de capacidad: esta página. Los otros cinco archivos **apuntan aquí**. No deben decir que la verdad de capacidad es solo una lista cerrada de diez sitios.

## Metodología (matemática cerrada, registro abierto)

La **matemática** es cerrada y determinista. El **conjunto de fuentes** es un registro abierto. Una URL se admite solo si **todas** las puertas son verdaderas. Las diez URL originales siguen como ejemplos ya admitidos. **No** son un techo ni el único lugar de donde puede salir un score.

### Puertas de admisión (todas)

1. Página pública con **scores numéricos por modelo** de un benchmark nombrado.
2. El **nombre** del benchmark es visible y, si el sitio los separa, también **variante** y **harness**.
3. Es el **anfitrión primario** de esa eval **o** un leaderboard independiente que muestra esos números y **apunta** a ese anfitrión.
4. **No** es listicle, newsletter, ronda SEO ni **system card** de un solo vendor. La system card puede citarse en la ficha y **no** suma score.
5. Los scores nombran **modelos**, no un promedio anónimo.

### Deduplicación

Varias URL del mismo `benchmark_id` son **una** observación.

```text
benchmark_id = nombre normalizado + variante + harness
```

El **anfitrión primario** aporta el número. Las copias no suben la cobertura. Nunca se promedian `benchmark_id` distintos. Terminal-Bench 2.x ≠ 4.0. SWE-bench Verified ≠ CursorBench.

Si dos fuentes de clase primaria discrepan en el **mismo** id: registrar ambas, usar la **mediana**, registrar el **spread**.

### Mapa de tags (cerrado)

Un benchmark recibe tag **solo** por la tabla de la mitad inglesa. Si el nombre no encaja: `sin-tag`, listarlo, **fuera** del score. Sin forzar tag. Sin rellenar una celda con otro tag. Composites (`AA-Intelligence-Index`, BenchLM overall, Coding Agent Index) = `sin-tag`.

Mapeo de tareas: igual que la mitad inglesa (`plan` = media orquestar+decidir, débil si solo hay uno; `research` = explorar+interpretar; `review` = verificar).

### Matemática

Percentil 0–100 entre modelos de política que tienen ese dato. `N=1` no es concurso. Score de tag = media simple de esos percentiles. **Sin** multiplicar por cobertura. Débil = menos de 2 `benchmark_id` distintos. Débil no gana a un score con ≥2 ids. Si el rival no tiene dato en ese tag, el débil **puede** usarse y la celda lo dice. Unknown no es cero. No copiar esfuerzo/Fast/medium/high hermano salvo que la página diga el mismo checkpoint.

Relleno de celdas, dominancia y desempate: [`docs/matriz.md`](matriz.md). La fecha del score **no** penaliza. `vence` **no** marca VENCIDAS.

### Refresco

El pase mensual de precios (`vence` 2026-10-22) **también**: (1) reconsulta cada URL admitida; (2) descubre URL nuevas de las familias del mapa y las admite solo si pasan las puertas; (3) sustituye un score solo por un número más nuevo del **mismo** `benchmark_id`; (4) un modelo nuevo obliga a rescoring y a recalcular percentiles de **todo** el set; (5) reasigna una celda solo si cambió elegibilidad, percentil, dominancia o el desempate por `cost`.

Una URL muerta se marca **dead**. Solo se reemplaza por el **nuevo anfitrión oficial del mismo** benchmark.

Un cambio **solo de precio** de modelos ya fichados no exige benches nuevos; sí puertas / dominancia / desempate.

**Quién consulta vs quién decide** (texto completo: [`AGENTS.md`](../AGENTS.md) §5.1): solo en una **actualización de la política de modelos**. El modelo collector se **elige al inicio de esa actualización** en la lista Cursor recién consultada (https://cursor.com/docs/models-and-pricing, contraste ES). Criterio: el `cost` más bajo entre slugs que Task acepte y que puedan hacer web search. `cost = (input + 2 * output) / 3`. Los tramos **no** aplican. Fast pierde. Si el más barato no puede buscar o no tiene slug Task, **anotarlo aquí** y tomar el siguiente. El slug elegido va **solo en el log de esa pasada**. No fijar un default. Un collector por modelo objetivo (en paralelo); solo hechos. Los agentes Scrum no usan este rol. Después, el orquestador del modo aplica la matemática (determinista).

## Precios

Igual que la mitad inglesa: tabla EN, contraste ES, `cost = (input + 2 * output) / 3`, puertas budget, mismos slugs que pasan.

## Log de esta pasada

Collector de **esta** corrida (no default): `gpt-5.6-luna-high`, in 0.20, out 1.20, `cost` 0.87. Ganó a Nano (`cost` 0.90) tras sonda WebSearch. Cada collector buscó **fuentes admitidas**, no solo precios Cursor. 37 lanzados, 37 devueltos, 0 fallidos. Tras Sol/Terra/K2.7/K3/Muse se recalcularon percentiles de todo el set.

## Registro

Las 10 URL originales: ejemplos ya admitidos, **sin techo**. Mapa cerrado aplicado: Vals Index = `sin-tag`; Arena Longer Query = `redactar`; orquestar = AutomationBench-AA + GDPval-AA. FACTS: 4 filas (se sumó Sol 68.7%). No se copió la matriz vieja. Celdas que cambiaron tras la segunda ola: orquestador low 3.7→3.8; decide mid → K3; research mid/high → K3 W.
