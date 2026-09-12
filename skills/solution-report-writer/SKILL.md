---
name: solution-report-writer
description: >-
  Writes the final argued solution research report (best option, why, how to
  implement, second-best, tradeoffs, analogies). Use in R6 of
  solution-research-ideator after debate and scoring.
---

# Solution Report Writer (R6)

Escribe el **reporte final** del Investigador/Ideador. Solo documentación.

## Entradas

- Pedido R0 + constraints
- Inventory R1
- Candidatas R3 + fuentes R2
- Transcript + scores R4/R5

## Método

1. Leer template `templates/solution-report.md`.
2. Write in the **session language** (skill `session-language`), clear and argued (not empty telegraphic).
3. Incluir:
   - Resumen ejecutivo (qué pedirías si solo lees 30s)
   - Opción **#1**: por qué gana, cómo implementar (pasos), mitigaciones al skeptic
   - Opción **#2**: cuándo preferirla
   - Tabla comparativa
   - Analogía o ejemplo si el tradeoff es abstracto
   - Fuentes (ledger)
   - Handoff sugerido
4. Escribir `03-calidad/research/solution-report-{slug}.md`.
5. Actualizar `research-progress.md` (R6 done).

## Calidad narrativa

- Cada afirmación fuerte → evidencia (path o URL).
- Evitar jerga sin explicación; una analogía máximo por sección clave.
- No copy-paste del debate: **síntesis decisoria**.

## Prohibido

- Snippets que “arreglen” el repo aplicándolos (el reporte puede mostrar ejemplos ilustrativos).
- Prometer que #1 es la única verdad absoluta.
- Omitir #2 sin justificación de monopolio.
