---
name: impl-doc-sync
description: >-
  Optionally updates HU status notes and decisions-log after user authorization;
  never changes AC/epic/architecture without explicit AskQuestion approval. Use
  after HU implementation handoff when user asks to sync docs.
---

# Impl Doc Sync (opcional)

## Precondiciones

Usuario autorizó explícitamente en AskQuestion (“actualizar docs también” o equivalente).

## Permitido (con autorización)

1. Nota de estado en la HU (ej. `Estado implementación: done-local — fecha`)
2. Entrada en `00-discovery/decisions-log.md` (decisión + fecha + HU)
3. Actualizar fila en `01-backlog/INDEX.md` / traceability (estado)
4. Progress/handoff ya generados

## Prohibido sin AskQuestion dedicada (needs-scrum-update)

- Cambiar AC, BDD, alcance IN/OUT
- Reescribir EPIC.md / overview / stack / diagramas
- “Ajustar” requisitos para que coincidan con el código

Si el código forzó un cambio de requisito → recomendar **agente Scrum** + no silenciar.

## Salida

Lista de docs tocados + recordatorio de review humano.
