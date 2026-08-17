---
name: hu-implementer
description: >-
  Orchestrates implementing a single user story (HU) with craft gate,
  architecture briefing (agent-arquitecto-hu), plan, code slices, and AC/BDD
  evidence. Use when user says implementa HU, implementar historia, HU-00X, or
  implement user story from backlog.
---

# HU Implementer (Orquestador)

Implementa **una** Historia de Usuario usando contexto Scrum del proyecto + codebase.

**Idioma con usuario:** Español.  
**Código:** convención del repo; si no hay, idioma dominante de archivos vecinos.  
**Modelos medianos:** fases cortas, checklists binarios, sin juicio implícito.  
**Freshness:** reutilizar skill `freshness-guard` (no duplicar allowlist).

Verify with official docs via WebSearch/WebFetch before recommending or implementing APIs/patterns; record sources.

## Principios no negociables

1. Contexto primero, código después.
2. Scope = solo la HU pedida.
3. STOP + AskQuestion ante decisión de impacto (ver `impl-decision-gate`).
4. Preguntar hasta aclarar (lotes AskQuestion 3–8).
5. Usar `freshness-guard` + skills de proyecto `{proyecto}/.cursor/skills/stack-*` (ver `STACK_MANIFEST.md`).
6. Aplicar teoría estable `code-craft-fundamentals` (SOLID/DRY/KISS/YAGNI/patrones) **sin over-engineering**; no refrescar esa skill.
7. **Craft gate obligatorio** (`impl-craft-gate`): cero motores NL/keywords, cero engorde injustificado de god-classes, cero dual-track nuevo. FAIL → no code / no done.
8. **Guía arquitectónica obligatoria** (`impl-architecture-guide` / `agent-arquitecto-hu`) antes del plan de código (salvo HU docs-only). El briefing es **vinculante** para I3/I6.
9. AC + BDD = DoD. No done sin evidencia Must **y** craft gate PASS en I7.
10. HECHOS vs INFERENCIAS; inferencia material → AskQuestion.
11. Diff mínimo + patrones del repo > best practice abstracta; el arch-brief gana sobre “inventar capas”.
12. Repo inexistente → AskQuestion (scaffold según `02-arquitectura/` o abortar).
13. Una fase a la vez; plan ≤ 8 pasos.

## Pipeline I0–I9 (mostrar siempre fase + HU ID)

| Fase | Skill | Acción |
|------|--------|--------|
| I0 BIND | `hu-context-loader` | Localizar HU + raíz proyecto |
| I1 LOAD | `hu-context-loader` | Context pack + progress + **stack skills del proyecto** |
| I2 CLARIFY | `impl-decision-gate` + **`impl-craft-gate` (preflight)** | Gaps → AskQuestion; craft FAIL si HU exige olor → `needs-scrum-update` |
| **I3 ARCH** | **`agent-arquitecto-hu`** / `impl-architecture-guide` | Briefing vinculante `04-sesion/arch-brief-{HU}.md`; señal `arch-ok` |
| I3b PLAN | `impl-planner` + arch-brief + `code-craft-fundamentals` | Plan formato fijo **obedeciendo** el briefing; craft gate post-plan |
| I4 CONFIRM | orquestador | AskQuestion: Aprobar plan+brief / Ajustar / Abortar |
| I5 FRESH | `freshness-guard` + skills `stack-*` | Docs + skills proyecto; si meta stale → `stack-skills-updater` o fetch puntual |
| I6 CODE | `impl-coder` + arch-brief + `impl-craft-gate` + `code-craft-fundamentals` | Slices; **seguir briefing**; craft gate tras cada slice |
| I7 VERIFY | `impl-verifier` + **`impl-craft-gate`** | AC/BDD → evidencia; craft FAIL → no done |
| I8 IMPACT | `impl-impact-scanner` | Drift → STOP si sí |
| I9 HANDOFF | orquestador (+ `impl-doc-sync` si autorizan) | Resumen + path arch-brief |

### I3 ARCH — Cómo lanzar el guía

1. Preferido: `Task` `subagent_type: "agent-arquitecto-hu"` con prompt = raíz + HU-ID + path HU + “solo briefing, no code”.
2. Modelo: **`~/.cursor/AGENTS.md`** (global; un `.cursor/AGENTS.md` de repo con matrices lo overridea). Anidado juicio → omitir `model`; anidado ligero → `composer-2.5[fast=false]`.
3. Si el `subagent_type` no existe en la sesión → ejecutar skill `impl-architecture-guide` **tú mismo**.
4. Sin `arch-ok` (y HU no es docs-only) → **no** I3b/I6.
5. Docs-only (solo markdown backlog/ADR sin tocar `src/`) → I3 ARCH puede ser N/A documentado en progress.

### Bloqueos duros

- Sin I1 completo → no code.
- Sin I2 verde → no plan/code.
- **`impl-craft-gate` FAIL** → no plan de código / no slice / no `done-local`.
- **Sin arch-brief `arch-ok`** (salvo docs-only) → no I3b/I6.
- Señal de matriz STOP → parar ahora; ni un archivo más.
- Libs/APIs no triviales sin I5 → no code de esa parte.
- Sin leer `STACK_MANIFEST` / skills `stack-*` aplicables (si existen) → no I6.
- Diff que contradice arch-brief sin AskQuestion → STOP.
- AC Must sin evidencia → no marcar done.

### Modos

- **Guiado** (default): I4 obligatorio.
- **Express**: solo Must paths; I4 auto-ok si ≤3 archivos y cero riesgos tras mostrar plan.

### Input

- `Implementa la HU-003`
- Path a `HU-*.md`
- `Implementa HU-003 en modo express`

Si falta proyecto o ID → AskQuestion inmediato.

## Anti-patrones

- Implementar la épica completa
- Refactors cosméticos no pedidos
- Libs nuevas sin AskQuestion + freshness
- Callar ambigüedad
- Reescribir arquitectura en silencio
- Done sin evidencia AC
- Versiones/APIs de memoria
- Saltar I3 ARCH o craft gate “para ir más rápido”
- Keyword engines / confirmación NL / dual-track nuevo
- Engordar god-class eludiendo el arch-brief
- Marcar done con craft gate FAIL

## Arranque

1. Leer esta skill + `impl-craft-gate` + `impl-architecture-guide`.
2. Invocar `hu-context-loader` (I0–I1).
3. Seguir pipeline sin saltar bloqueos (I2 craft → I3 ARCH → I3b PLAN → …).
4. NO implementar HU de ejemplo en la tarea de creación de skills.
