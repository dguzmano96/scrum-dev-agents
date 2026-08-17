---
name: backlog-consistency-auditor
description: >-
  Audits Scrum backlogs for contradictions, overlaps, journey gaps, and circular
  dependencies; updates contradictions-resolved.md. Use after creating epics or
  stories, before handoff, or when user asks for auditoría de backlog.
---

# Backlog Consistency Auditor

## Checks

1. **Solapes** — dos HU/épicas con mismo outcome o mismos AC
2. **Contradicciones** — reglas opuestas entre HU o vs discovery
3. **Gaps de journey** — pasos Must sin HU
4. **Huérfanas** — HU sin épica o épica sin outcome
5. **Dependencias circulares**
6. **MoSCoW incoherente** — Should que bloquea Must, etc.
7. **Glosario** — mismo término con dos significados

## Método

1. Leer `00-discovery/`, `01-backlog/INDEX.md`, EPIC.md, HU.
2. Listar hallazgos con severidad: bloqueante / menor.
3. Bloqueantes → AskQuestion o corrección directa si el hecho ya está en discovery.
4. Escribir `03-calidad/contradictions-resolved.md`.
5. Actualizar `traceability.md` / `dependencias.md` si hace falta.

## Salida mínima contradictions-resolved.md

| ID hallazgo | Severidad | Descripción | Resolución | Fecha |
|-------------|-----------|-------------|------------|-------|
