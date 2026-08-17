---
name: as-is-backlog-bootstrap
description: >-
  Optional stub: when no Scrum backlog exists, generates coarse as-is epics/HUs
  that document existing behavior (not a rebuild). Use after backlog-as-is-mapper
  option 1 in scrum-evolution.
---

# As-Is Backlog Bootstrap (stub opcional)

## Cuándo

Usuario eligió "Generar backlog as-is mínimo" porque no hay `01-backlog/`.

## Objetivo

Documentar lo **ya existente** con EP/HU de **alta granularidad** (descriptivas), para trazabilidad. **No** pedir rebuild del sistema.

## Método

1. Partir de `codebase-map.md` (features/flujos completos o parciales).
2. Crear 1–N épicas as-is: outcome = "Documentar/sostener capacidad existente X".
3. HU as-is tipo: "Como [rol], quiero que el sistema mantenga [comportamiento observado], para [valor ya entregado]".
4. AC = comportamiento observado (hechos), no deseos nuevos.
5. Marcar MoSCoW: muchas serán Must de documentación; el **cambio** va en delta aparte después.
6. Usar `epic-creator` + `user-story-creator` + `output-scaffold`.
7. En INDEX marcar origen: `as-is-bootstrap`.
8. Luego volver al pipeline de evolución para el **delta del cambio**.

## Reglas

- AskQuestion si un flujo está incompleto: ¿documentar parcial o excluir?
- No colar requisitos del cambio nuevo dentro de HU as-is.
- Quality gate puede ser más laxo en as-is (documentar); delta del cambio sí exige umbral normal.

## Stub note

Esta skill es el bootstrap mínimo. Si el usuario pide as-is exhaustivo, ampliar con más pases de inventory + AskQuestion; no inventar comportamiento no visto en código.
