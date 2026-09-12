---
name: story-context-loader
description: >-
  Resolves HU ID/path, loads Scrum context pack (epic, architecture, stack,
  discovery), and writes impl progress file. Use in I0/I1 of story-implementer,
  when binding a user story before coding, or hu-context-loader (legacy name).
---

# HU Context Loader (I0–I1)

## I0 BIND

1. Extraer `HU-ID` o path `.md` del mensaje.
2. Si falta ID o raíz `{proyecto}/` → AskQuestion.
3. Buscar archivo: `01-backlog/EP-*/HU/HU-{NN}-*.md` (o path dado).
4. Derivar épica padre desde carpeta `EP-*`.

Falla cerrado si no existe la HU.

## I1 LOAD — context pack (orden fijo)

Marcar checklist en `{proyecto}/04-sesion/impl-{HU-ID}-progress.md`  
(usar template `story-implementer/templates/impl-progress.md`).

1. HU completa (AC, BDD, deps, OoS, NFRs)
2. `EPIC.md` padre
3. `flujo.mmd` si existe
4. `00-discovery/brief.md`, `glosario.md`, `supuestos.md` (flag bloqueantes)
5. `01-backlog/traceability.md`, `dependencias.md`
6. `02-arquitectura/stack.md`
7. `02-arquitectura/sources-ledger.md`
8. `overview.md`, `nfr.md`, `diagramas/*`
9. Search código relacionado (símbolos/rutas del dominio de la HU)
10. HU dependientes nombradas → **solo lectura**
11. **Stack skills del proyecto:**
    - `{proyecto}/.cursor/skills/STACK_MANIFEST.md`
    - Cada `stack-*/SKILL.md` + `meta.md` relevante al dominio de la HU / stack.md
    - Si manifest falta pero hay stack.md → AskQuestion: generar ahora (`stack-skill-generator`) / continuar con gap / abortar
    - Si algún `meta.md` stale (`ttl_days`) → anotar en progress; en I5 invocar `stack-skills-updater` o fetch puntual vía `freshness-guard`

## Artefactos críticos faltantes

Si falta HU, épica, stack o AC → AskQuestion:

1. Continuar con gap documentado
2. Devolver a agente Scrum
3. Abortar

## Salida

- Progress file creado/actualizado
- Resumen corto al orquestador: paths leídos + gaps
- **No code**
