# Sources ledger

Summary snapshot: **2026-09-07**.  
`precios_consultados`: 2026-09-07  
`benchmarks_consultados`: 2026-09-07  
`vence`: 2026-10-07 (30 days).

If the policy is used after `vence`, notify and offer to refresh prices and model cards. If the user asks to continue, proceed with this ledger.

## Pricing (inventory, 50 rows)

| Date | URL / source | What was used |
|---|---|---|
| 2026-09-07 | https://cursor.com/docs/models-and-pricing | Official EN table (primary) |
| 2026-09-07 | https://cursor.com/es/docs/models-and-pricing | ES variant (cross-checked; same table) |
| 2026-09-07 | Local export `models-and-pricing-0.md` | Matches the website |
| 2026-09-07 | https://cursor.com/docs/enterprise/privacy-and-data-governance | Regional residency +10% (note, not included in `cost`) |

Consolidated inventory: price subagent transcript  
`…/agent-transcripts/544e6db8-9cf1-40e2-b721-eadc4fe663af/subagents/4a8a52c0-5308-42cb-836f-ac80a9a461ee.jsonl`

## Capabilities (Caps cards)

One card per GA model (Auto excluded) + 2 Preview cards. Prompts: benchmarks ≥ 2026-08-07; if fewer than 5 recent sources exist, the most recent sources were used and the card is marked EXPIRED.

Recurring evaluators (appear in the cards; not re-queried for the synthesis):

| Source | Typical URL |
|---|---|
| Cursor models & pricing | https://cursor.com/docs/models-and-pricing |
| Cursor Composer / CursorBench | https://cursor.com/composer · https://cursor.com/cursorbench |
| Artificial Analysis | https://artificialanalysis.ai/ |
| LMArena / Arena.ai | https://lmarena.ai/leaderboard · https://arena.ai/leaderboard |
| BenchLM | https://benchlm.ai/ |
| Vals AI | https://www.vals.ai/ |
| SWE-bench | https://www.swebench.com/ (and leaderboards cited in cards) |
| Anthropic (system cards / news) | https://www.anthropic.com/ |
| OpenAI index / developers | https://openai.com/index/ |
| Google DeepMind / Gemini model cards | https://deepmind.google/ · https://blog.google/ |
| xAI (Grok) | cited in Grok 4.5/4.6 cards |
| Moonshot / NVIDIA NIM (Kimi) | https://build.nvidia.com/moonshotai/ |
| DeepSWE | https://deepswe.datacurve.ai/ |
| Scale Labs SWE-Pro | https://labs.scale.com/leaderboard/swe_bench_pro_public |
| Steel.dev SWE-Verified | https://leaderboard.steel.dev/leaderboards/swe-bench-verified/ |

Exact URLs per score live in each JSONL Caps under  
`…/544e6db8-9cf1-40e2-b721-eadc4fe663af/subagents/`.

## What was not used to pick models

- Pool Cursor inclusion vs Other Models / API.
- Auto (the router).
- SEO blogs (cards explicitly exclude them).

## Method of this synthesis

1. `cost = (input + 2*output) / 3`
2. Role tags (3) + extras `contexto-largo` / `tool-use` + `confidence`
3. Penalize high if cards are EXPIRED or `confidence < 0.60`
4. One low / mid / high model per subagent type (they may repeat across types)
5. Orchestrator: prioritize orquestar + contexto-largo + tool-use + cost, checking Composer 2.5, Grok 4.6, Opus 5 and Fable 5.1 cards
# Ledger de fuentes

Consulta de síntesis: **2026-09-07**.  
`precios_consultados`: 2026-09-07  
`benchmarks_consultados`: 2026-09-07  
`vence`: 2026-10-07 (30 días).

Si al usar esta política la fecha de hoy es posterior a `vence`, avisar y ofrecer refrescar precios y fichas. Si el usuario pide seguir, trabajar con este ledger.

## Precios (inventario, 50 filas)

| Fecha | URL / origen | Qué se usó |
|---|---|---|
| 2026-09-07 | https://cursor.com/docs/models-and-pricing | Tabla oficial EN (prioritaria) |
| 2026-09-07 | https://cursor.com/es/docs/models-and-pricing | Variante ES (contrastada; misma tabla) |
| 2026-09-07 | Export local `models-and-pricing-0.md` | Coincide con la web |
| 2026-09-07 | https://cursor.com/docs/enterprise/privacy-and-data-governance | Residencia regional +10% (nota, no entra en `cost`) |

Inventario consolidado: transcript del subagente de precios  
`…/agent-transcripts/544e6db8-9cf1-40e2-b721-eadc4fe663af/subagents/4a8a52c0-5308-42cb-836f-ac80a9a461ee.jsonl`

## Capacidades (fichas Caps)

Una ficha por modelo GA (sin Auto) + 2 Preview. Prompts: benchmarks ≥ 2026-08-07; si no hay 5 fuentes posteriores, se usaron las más recientes y se marcaron VENCIDAS.

Evaluadores recurrentes (aparecen en las fichas; no se reconsultaron en la síntesis):

| Fuente | URL típica |
|---|---|
| Cursor models & pricing | https://cursor.com/docs/models-and-pricing |
| Cursor Composer / CursorBench | https://cursor.com/composer · https://cursor.com/cursorbench |
| Artificial Analysis | https://artificialanalysis.ai/ |
| LMArena / Arena.ai | https://lmarena.ai/leaderboard · https://arena.ai/leaderboard |
| BenchLM | https://benchlm.ai/ |
| Vals AI | https://www.vals.ai/ |
| SWE-bench | https://www.swebench.com/ (y leaderboards citados en fichas) |
| Anthropic (system cards / news) | https://www.anthropic.com/ |
| OpenAI index / developers | https://openai.com/index/ |
| Google DeepMind / Gemini model cards | https://deepmind.google/ · https://blog.google/ |
| xAI (Grok) | citados en fichas Grok 4.5/4.6 |
| Moonshot / NVIDIA NIM (Kimi) | https://build.nvidia.com/moonshotai/ |
| DeepSWE | https://deepswe.datacurve.ai/ |
| Scale Labs SWE-Pro | https://labs.scale.com/leaderboard/swe_bench_pro_public |
| Steel.dev SWE-Verified | https://leaderboard.steel.dev/leaderboards/swe-bench-verified/ |

Las URLs exactas por score viven en cada JSONL Caps bajo  
`…/544e6db8-9cf1-40e2-b721-eadc4fe663af/subagents/`.

## Qué no se usó para elegir modelo

- Pool Cursor included vs Other Models / API.
- Auto (enrutador).
- Blogs SEO (instrucción de las fichas).

## Método de esta síntesis

1. `cost = (input + 2*output) / 3`
2. Tags de roles (3) + extras `contexto-largo` / `tool-use` + `confianza`
3. Penalizar high si evals VENCIDAS o `confianza < 0.60`
4. Un modelo low / mid / high por tipo de subagente (pueden repetirse entre tipos)
5. Orquestador: priorizar orquestar + contexto-largo + tool-use + costo, verificando fichas de Composer 2.5, Grok 4.6, Opus 5 y Fable 5.1
