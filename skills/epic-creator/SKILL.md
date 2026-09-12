---
name: epic-creator
description: >-
  Creates outcome-driven Scrum epics (EPIC.md) in the session language with MoSCoW, IN/OUT
  scope, metrics, and child story links. Use after discovery approval when
  generating épicas, epics, or splitting themes into epics.
---

# Epic Creator

Genera `01-backlog/EP-{NN}-{slug}/EPIC.md` usando template
`scrum-idea-to-backlog/templates/EPIC.md`.

## Precondiciones

- W6 verde + W7 aprobado (salvo retomar épicas ya existentes)
- Discovery en `00-discovery/` disponible
- IDs vía `output-scaffold` / contador

## Método

1. Agrupar outcomes (no pantallas). Una épica = capability/outcome de negocio.
2. Derivar de brief + journeys Must.
3. MoSCoW a nivel épica.
4. IN/OUT claros; Won't heredados del discovery.
5. Listar HU hijas solo como placeholders hasta `user-story-creator` (o actualizar tras F5).
6. Anti-solape: si dos épicas comparten el mismo outcome → fusionar o AskQuestion.
7. Features opcionales solo si la épica tenderá a >~8 HU.

## Prohibido

- Épicas técnicas (“Crear base de datos”, “Armar API”) salvo spike explícito.
- Nombrar frameworks concretos antes de W8 (usar lenguaje de capacidad).

## Salida

- `EPIC.md` por épica
- Actualizar `01-backlog/INDEX.md` y `traceability.md` (o dejar hooks para scaffold)
