---
name: backlog-as-is-mapper
description: >-
  Indexes existing Scrum backlog (epics/HU/states) for evolution sessions, or
  prompts options when no backlog exists. Use in E1 of scrum-evolution.
---

# Backlog As-Is Mapper (E1)

## Método

1. Buscar `{proyecto}/01-backlog/` (o AskQuestion path).
2. Si existe:
   - Listar EP-*/EPIC.md y HU/*.md
   - Estados desde INDEX.md / traceability si hay
   - Escribir `00-discovery/as-is/backlog-map.md`
3. Si **no** existe:
   - Marcar "sin backlog Scrum" en backlog-map
   - AskQuestion:
     1. Generar backlog as-is mínimo (`as-is-backlog-bootstrap`)
     2. Continuar solo con delta (menos trazabilidad)
     3. Abortar

## Reglas

- No modificar EP/HU en esta skill (solo mapear).
- Señalar HU que parecen ya implementadas vs abiertas si hay evidencia en INDEX o notas.

## Salida

backlog-map.md + decisión usuario si no había backlog.
