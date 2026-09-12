---
name: solution-debate-panel
description: >-
  Runs structured multi-perspective debate on implementation candidates
  (advocate, skeptic, fit-with-as-is), then scores and ranks best + second-best.
  Use in R4–R5 of solution-research-ideator after research candidates exist.
---

# Solution Debate Panel (R4–R5)

Panel estructurado: **argumentar, rebatir, evaluar encaje**, luego ranking.

## Roles (subagentes)

| Rol | Agente | Pregunta clave |
|-----|--------|----------------|
| Advocate | `agent-debate-advocate` | ¿Por qué esta opción es la mejor? |
| Skeptic | `agent-debate-skeptic` | ¿Por qué podría ser peor / fallar? |
| Fit | `agent-debate-fit` | ¿Qué encaja más con lo que ya hay? |

## Protocolo R4

1. Congelar candidatas C1…Cn (de R3) — no añadir tech nueva a mitad de debate sin volver a R2.
2. Para cada candidata top (máx 3 en completo, 2 en express):
   - Lanzar **advocate** (puede ser paralelo por opción) con `model` = lookup `decide` (`cursor-agent-policy`) y `modo activo` en el prompt.
3. Lanzar **skeptic** con las tesis del advocate a la vista.
4. Lanzar **fit** con inventory + todas las candidatas.
5. Sintetizar en `debate-transcript.md`:
   - Tensiones no resueltas
   - Objeciones fuertes que #1 debe mitigar
   - Dónde advocate y fit discrepan (señalarlo al usuario)

## Protocolo R5 (score)

Usar fórmula de `solution-research-ideator/reference.md`.

Por candidata rellenar:

| ID | Fit | Modernidad | Riesgo | Esfuerzo | Confianza | Score |
|----|-----|------------|--------|----------|-----------|-------|

Elegir **#1** y **#2**. Si empate ±5 puntos → AskQuestion o recomendar spike.

## Reglas de síntesis (orquestador)

- No “promediar opiniones”: **priorizar evidencia** (código citado + docs oficiales).
- Si skeptic tumba #1 con riesgo crítico sin mitigación → no puede ser #1.
- Si fit rankea distinto a modernidad → explicar el tradeoff con analogía breve.
- Registrar HECHO vs INFERENCIA en el transcript.

## Salida

- `03-calidad/research/debate-transcript.md`
- Tabla ranking para el reporte R6

## Anti-patrones

- Debate teatral sin fuentes
- Ignorar al skeptic
- Elegir lo más nuevo contra fit sin justificar
- Más de un round infinito — máx 2 rondas; luego AskQuestion
