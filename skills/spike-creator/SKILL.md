---
name: spike-creator
description: >-
  Creates time-boxed technical spikes (SPK-*) when a story is not estimable due
  to uncertainty. Use when quality gate fails Estimable, stack evidence is weak,
  or user asks for spike / investigación técnica.
---

# Spike Creator

## Cuándo

- HU no estimable (incertidumbre técnica)
- `freshness-guard` no puede afirmar con evidencia
- Decisión de arquitectura con tradeoff abierto

## Formato `SPK-{NN}-{slug}.md` (en épica o `01-backlog/spikes/`)

| Campo | Valor |
|-------|--------|
| ID | SPK-XXX |
| Pregunta a responder | |
| Tiempo caja (máx) | ej. 4h / 1 día |
| Resultado esperado | decisión / ADR corto / descarte |
| HU/épicas desbloqueadas | |
| Out of scope del spike | |

## Reglas

- Spike ≠ entrega de feature al usuario
- Tras spike: actualizar `decisions-log.md` + re-escribir HU afectadas
- No dejar spikes eternos sin caja de tiempo
