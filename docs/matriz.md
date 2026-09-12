# Matrix of Cursor models

`precios_consultados`: 2026-09-07  
`benchmarks_consultados`: 2026-09-07  
`vence`: 2026-10-07  

## Formula

```text
cost = (input_usd_per_M + 2 * output_usd_per_M) / 3
```

Prices in USD / million tokens (Cursor docs). Pool Cursor vs API is not part of the selection.

## Tags

- `tags_roles`: exactly 3 work-role tags, best → 3rd; remapped if the card used `tool-use` or `contexto-largo` in its top-3.
- `extras`: `tool-use` and/or `contexto-largo` (from the card, not a role).
- `evals`: `OK` = there are evals ≥ 2026-08-07; `VENCIDAS` = all evals used are out of window (or no valid sources).
- `confianza` (confidence): if `confianza < 0.60` or `evals=VENCIDAS` → **not eligible for high**. Low/mid only if price is excellent and the role is simple.
- `preview=true`: the card exists but is outside low/mid/high.
- `Auto`: excluded from subagents.

## Assignment low / mid / high / cursor (this policy)

| Tipo | low | mid | high | cursor |
|---|---|---|---|---|
| orquestador | composer-2.5 | cursor-grok-4.6-xhigh | claude-fable-5.1-thinking-high | composer-2.5 |
| explore | gpt-5.4-mini-medium | gemini-3.1-pro | gpt-5.6-sol-medium | cursor-grok-4.6-xhigh |
| implement | gemini-3.7-flash-high | cursor-grok-4.6-xhigh | claude-opus-5-thinking-high | cursor-grok-4.6-xhigh |
| decide | gemini-3.8-flash-high | gemini-3.1-pro | claude-opus-5-thinking-high | cursor-grok-4.6-xhigh |
| debug | composer-2.5 | claude-sonnet-5-thinking-high | gpt-5.3-codex | cursor-grok-4.5-high |
| interpret | gpt-5.4-nano-medium | cursor-grok-4.6-xhigh | gemini-3.1-pro | cursor-grok-4.6-xhigh |
| verify | claude-4.5-haiku-thinking | claude-opus-4.8-thinking-high | claude-fable-5.1-thinking-high | cursor-grok-4.6-xhigh |
| plan | composer-2.5 | cursor-grok-4.6-xhigh | claude-opus-5-thinking-high | composer-2.5 |
| research | gpt-5.4-mini-medium | gemini-3.1-pro | gpt-5.6-sol-medium | cursor-grok-4.6-xhigh |
| review | claude-4.5-haiku-thinking | claude-sonnet-5-thinking-high | claude-opus-4.8-thinking-high | cursor-grok-4.5-high |
| write | gpt-5-mini | gemini-3.5-flash | claude-4.6-opus-high-thinking | composer-2.5 |

Mode **cursor**: only the 6 slugs from the Cursor Models pool. Fast (`*-fast`) is allowed only with an override or for interactive debug.

## Full table (50 rows)

