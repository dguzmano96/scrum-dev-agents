---
name: flow-diagram-generator
description: >-
  Generates Mermaid flow or sequence diagrams per epic from Must user stories.
  Use in F7, when creating flujo.mmd, or when user asks for diagrama de flujo
  de una épica.
---

# Flow Diagram Generator

## Output

`01-backlog/EP-{NN}-{slug}/flujo.mmd`

## Method

1. Read EPIC.md + Must HUs (and Shoulds if they clarify the flow).
2. Choose `flowchart` for journeys; `sequenceDiagram` when many actors/systems exist.
3. Nodes = user/system steps; decisions = business rules.
4. Do not invent steps outside the backlog; if missing → AskQuestion or record an audit gap.
5. Opcional: embeber link/resumen en EPIC.md.

## Reglas Mermaid

 - Use simple node IDs (no unusual spaces)
 - Use labels in the session language (follow the `session-language` skill)
 - Include the main error path if there are HU/BDD failure scenarios

## Tech names

Sin nombres de frameworks concretos salvo stack confirmado (W8) y claim en ledger.
