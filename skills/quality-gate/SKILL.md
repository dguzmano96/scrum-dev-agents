---
name: quality-gate
description: >-
  Scores user stories on an 8-dimension rubric (max 24 → /10), blocks ready
  below threshold, and suggests concrete fixes or story-splitter. Use before
  marking HU ready, during F6, or when evaluating story quality.
---

# Quality Gate

Usar rúbrica en `scrum-idea-to-backlog/templates/quality-rubric.md`.

## Umbrales

- **≥9.0** ready
- **7.0–8.9** refine (sugerir fixes concretos)
- **<7.0** rework / invocar `story-splitter`

## Método

1. Evaluar cada HU 8 dimensiones (1–3).
2. Calcular nota = (suma / 24) × 10.
3. Anotar en `03-calidad/evaluation-report.md`.
4. Si tamaño bajo → `story-splitter`.
5. Si no estimable por duda técnica → `spike-creator`.
6. Bloquear “ready” en INDEX si < 9.0 (o política de equipo: <7.0 hard block).

## evaluation-report.md

| HU | D1…D8 | Total | Nota/10 | Estado | Acciones |
|----|-------|-------|---------|--------|----------|

Default hard block entrega final: ninguna HU Must con nota < 7.0.
