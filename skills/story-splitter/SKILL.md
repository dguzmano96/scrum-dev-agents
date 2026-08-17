---
name: story-splitter
description: >-
  Splits oversized user stories using SPIDR and vertical slicing while preserving
  INVEST and epic links. Use when a HU fails size score, spans multiple sprints,
  or user asks to partir / split story.
---

# Story Splitter

Parte HU grandes sin perder valor ni trazabilidad.

## Triggers

- Quality gate dimensión Tamaño < 3 o nota < 7.0 por size
- HU no cabe en un sprint
- Usuario pide split

## Técnicas (SPIDR + variantes)

- **S**pike — incertidumbre técnica → `spike-creator`, luego re-escribir HU
- **P**ath — caminos happy vs alternos
- **I**nterfaces — canales (web/mobile/API) solo si cada uno da valor solo
- **D**ata — subsets de datos/campos
- **R**ules — reglas de negocio una por HU cuando hinchan AC

También: por persona, por operación CRUD con valor, por etapa del journey.

## Reglas

1. Cada hija sigue siendo vertical slice (no “solo DB”).
2. Mantener épica padre; nuevos IDs `HU-NNN`.
3. Actualizar dependencias entre hermanas.
4. Re-pasar `quality-gate` a cada hija.
5. Documentar en `03-calidad/` o notas de la HU origen (marcar origen como reemplazada).

## Prohibido

Split por capas técnicas (UI / API / DB) como HU de entrega.
