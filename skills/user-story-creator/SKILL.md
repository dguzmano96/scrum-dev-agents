---
name: user-story-creator
description: >-
  Writes INVEST user stories in Spanish with declarative AC and separate BDD
  Gherkin scenarios, MoSCoW, and epic traceability. Use when generating historias
  de usuario, HU, user stories, acceptance criteria, or Gherkin for an epic.
---

# User Story Creator

Genera `HU/HU-{NN}-{slug}.md` con template `scrum-idea-to-backlog/templates/HU.md`.

## Precondiciones

- Épica padre existe
- Sin supuestos BLOQUEANTES abiertos que afecten la HU
- Preferible stack ya elegido si la HU menciona integraciones tech (si no, lenguaje de capacidad)

## Formato historia

Como **[rol]**, quiero **[objetivo]**, para **[beneficio]**.

## AC vs BDD

- **AC:** checklist numerado, declarativo, medible. SIN Given/When/Then.
- **BDD:** exactamente 4 tipos cuando sea posible: happy, validación, edge, fallo.

## INVEST

Marcar checklist. Si falla S (size) o E (estimable) → `story-splitter` o `spike-creator`.

## Vertical slice

Cada HU entrega valor punta a punta. Prohibido partir por capas DB→API→UI.

## Prohibido

- Pseudocódigo de implementación
- UI pixel-perfect salvo pedido explícito
- Vaguedades sin umbral (“rápido”, “amigable”, “seguro”)
- Mezclar AC con Gherkin

## Tras crear

Pasar por `quality-gate`. Si nota < 7.0 → refine/split. Si 7.0–8.9 → refine.