| display | slug | in | out | cost | tags_roles | extras | conf | evals | preview | low/mid/high |
|---|---|---:|---:|---:|---|---|---:|---|---|---|
| Auto | auto | var | var | — | — | — | — | — | false | **excluido** (enrutador; no subagentes) |
| GPT-5.6 Luna | gpt-5.6-luna-medium | 0.20 | 1.20 | 0.87 | redactar, explorar, orquestar | tool-use | 0.61 | OK | false | elegible low (rol simple); no asignado |
| GPT-5.4 Nano | gpt-5.4-nano-medium | 0.20 | 1.25 | 0.90 | interpretar, explorar, redactar | contexto-largo, tool-use | 0.74 | OK | false | **low** interpret |
| GPT-5 Mini | gpt-5-mini | 0.25 | 2.00 | 1.42 | implementar, redactar, orquestar | contexto-largo | 0.72 | OK | false | **low** write |
| GPT-5.1 Codex Mini | gpt-5.1-codex-mini | 0.25 | 2.00 | 1.42 | implementar, explorar, orquestar | contexto-largo | 0.58 | OK | false | no high (conf<0.60); no asignado |
| Gemini 2.5 Flash | gemini-2.5-flash | 0.30 | 2.50 | 1.77 | redactar, explorar, interpretar | contexto-largo | 0.72 | OK | false | elegible low write/research; no asignado |
| Composer 2.5 | composer-2.5 | 0.50 | 2.50 | 1.83 | implementar, orquestar, explorar | tool-use | 0.68 | OK | false | **low** orquestador, debug, plan |
| Gemini 3 Flash | gemini-3-flash | 0.50 | 3.00 | 2.17 | implementar, explorar, orquestar | tool-use | 0.74 | VENCIDAS | false | no high; no asignado |
| Gemini 3.7 Flash | gemini-3.7-flash-high | 0.75 | 3.50 | 2.58 | implementar, orquestar, explorar | tool-use, contexto-largo | 0.82 | OK | false | **low** implement |
| Gemini 3.8 Flash | gemini-3.8-flash-high | 0.75 | 3.50 | 2.58 | implementar, decidir, orquestar | tool-use | 0.74 | OK | false | **low** decide |
| Kimi K2.7 Code | kimi-k2.7-code | 0.95 | 4.00 | 2.98 | implementar, orquestar, explorar | tool-use, contexto-largo | 0.62 | OK | false | elegible low implement; no asignado |
| GPT-5.4 Mini | gpt-5.4-mini-medium | 0.75 | 4.50 | 3.25 | explorar, implementar, redactar | contexto-largo, tool-use | 0.71 | OK | false | **low** explore, research |
| GLM 5.2 | glm-5.2-high | 1.40 | 4.40 | 3.40 | implementar, orquestar, explorar | contexto-largo, tool-use | 0.74 | OK | false | elegible mid implement; no asignado |
| Claude 4.5 Haiku | claude-4.5-haiku-thinking | 1.00 | 5.00 | 3.67 | implementar, orquestar, explorar | tool-use | 0.74 | OK | false | **low** verify, review |
| Grok 4.6 | cursor-grok-4.6-xhigh | 2.00 | 6.00 | 4.67 | interpretar, implementar, orquestar | contexto-largo, tool-use | 0.74 | OK | false | **mid** orquestador, implement, interpret, plan |
| Grok 4.5 | cursor-grok-4.5-high | 2.00 | 6.00 | 4.67 | implementar, depurar, orquestar | tool-use | 0.71 | OK | false | elegible mid debug; no asignado |
| Gemini 3.6 Flash | gemini-3.6-flash-high | 1.50 | 7.50 | 5.50 | implementar, explorar, orquestar | tool-use | 0.74 | OK | false | elegible mid implement; no asignado |
| Gemini 3.5 Flash | gemini-3.5-flash | 1.50 | 9.00 | 6.50 | implementar, orquestar, explorar | tool-use | 0.74 | OK | false | **mid** write |
| GPT-5 | gpt-5.1 | 1.25 | 10.00 | 7.08 | implementar, orquestar, explorar | tool-use, contexto-largo | 0.68 | OK | false | no asignado (superseded) |
| GPT-5-Codex | gpt-5-codex | 1.25 | 10.00 | 7.08 | implementar, depurar, orquestar | tool-use | 0.68 | VENCIDAS | false | no high; no asignado |
| GPT-5.1 Codex | gpt-5.1-codex | 1.25 | 10.00 | 7.08 | implementar, orquestar, explorar | tool-use | 0.72 | VENCIDAS | false | no high; no asignado |
| GPT-5.1 Codex Max | gpt-5.1-codex-max | 1.25 | 10.00 | 7.08 | implementar, depurar, orquestar | tool-use | 0.72 | OK | false | elegible mid debug; no asignado |
| Claude Sonnet 5 | claude-sonnet-5-thinking-high | 2.00 | 10.00 | 7.33 | implementar, depurar, orquestar | tool-use | 0.71 | OK | false | **mid** debug, review |
| Gemini 3 Pro | gemini-3-pro | 2.00 | 12.00 | 8.67 | interpretar, implementar, redactar | contexto-largo, tool-use | 0.74 | OK | false | elegible mid interpret/write; no asignado |
| Gemini 3.1 Pro | gemini-3.1-pro | 2.00 | 12.00 | 8.67 | interpretar, explorar, decidir | contexto-largo, tool-use | 0.72 | OK | false | **mid** explore, decide, research; **high** interpret |
| GPT-5.6 Terra | gpt-5.6-terra-medium | 2.00 | 12.00 | 8.67 | implementar, explorar, orquestar | contexto-largo | 0.71 | OK | false | elegible mid implement; no asignado |
| Grok 4.6 Fast | cursor-grok-4.6-xhigh-fast | 4.00 | 12.00 | 9.33 | implementar, orquestar, explorar | contexto-largo, tool-use | 0.61 | OK | false | no low (2× precio, misma calidad) |
| GPT-5.2 | gpt-5.2 | 1.75 | 14.00 | 9.92 | implementar, orquestar, explorar | contexto-largo, tool-use | 0.68 | OK | false | no asignado (superseded) |
| GPT-5.2 Codex | gpt-5.2-codex | 1.75 | 14.00 | 9.92 | implementar, depurar, orquestar | tool-use | 0.74 | OK | false | elegible mid/high debug; no asignado |
| GPT-5.3 Codex | gpt-5.3-codex | 1.75 | 14.00 | 9.92 | implementar, depurar, orquestar | tool-use | 0.74 | OK | false | **high** debug |
| GPT-5.4 | gpt-5.4-medium | 2.50 | 15.00 | 10.83 | orquestar, explorar, implementar | tool-use | 0.72 | OK | false | elegible mid orquestar; no asignado |
| Composer 2.5 Fast | composer-2.5-fast | 3.00 | 15.00 | 11.00 | implementar, depurar, orquestar | tool-use | 0.74 | OK | false | no low (6× vs standard) |
| Claude 4 Sonnet | claude-4-sonnet | 3.00 | 15.00 | 11.00 | implementar, depurar, orquestar | tool-use | 0.52 | VENCIDAS | false | no high; no asignado |
| Claude 4.5 Sonnet | claude-4.5-sonnet-thinking | 3.00 | 15.00 | 11.00 | implementar, orquestar, explorar | tool-use | 0.68 | OK | false | no asignado (legacy vs 4.6/5) |
| Claude 4.6 Sonnet | claude-4.6-sonnet-medium-thinking | 3.00 | 15.00 | 11.00 | implementar, orquestar, explorar | tool-use | 0.71 | OK | false | elegible mid implement; no asignado |
| Kimi K3 | kimi-k3-max | 3.00 | 15.00 | 11.00 | implementar, orquestar, explorar | tool-use, contexto-largo | 0.74 | OK | false | elegible mid/high implement; no asignado |
| Grok 4.5 Fast | cursor-grok-4.5-high-fast | 4.00 | 18.00 | 13.33 | orquestar, depurar, implementar | contexto-largo, tool-use | 0.58 | OK | false | no high (conf<0.60); no low (Fast) |
| GPT-5 Fast | gpt-5-high-fast | 2.50 | 20.00 | 14.17 | implementar, orquestar, explorar | tool-use | 0.62 | OK | false | no low (2× vs gpt-5.1) |
| GPT-5.6 Sol | gpt-5.6-sol-medium | 4.00 | 20.00 | 14.67 | implementar, orquestar, explorar | contexto-largo, tool-use | 0.68 | OK | false | **high** explore, research (promo → 2026-11-21) |
| Claude 4 Sonnet 1M | claude-4-sonnet-1m | 6.00 | 22.50 | 17.00 | explorar, implementar, depurar | contexto-largo | 0.58 | VENCIDAS | false | no high; no asignado |
| Claude 4.5 Opus | claude-4.5-opus-high-thinking | 5.00 | 25.00 | 18.33 | implementar, orquestar, depurar | contexto-largo, tool-use | 0.71 | OK | false | no asignado (superseded) |
| Claude 4.6 Opus | claude-4.6-opus-high-thinking | 5.00 | 25.00 | 18.33 | orquestar, implementar, explorar | contexto-largo | 0.72 | OK | false | **high** write |
| Claude 4.7 Opus | claude-4.7-opus | 5.00 | 25.00 | 18.33 | implementar, orquestar, explorar | tool-use | 0.74 | VENCIDAS | false | no high; no asignado |
| Claude Opus 4.8 | claude-opus-4.8-thinking-high | 5.00 | 25.00 | 18.33 | implementar, orquestar, verificar | contexto-largo, tool-use | 0.72 | OK | false | **mid** verify; **high** review |
| Claude Opus 5 | claude-opus-5-thinking-high | 5.00 | 25.00 | 18.33 | implementar, orquestar, explorar | tool-use | 0.82 | OK | false | **high** implement, decide, plan |
| GPT-5.5 | gpt-5.5-medium | 5.00 | 30.00 | 21.67 | orquestar, explorar, implementar | tool-use, contexto-largo | 0.72 | OK | false | elegible high orquestar; no asignado (superseded por 5.6 / Fable) |
| Claude Fable 5 | claude-fable-5-thinking-high | 10.00 | 50.00 | 36.67 | orquestar, implementar, explorar | contexto-largo | 0.74 | OK | false | no low ($10/$50); no asignado (5.1 lo supera) |
| Claude Fable 5.1 | claude-fable-5.1-thinking-high | 10.00 | 50.00 | 36.67 | orquestar, implementar, explorar | tool-use | 0.81 | OK | false | **high** orquestador, verify |
| Claude Opus 4.7 (fast) | claude-opus-4.7-thinking-xhigh | 30.00 | 150.00 | 110.00 | implementar, depurar, orquestar | tool-use | 0.58 | OK | **true** | **fuera de matriz** |
| Gemini 3 Pro Image Preview | gemini-3-pro-image-preview | 2.00 | 12.00 | 8.67 | interpretar, explorar, depurar | — (imagen; sin FC/código) | 0.74 | OK | **true** | **fuera de matriz** |

