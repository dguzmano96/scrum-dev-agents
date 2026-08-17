---
name: evolution-gap-analyzer
description: >-
  Compares as-is code/backlog inventory against the requested change idea,
  marks inferences, lists impact hypotheses and clarifying questions. Use in E2
  of scrum-evolution.
---

# Evolution Gap Analyzer (E2)

## Inputs

- Idea de cambio del usuario
- `as-is/codebase-map.md`
- `as-is/backlog-map.md`
- `as-is/conflicts.md`

## Método

1. Separar **HECHOS** (inventory) vs **INFERENCIAS** (marcarlas).
2. Mapa: qué existe / qué falta / qué choca con el cambio.
3. Hipótesis de impacto: Local / Módulo / Breaking / Arquitectura (preliminar; E10 confirma).
4. Generar lista de preguntas para E3–E7 (pasarla a `requirements-elicitor` / wizard).
5. Actualizar `04-sesion/evolution-*-progress.md`.

## Salida ejemplo (en progress o brief sección Cambio)

```markdown
## Gap E2
### Ya existe
### Falta / a construir
### Riesgos / conflictos
### Inferencias (por confirmar)
### Preguntas prioritarias
```

## Reglas

- No escribir EPIC/HU aún.
- Inferencias materiales → deben entrar al gate E8 como preguntas, no como Must.
