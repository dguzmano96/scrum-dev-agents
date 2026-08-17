---
name: flow-diagram-generator
description: >-
  Generates Mermaid flow or sequence diagrams per epic from Must user stories.
  Use in F7, when creating flujo.mmd, or when user asks for diagrama de flujo
  de una épica.
---

# Flow Diagram Generator

## Salida

`01-backlog/EP-{NN}-{slug}/flujo.mmd`

## Método

1. Leer EPIC.md + HU Must (y Should si clarifican el flujo).
2. Elegir `flowchart` para journeys; `sequenceDiagram` si hay muchos actores/sistemas.
3. Nodos = pasos de usuario/sistema; decisiones = reglas de negocio.
4. No inventar pasos fuera del backlog; si falta → AskQuestion o gap en auditoría.
5. Opcional: embeber link/resumen en EPIC.md.

## Reglas Mermaid

- IDs de nodo simples (sin espacios raros)
- Etiquetas en Español
- Incluir camino de error principal si hay HU/BDD de fallo

## Tech names

Sin nombres de frameworks concretos salvo stack confirmado (W8) y claim en ledger.
