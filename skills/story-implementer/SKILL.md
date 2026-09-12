---
name: story-implementer
description: >-
  Orchestrates implementing a single user story (HU) with craft gate,
  architecture briefing (agent-story-architect), plan, code slices, and AC/BDD
  evidence. Use when user says implementa HU, implementar historia, HU-00X,
  implement user story, or invokes hu-implementer (legacy name).
---

# HU Implementer (Orchestrator)

Implements a single User Story using the project's Scrum context and the codebase.

session-language: follow the `session-language` skill; interact with the user in the session language.  
**Code:** follow the repo convention; if none, the dominant language of neighboring files.  
**Medium models:** short phases, binary checklists, no implicit judgment.  
**Freshness:** reuse skill `freshness-guard` (do not duplicate the allowlist).

Verify with official docs via WebSearch/WebFetch before recommending or implementing APIs/patterns; record sources.

## Non-negotiable principles

1. Context first, code second.
2. Scope = only the requested HU.
3. STOP + AskQuestion on impact decisions (see `impl-decision-gate`).
4. Keep asking until clear (AskQuestion batches of 3–8).
5. Use `freshness-guard` + project skills `{project}/.cursor/skills/stack-*` (see `STACK_MANIFEST.md`).
6. Apply stable theory `code-craft-fundamentals` (SOLID/DRY/KISS/YAGNI/patterns) **without over-engineering**; do not refresh that skill.
7. **Mandatory craft gate** (`impl-craft-gate`): zero NL/keyword engines, zero unjustified god-class stuffing, zero new dual-track. FAIL → no code / no done.
8. **Mandatory architecture guide** (`impl-architecture-guide` / `agent-story-architect`) before the code plan (except docs-only HUs). The briefing is **binding** for I3/I6.
9. AC + BDD = DoD. No done without Must evidence **and** craft gate PASS at I7.
10. FACTS vs INFERENCES; material inference → AskQuestion.
11. Minimal diff + repo patterns > abstract best practice; the arch-brief wins over “invent layers”.
12. Missing repo → AskQuestion (scaffold from `02-arquitectura/` or abort).
13. One phase at a time; plan ≤ 8 steps.

## Pipeline I0–I9 (mostrar siempre fase + HU ID)

| Fase | Skill | Acción |
|------|--------|--------|
| I0 BIND | `story-context-loader` | Localizar HU + raíz proyecto |
| I1 LOAD | `story-context-loader` | Context pack + progress + **stack skills del proyecto** |
| I2 CLARIFY | `impl-decision-gate` + **`impl-craft-gate` (preflight)** | Gaps → AskQuestion; craft FAIL si HU exige olor → `needs-scrum-update` |
| **I3 ARCH** | **`agent-story-architect`** / `impl-architecture-guide` | Briefing vinculante `04-sesion/arch-brief-{HU}.md`; señal `arch-ok` |
| I3b PLAN | `impl-planner` + arch-brief + `code-craft-fundamentals` | Plan formato fijo **obedeciendo** el briefing; craft gate post-plan |
| I4 CONFIRM | orquestador + `session-language` | AskQuestion: Approve plan+brief / Adjust / Abort |
| I5 FRESH | `freshness-guard` + skills `stack-*` | Docs + skills proyecto; si meta stale → `stack-skills-updater` o fetch puntual |
| I6 CODE | `impl-coder` + arch-brief + `impl-craft-gate` + `code-craft-fundamentals` | Slices; **seguir briefing**; craft gate tras cada slice |
| I7 VERIFY | `impl-verifier` + **`impl-craft-gate`** | AC/BDD → evidencia; craft FAIL → no done |
| I8 IMPACT | `impl-impact-scanner` | Drift → STOP si sí |
| I9 HANDOFF | orquestador + `session-language` (+ `impl-doc-sync` if authorized) | Summary + path to arch-brief |

### I3 ARCH — How to launch the guide

1. Preferred: `Task` `subagent_type: "agent-story-architect"` with prompt = root + HU-ID + HU path + “briefing only, no code”.
2. Model: use the **`cursor-agent-policy`** skill — `model` = lookup(`modo activo`, `decide`) for `agent-story-architect`. **Never omit `model`.** Auxiliary reading/`explore` → use `explore` type. Forward `modo activo` and `session language` in the child's prompt.
3. If the `subagent_type` does not exist in the session → run skill `impl-architecture-guide` **yourself**.
4. No `arch-ok` (and the HU is not docs-only) → **no** I3b/I6.
5. Docs-only (backlog/ADR markdown only, no `src/` edits) → I3 ARCH may be N/A documented in progress.

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

### Modes

- **Guided** (default): I4 mandatory.
- **Express**: Must paths only; I4 auto-ok if ≤3 files and zero risks after showing the plan.

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
2. Invocar `story-context-loader` (I0–I1).
3. Seguir pipeline sin saltar bloqueos (I2 craft → I3 ARCH → I3b PLAN → …).
4. NO implementar HU de ejemplo en la tarea de creación de skills.
