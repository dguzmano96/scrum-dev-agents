---
name: opportunity-scorer
description: >-
  Scores improvement opportunities on impact, effort, risk, and confidence;
  ranks OPP-* for user selection. Use in O8 of project-opportunity-auditor
  after dimension audits complete.
---

# Opportunity Scorer (O8)

Consolida hallazgos de O2–O7 en **OPP-* priorizadas** con score reproducible.

## Inputs

- Hallazgos de: alignment, nfr-compliance, test-gaps, quality, dependency-health
- `03-calidad/*.md` parciales de fases anteriores

## Dimensiones de scoring (cada una 1–5)

| Dimensión | 1 (bajo) | 5 (alto) |
|-----------|----------|----------|
| **Impacto** | Polish / Could | Bloquea Must / seguridad / release |
| **Urgencia** | Puede esperar | Degradación activa o ventana de release |
| **Esfuerzo** | 5 = mucho esfuerzo; **invertir** en fórmula | 1 = XS rápido |
| **Riesgo si no actúa** | Bajo | Crítico (breach, downtime, compliance) |
| **Confianza** | Inferencia | Evidencia directa en repo |

## Fórmula score (0–100)

```
raw = (Impacto×3 + Urgencia×2 + Riesgo×2 + Confianza×1) - (Esfuerzo×2)
score = clamp(round(raw / 10 × 100), 0, 100)
```

Ajuste manual ±10 solo con nota justificada en la ficha OPP.

## Severidad desde score + tipo

| Condición | Severidad |
|-----------|-----------|
| Seguridad explotable con evidencia | **Crítica** (aunque score bajo) |
| NFR Must incumplido | **Alta** mínimo |
| score ≥ 70 | Alta |
| score 40–69 | Media |
| score < 40 | Baja |

## Esfuerzo T-shirt

| T-shirt | Guía |
|---------|------|
| XS | <2h, 1 archivo |
| S | medio día |
| M | 1–3 días |
| L | sprint parcial |
| XL | épica / spike requerido |

## Método

1. Agrupar hallazgos relacionados (no duplicar OPP).
2. Asignar ID secuencial `OPP-001`… (no reusar IDs previos del proyecto).
3. Calcular score y severidad.
4. Ordenar descendente; top 10 al resumen ejecutivo.
5. Escribir fichas en `03-calidad/opportunities/OPP-*.md` (template orquestador).
6. Actualizar `opportunity-report.md` con tabla ranked.

## Reglas

- Una OPP = un outcome accionable (si es enorme → sugerir spike o split en notas).
- Inferencia → Confianza ≤ 2 y nota en ficha.
- No decidir adopción (eso es O9 AskQuestion).

## Salida ranking (en report)

| Rank | ID | Título | Score | Severidad | Esfuerzo | Agente siguiente |
|------|-----|--------|-------|-----------|----------|------------------|

Ver `reference.md` para ejemplos de desempate.
