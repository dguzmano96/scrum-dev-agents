---
name: delta-backlog-writer
description: >-
  Writes Scrum backlog deltas for evolution: new/superseding epics and HUs,
  changelog-backlog.md, prefer supersede over silent rewrite. Use in E11 of
  scrum-evolution after impact gate.
---

# Delta Backlog Writer (E11)

## Precondiciones

- E8 verde + E9 aprobado
- E10 resuelto (decisiones registradas)
- Inventory disponible

## Método

1. Decidir: épica nueva vs extender épica existente (AskQuestion si ambiguo).
2. Invocar `epic-creator` en modo delta (outcomes del **cambio**).
3. Invocar `user-story-creator` para HU nuevas.
4. Política:
   - Preferir **HU nueva** que supersede antigua (link IDs).
   - Modificar HU existente solo con AskQuestion + "Historial de cambios".
   - AC implementados no se borran en silencio → deprecated/replaced.
5. Escribir/actualizar `01-backlog/changelog-backlog.md`.
6. Actualizar INDEX.md / traceability.md / dependencias.md (vía `output-scaffold` si hace falta).
7. Invocar `backlog-consistency-auditor`.
8. Invocar `quality-gate`; si falla tamaño → `story-splitter`.
9. Invocar `flow-diagram-generator` para épicas tocadas.
10. Anotar orden sugerido de implementación para `hu-implementer`.

## Prohibido

- Regenerar todo el backlog.
- Reusar ID con otro significado.
- Implementar código.
- Must que contradigan decisiones E10.

## Templates

EPIC/HU: `scrum-idea-to-backlog/templates/`.  
Changelog: `scrum-evolution/templates/changelog-backlog.md`.
