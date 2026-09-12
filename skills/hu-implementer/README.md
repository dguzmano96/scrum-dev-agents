# HU Implementer (Cursor global)

Agente + skills para **implementar una HU** usando el backlog/arquitectura generados por el agente Scrum + el código del repo.

Diseñado para modelos medianos (Gemini Flash, Composer, GPT mini, etc.): fases cortas, checklists, STOP+AskQuestion.

## Ubicación

| Qué | Ruta |
|-----|------|
| Orquestador | `~/.cursor/skills/hu-implementer/` |
| Regla | `~/.cursor/rules/hu-implementer-agent.mdc` |
| Freshness (reuso) | `~/.cursor/skills/freshness-guard/` |

Windows: `C:\Users\<user>\.cursor\skills\...`

## Invocación

```text
Implementa la HU-003 del proyecto {nombre-proyecto}. Modo guiado.
```

```text
Implementa HU-003 en modo express
```

```text
Implementa @ruta/proyecto/01-backlog/EP-001-x/HU/HU-003-y.md
```

```text
Estoy bloqueado: reabrir decisión sobre dependencia
```

## Pipeline

```text
I0 BIND → I1 LOAD → I2 CLARIFY → I3 PLAN → I4 CONFIRM →
I5 FRESH → I6 CODE → I7 VERIFY → I8 IMPACT → I9 HANDOFF
```

## Skills

| Skill | Rol |
|-------|-----|
| `hu-implementer` | Orquestador I0–I9 |
| `cursor-agent-policy` | Lookup `model` (modo × tipo). Scrum no elige slugs |
| `hu-context-loader` | Context pack + progress + stack skills proyecto |
| `impl-decision-gate` | Matriz STOP + AskQuestion |
| `impl-planner` | Plan ≤8 pasos |
| `impl-coder` | Slices; usa `stack-*` del proyecto |
| `impl-verifier` | AC/BDD → evidencia |
| `impl-impact-scanner` | Drift scan |
| `impl-doc-sync` | Actualizar docs solo si autorizan |
| `freshness-guard` | Docs oficiales (existente) |
| `stack-skills-updater` | Si meta de stack skill está stale |
| `code-craft-fundamentals` | SOLID/DRY/KISS/YAGNI/patrones (estático, sin refresh) |

## Stack skills del proyecto

Tras W8 del Scrum agent, viven en `{proyecto}/.cursor/skills/stack-*`.
El implementador **debe** leerlas en I1/I5/I6.
Refresh: `actualizar skills del stack` o `/loop 1d … stack-skills-updater`.

Teoría de código: skill global `code-craft-fundamentals` — **no** se actualiza con el loop de stack.

## Relación con Scrum agent

- **Scrum** (`scrum-idea-to-backlog`): genera discovery, épicas, HU, arquitectura, stack.
- **Implementador**: consume esos artefactos y escribe código.
- Si hay que cambiar épica/HU/arquitectura → AskQuestion; preferible volver al Scrum agent.

## Smoke test

1. Agent mode + modelo mediano.
2. `Implementa la HU-001` (con o sin proyecto).
3. Debe pedir proyecto/ID si falta (I0) o cargar context pack (I1).
4. No debe codear sin gate I2 verde ni sin plan.

## Optimización costo

- **Con qué:** skill `cursor-agent-policy` (matriz del modo de la sesión), no “modelo mediano” a ojo.
- I2/I8: AskQuestion > inventar.
- Fases cortas > monólogo largo.