`in`/`out` = USD / M tokens according to the 2026-09-07 inventory. Fast has its own row. Thinking groups by family (the user's picker fixes effort).

## Remapping tags (cards → work roles)

Cards sometimes put `tool-use` or `contexto-largo` in their top-3. Policy: 3 role tags; extras separate.

| slug | raw card tags | tags_roles (policy) | extras |
|---|---|---|---|
| composer-2.5 | implementar, tool-use, orquestar | implementar, orquestar, explorar | tool-use |
| composer-2.5-fast | implementar, tool-use, depurar | implementar, depurar, orquestar | tool-use |
| claude-4-sonnet | implementar, depurar, tool-use | implementar, depurar, orquestar | tool-use |
| claude-4-sonnet-1m | explorar, contexto-largo, implementar | explorar, implementar, depurar | contexto-largo |
| claude-4.5-haiku-thinking | implementar, tool-use, orquestar | implementar, orquestar, explorar | tool-use |
| claude-4.5-sonnet-thinking | implementar, tool-use, orquestar | implementar, orquestar, explorar | tool-use |
| claude-4.6-opus-high-thinking | orquestar, implementar, contexto-largo | orquestar, implementar, explorar | contexto-largo |
| claude-4.6-sonnet-medium-thinking | implementar, tool-use, orquestar | implementar, orquestar, explorar | tool-use |
| claude-4.7-opus | implementar, tool-use, orquestar | implementar, orquestar, explorar | tool-use |
| claude-fable-5-thinking-high | orquestar, implementar, contexto-largo | orquestar, implementar, explorar | contexto-largo |
| claude-fable-5.1-thinking-high | orquestar, implementar, tool-use | orquestar, implementar, explorar | tool-use |
| claude-opus-4.7-thinking-xhigh | implementar, tool-use, depurar | implementar, depurar, orquestar | tool-use |
| claude-opus-5-thinking-high | implementar, orquestar, tool-use | implementar, orquestar, explorar | tool-use |
| claude-sonnet-5-thinking-high | implementar, tool-use, depurar | implementar, depurar, orquestar | tool-use |
| cursor-grok-4.5-high | implementar, tool-use, depurar | implementar, depurar, orquestar | tool-use |
| gemini-3-flash | implementar, explorar, tool-use | implementar, explorar, orquestar | tool-use |
| gemini-3.5-flash | implementar, tool-use, orquestar | implementar, orquestar, explorar | tool-use |
| gemini-3.6-flash-high | implementar, tool-use, explorar | implementar, explorar, orquestar | tool-use |
| gemini-3.7-flash-high | implementar, tool-use, contexto-largo | implementar, orquestar, explorar | tool-use, contexto-largo |
| gemini-3.8-flash-high | implementar, tool-use, decidir | implementar, decidir, orquestar | tool-use |
| glm-5.2-high | implementar, contexto-largo, tool-use | implementar, orquestar, explorar | contexto-largo, tool-use |
| gpt-5-codex | implementar, depurar, tool-use | implementar, depurar, orquestar | tool-use |
| gpt-5-high-fast | implementar, tool-use, orquestar | implementar, orquestar, explorar | tool-use |
| gpt-5-mini | implementar, redactar, contexto-largo | implementar, redactar, orquestar | contexto-largo |
| gpt-5.1 | implementar, tool-use, contexto-largo | implementar, orquestar, explorar | tool-use, contexto-largo |
| gpt-5.1-codex | implementar, orquestar, tool-use | implementar, orquestar, explorar | tool-use |
| gpt-5.1-codex-max | implementar, depurar, tool-use | implementar, depurar, orquestar | tool-use |
| gpt-5.1-codex-mini | implementar, explorar, contexto-largo | implementar, explorar, orquestar | contexto-largo |
| gpt-5.2 | contexto-largo, implementar, tool-use | implementar, orquestar, explorar | contexto-largo, tool-use |
| gpt-5.2-codex | implementar, depurar, tool-use | implementar, depurar, orquestar | tool-use |
| gpt-5.3-codex | tool-use, implementar, depurar | implementar, depurar, orquestar | tool-use |
| gpt-5.4-medium | orquestar, tool-use, explorar | orquestar, explorar, implementar | tool-use |
| gpt-5.5-medium | tool-use, orquestar, contexto-largo | orquestar, explorar, implementar | tool-use, contexto-largo |
| gpt-5.6-luna-medium | tool-use, redactar, explorar | redactar, explorar, orquestar | tool-use |
| gpt-5.6-terra-medium | implementar, contexto-largo, explorar | implementar, explorar, orquestar | contexto-largo |
| kimi-k2.7-code | tool-use, implementar, contexto-largo | implementar, orquestar, explorar | tool-use, contexto-largo |
| kimi-k3-max | implementar, tool-use, contexto-largo | implementar, orquestar, explorar | tool-use, contexto-largo |

The remapped 3rd role is taken from the card's role table (the next strongest work role that is not an extra).
# Matriz de modelos Cursor

`precios_consultados`: 2026-09-07  
`benchmarks_consultados`: 2026-09-07  
`vence`: 2026-10-07  

## Fórmula

```text
cost = (input_usd_per_M + 2 * output_usd_per_M) / 3
```

Precios en USD / millón de tokens (docs Cursor). Pool Cursor vs API **no** entra en la selección.

## Tags

- `tags_roles`: exactamente 3 roles de trabajo, mejor → 3.º, **remapeados** si la ficha usó `tool-use` o `contexto-largo` en el top-3.
- `extras`: `tool-use` y/o `contexto-largo` (de la ficha, no como rol de matriz).
- `evals`: `OK` = hay evals ≥ 2026-08-07; `VENCIDAS` = todas las evals usadas están fuera de ventana (o cero fuentes válidas).
- `confianza < 0.60` o `evals=VENCIDAS` → **no high**. Low/mid solo si precio excelente y rol simple.
- `preview=true`: ficha sí, **fuera** de low/mid/high.
- `Auto`: fuera de subagentes.

## Asignación low / mid / high / cursor (esta política)

| Tipo | low | mid | high | cursor |
|---|---|---|---|---|
| orquestador | composer-2.5 | cursor-grok-4.6-xhigh | claude-fable-5.1-thinking-high | composer-2.5 |
| explore | gpt-5.4-mini-medium | gemini-3.1-pro | gpt-5.6-sol-medium | cursor-grok-4.6-xhigh |
| implement | gemini-3.7-flash-high | cursor-grok-4.6-xhigh | claude-opus-5-thinking-high | cursor-grok-4.6-xhigh |
| decide | gemini-3.8-flash-high | gemini-3.1-pro | claude-opus-5-thinking-high | cursor-grok-4.6-xhigh |
| debug | composer-2.5 | claude-sonnet-5-thinking-high | gpt-5.3-codex | cursor-grok-4.5-high |
| interpret | gpt-5.4-nano-medium | cursor-grok-4.6-xhigh | gemini-3.1-pro | cursor-grok-4.6-xhigh |
| verify | claude-4.5-haiku-thinking | claude-opus-4.8-thinking-high | claude-fable-5.1-thinking-high | cursor-grok-4.6-xhigh |
| plan | composer-2.5 | cursor-grok-4.6-xhigh | claude-opus-5-thinking-high | composer-2.5 |
| research | gpt-5.4-mini-medium | gemini-3.1-pro | gpt-5.6-sol-medium | cursor-grok-4.6-xhigh |
| review | claude-4.5-haiku-thinking | claude-sonnet-5-thinking-high | claude-opus-4.8-thinking-high | cursor-grok-4.5-high |
| write | gpt-5-mini | gemini-3.5-flash | claude-4.6-opus-high-thinking | composer-2.5 |

Modo **cursor**: solo los 6 slugs del pool Cursor Models. Fast (`*-fast`) solo con override o debug interactivo.

## Tabla completa (50 filas)

| display | slug | in | out | cost | tags_roles | extras | conf | evals | preview | low/mid/high |
|---|---|---:|---:|---:|---|---|---:|---|---|---|
| Auto | auto | var | var | — | — | — | — | — | false | **excluido** (enrutador; no subagentes) |
| GPT-5.6 Luna | gpt-5.6-luna-medium | 0.20 | 1.20 | 0.87 | redactar, explorar, orquestar | tool-use | 0.61 | OK | false | elegible low (rol simple); no asignado |
| GPT-5.4 Nano | gpt-5.4-nano-medium | 0.20 | 1.25 | 0.90 | interpretar, explorar, redactar | contexto-largo, tool-use | 0.74 | OK | false | **low** interpret |
| GPT-5 Mini | gpt-5-mini | 0.25 | 2.00 | 1.42 | implementar, redactar, orquestar | contexto-largo | 0.72 | OK | false | **low** write |
| GPT-5.1 Codex Mini | gpt-5.1-codex-mini | 0.25 | 2.00 | 1.42 | implementar, explorar, orquestar | contexto-largo | 0.58 | OK | false | no high (conf&lt;0.60); no asignado |
| Gemini 2.5 Flash | gemini-2.5-flash | 0.30 | 2.50 | 1.77 | redactar, explorar, interpretar | contexto-largo | 0.72 | OK | false | elegible low write/research; no asignado |
| Composer 2.5 | composer-2.5 | 0.50 | 2.50 | 1.83 | implementar, orquestar, explorar | tool-use | 0.68 | OK | false | **low** orquestador, debug, plan |
| Gemini 3 Flash | gemini-3-flash | 0.50 | 3.00 | 2.17 | implementar, explorar, orquestar | tool-use | 0.74 | VENCIDAS | false | no high; no asignado |
| Gemini 3.7 Flash | gemini-3.7-flash-high | 0.75 | 3.50 | 2.58 | implementar, orquestar, explorar | tool-use, contexto-largo | 0.82 | OK | false | **low** implement |
| Gemini 3.8 Flash | gemini-3.8-flash-high | 0.75 | 3.50 | 2.58 | implementar, decidir, orquestar | tool-use | 0.74 | OK | false | **low** decide |
| Kimi K2.7 Code | kimi-k2.7-code | 0.95 | 4.00 | 2.98 | implementar, orquestar, explorar | tool-use, contexto-largo | 0.62 | OK | false | elegible low implement; no asignado |
| GPT-5.4 Mini | gpt-5.4-mini-medium | 0.75 | 4.50 | 3.25 | explorar, implementar, redactar | contexto-largo, tool-use | 0.71 | OK | false | **low** explore, research |
| GLM 5.2 | glm-5.2-high | 1.40 | 4.40 | 3.40 | implementar, orquestar, explorar | contexto-largo, tool-use | 0.74 | OK | false | elegible mid implement; no asignado |
| Claude 4.5 Haiku | claude-4.5-haiku-thinking | 1.00 | 5.00 | 3.67 | implementar, orquestar, explorar | tool-use | 0.74 | OK | false | **low** verify, review |
| Grok 4.6 | cursor-grok-4.6-xhigh | 2.00 | 6.00 | 4.67 | interpretar, implementar, orquestar | contexto-largo, tool-use | 0.74 | OK | false | **mid** orquestador, implement, interpret, plan |
| Grok 4.5 | cursor-grok-4.5-high | 2.00 | 6.00 | 4.67 | implementar, depurar, orquestar | tool-use | 0.71 | OK | false | elegible mid debug; no asignado |
| Gemini 3.6 Flash | gemini-3.6-flash-high | 1.50 | 7.50 | 5.50 | implementar, explorar, orquestar | tool-use | 0.74 | OK | false | elegible mid implement; no asignado |
| Gemini 3.5 Flash | gemini-3.5-flash | 1.50 | 9.00 | 6.50 | implementar, orquestar, explorar | tool-use | 0.74 | OK | false | **mid** write |
| GPT-5 | gpt-5.1 | 1.25 | 10.00 | 7.08 | implementar, orquestar, explorar | tool-use, contexto-largo | 0.68 | OK | false | no asignado (superseded) |
| GPT-5-Codex | gpt-5-codex | 1.25 | 10.00 | 7.08 | implementar, depurar, orquestar | tool-use | 0.68 | VENCIDAS | false | no high; no asignado |
| GPT-5.1 Codex | gpt-5.1-codex | 1.25 | 10.00 | 7.08 | implementar, orquestar, explorar | tool-use | 0.72 | VENCIDAS | false | no high; no asignado |
| GPT-5.1 Codex Max | gpt-5.1-codex-max | 1.25 | 10.00 | 7.08 | implementar, depurar, orquestar | tool-use | 0.72 | OK | false | elegible mid debug; no asignado |
| Claude Sonnet 5 | claude-sonnet-5-thinking-high | 2.00 | 10.00 | 7.33 | implementar, depurar, orquestar | tool-use | 0.71 | OK | false | **mid** debug, review |
| Gemini 3 Pro | gemini-3-pro | 2.00 | 12.00 | 8.67 | interpretar, implementar, redactar | contexto-largo, tool-use | 0.74 | OK | false | elegible mid interpret/write; no asignado |
| Gemini 3.1 Pro | gemini-3.1-pro | 2.00 | 12.00 | 8.67 | interpretar, explorar, decidir | contexto-largo, tool-use | 0.72 | OK | false | **mid** explore, decide, research; **high** interpret |
| GPT-5.6 Terra | gpt-5.6-terra-medium | 2.00 | 12.00 | 8.67 | implementar, explorar, orquestar | contexto-largo | 0.71 | OK | false | elegible mid implement; no asignado |
| Grok 4.6 Fast | cursor-grok-4.6-xhigh-fast | 4.00 | 12.00 | 9.33 | implementar, orquestar, explorar | contexto-largo, tool-use | 0.61 | OK | false | no low (2× precio, misma calidad) |
| GPT-5.2 | gpt-5.2 | 1.75 | 14.00 | 9.92 | implementar, orquestar, explorar | contexto-largo, tool-use | 0.68 | OK | false | no asignado (superseded) |
| GPT-5.2 Codex | gpt-5.2-codex | 1.75 | 14.00 | 9.92 | implementar, depurar, orquestar | tool-use | 0.74 | OK | false | elegible mid/high debug; no asignado |
| GPT-5.3 Codex | gpt-5.3-codex | 1.75 | 14.00 | 9.92 | implementar, depurar, orquestar | tool-use | 0.74 | OK | false | **high** debug |
| GPT-5.4 | gpt-5.4-medium | 2.50 | 15.00 | 10.83 | orquestar, explorar, implementar | tool-use | 0.72 | OK | false | elegible mid orquestar; no asignado |
| Composer 2.5 Fast | composer-2.5-fast | 3.00 | 15.00 | 11.00 | implementar, depurar, orquestar | tool-use | 0.74 | OK | false | no low (6× vs standard) |
| Claude 4 Sonnet | claude-4-sonnet | 3.00 | 15.00 | 11.00 | implementar, depurar, orquestar | tool-use | 0.52 | VENCIDAS | false | no high; no asignado |
| Claude 4.5 Sonnet | claude-4.5-sonnet-thinking | 3.00 | 15.00 | 11.00 | implementar, orquestar, explorar | tool-use | 0.68 | OK | false | no asignado (legacy vs 4.6/5) |
| Claude 4.6 Sonnet | claude-4.6-sonnet-medium-thinking | 3.00 | 15.00 | 11.00 | implementar, orquestar, explorar | tool-use | 0.71 | OK | false | elegible mid implement; no asignado |
| Kimi K3 | kimi-k3-max | 3.00 | 15.00 | 11.00 | implementar, orquestar, explorar | tool-use, contexto-largo | 0.74 | OK | false | elegible mid/high implement; no asignado |
| Grok 4.5 Fast | cursor-grok-4.5-high-fast | 4.00 | 18.00 | 13.33 | orquestar, depurar, implementar | contexto-largo, tool-use | 0.58 | OK | false | no high (conf&lt;0.60); no low (Fast) |
| GPT-5 Fast | gpt-5-high-fast | 2.50 | 20.00 | 14.17 | implementar, orquestar, explorar | tool-use | 0.62 | OK | false | no low (2× vs gpt-5.1) |
| GPT-5.6 Sol | gpt-5.6-sol-medium | 4.00 | 20.00 | 14.67 | implementar, orquestar, explorar | contexto-largo, tool-use | 0.68 | OK | false | **high** explore, research (promo → 2026-11-21) |
| Claude 4 Sonnet 1M | claude-4-sonnet-1m | 6.00 | 22.50 | 17.00 | explorar, implementar, depurar | contexto-largo | 0.58 | VENCIDAS | false | no high; no asignado |
| Claude 4.5 Opus | claude-4.5-opus-high-thinking | 5.00 | 25.00 | 18.33 | implementar, orquestar, depurar | contexto-largo, tool-use | 0.71 | OK | false | no asignado (superseded) |
| Claude 4.6 Opus | claude-4.6-opus-high-thinking | 5.00 | 25.00 | 18.33 | orquestar, implementar, explorar | contexto-largo | 0.72 | OK | false | **high** write |
| Claude 4.7 Opus | claude-4.7-opus | 5.00 | 25.00 | 18.33 | implementar, orquestar, explorar | tool-use | 0.74 | VENCIDAS | false | no high; no asignado |
| Claude Opus 4.8 | claude-opus-4.8-thinking-high | 5.00 | 25.00 | 18.33 | implementar, orquestar, verificar | contexto-largo, tool-use | 0.72 | OK | false | **mid** verify; **high** review |
| Claude Opus 5 | claude-opus-5-thinking-high | 5.00 | 25.00 | 18.33 | implementar, orquestar, explorar | tool-use | 0.82 | OK | false | **high** implement, decide, plan |
| GPT-5.5 | gpt-5.5-medium | 5.00 | 30.00 | 21.67 | orquestar, explorar, implementar | tool-use, contexto-largo | 0.72 | OK | false | elegible high orquestar; no asignado (superseded por 5.6 / Fable) |
| Claude Fable 5 | claude-fable-5-thinking-high | 10.00 | 50.00 | 36.67 | orquestar, implementar, explorar | contexto-largo | 0.74 | OK | false | no low ($10/$50); no asignado (5.1 lo supera) |
| Claude Fable 5.1 | claude-fable-5.1-thinking-high | 10.00 | 50.00 | 36.67 | orquestar, implementar, explorar | tool-use | 0.81 | OK | false | **high** orquestador, verify |
| Claude Opus 4.7 (fast) | claude-opus-4.7-thinking-xhigh | 30.00 | 150.00 | 110.00 | implementar, depurar, orquestar | tool-use | 0.58 | OK | **true** | **fuera de matriz** |
| Gemini 3 Pro Image Preview | gemini-3-pro-image-preview | 2.00 | 12.00 | 8.67 | interpretar, explorar, depurar | — (imagen; sin FC/código) | 0.74 | OK | **true** | **fuera de matriz** |

`in`/`out` = USD / M tokens según inventario 2026-09-07. Fast es fila propia. Thinking se agrupa por familia (el picker del usuario fija el esfuerzo).

## Remapeo de tags (fichas → roles de trabajo)

Las fichas a veces pusieron `tool-use` o `contexto-largo` en el top-3. Política: 3 tags de **roles**; extras aparte.

| slug | tags ficha (raw) | tags_roles (política) | extras |
|---|---|---|---|
| composer-2.5 | implementar, tool-use, orquestar | implementar, orquestar, explorar | tool-use |
| composer-2.5-fast | implementar, tool-use, depurar | implementar, depurar, orquestar | tool-use |
| claude-4-sonnet | implementar, depurar, tool-use | implementar, depurar, orquestar | tool-use |
| claude-4-sonnet-1m | explorar, contexto-largo, implementar | explorar, implementar, depurar | contexto-largo |
| claude-4.5-haiku-thinking | implementar, tool-use, orquestar | implementar, orquestar, explorar | tool-use |
| claude-4.5-sonnet-thinking | implementar, tool-use, orquestar | implementar, orquestar, explorar | tool-use |
| claude-4.6-opus-high-thinking | orquestar, implementar, contexto-largo | orquestar, implementar, explorar | contexto-largo |
| claude-4.6-sonnet-medium-thinking | implementar, tool-use, orquestar | implementar, orquestar, explorar | tool-use |
| claude-4.7-opus | implementar, tool-use, orquestar | implementar, orquestar, explorar | tool-use |
| claude-fable-5-thinking-high | orquestar, implementar, contexto-largo | orquestar, implementar, explorar | contexto-largo |
| claude-fable-5.1-thinking-high | orquestar, implementar, tool-use | orquestar, implementar, explorar | tool-use |
| claude-opus-4.7-thinking-xhigh | implementar, tool-use, depurar | implementar, depurar, orquestar | tool-use |
| claude-opus-5-thinking-high | implementar, orquestar, tool-use | implementar, orquestar, explorar | tool-use |
| claude-sonnet-5-thinking-high | implementar, tool-use, depurar | implementar, depurar, orquestar | tool-use |
| cursor-grok-4.5-high | implementar, tool-use, depurar | implementar, depurar, orquestar | tool-use |
| gemini-3-flash | implementar, explorar, tool-use | implementar, explorar, orquestar | tool-use |
| gemini-3.5-flash | implementar, tool-use, orquestar | implementar, orquestar, explorar | tool-use |
| gemini-3.6-flash-high | implementar, tool-use, explorar | implementar, explorar, orquestar | tool-use |
| gemini-3.7-flash-high | implementar, tool-use, contexto-largo | implementar, orquestar, explorar | tool-use, contexto-largo |
| gemini-3.8-flash-high | implementar, tool-use, decidir | implementar, decidir, orquestar | tool-use |
| glm-5.2-high | implementar, contexto-largo, tool-use | implementar, orquestar, explorar | contexto-largo, tool-use |
| gpt-5-codex | implementar, depurar, tool-use | implementar, depurar, orquestar | tool-use |
| gpt-5-high-fast | implementar, tool-use, orquestar | implementar, orquestar, explorar | tool-use |
| gpt-5-mini | implementar, redactar, contexto-largo | implementar, redactar, orquestar | contexto-largo |
| gpt-5.1 | implementar, tool-use, contexto-largo | implementar, orquestar, explorar | tool-use, contexto-largo |
| gpt-5.1-codex | implementar, orquestar, tool-use | implementar, orquestar, explorar | tool-use |
| gpt-5.1-codex-max | implementar, depurar, tool-use | implementar, depurar, orquestar | tool-use |
| gpt-5.1-codex-mini | implementar, explorar, contexto-largo | implementar, explorar, orquestar | contexto-largo |
| gpt-5.2 | contexto-largo, implementar, tool-use | implementar, orquestar, explorar | contexto-largo, tool-use |
| gpt-5.2-codex | implementar, depurar, tool-use | implementar, depurar, orquestar | tool-use |
| gpt-5.3-codex | tool-use, implementar, depurar | implementar, depurar, orquestar | tool-use |
| gpt-5.4-medium | orquestar, tool-use, explorar | orquestar, explorar, implementar | tool-use |
| gpt-5.5-medium | tool-use, orquestar, contexto-largo | orquestar, explorar, implementar | tool-use, contexto-largo |
| gpt-5.6-luna-medium | tool-use, redactar, explorar | redactar, explorar, orquestar | tool-use |
| gpt-5.6-terra-medium | implementar, contexto-largo, explorar | implementar, explorar, orquestar | contexto-largo |
| kimi-k2.7-code | tool-use, implementar, contexto-largo | implementar, orquestar, explorar | tool-use, contexto-largo |
| kimi-k3-max | implementar, tool-use, contexto-largo | implementar, orquestar, explorar | tool-use, contexto-largo |

El 3.er rol remapeado sale de la tabla de roles de la ficha (siguiente trabajo más fuerte que no sea extra).
