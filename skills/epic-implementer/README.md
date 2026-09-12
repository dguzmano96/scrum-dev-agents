# Epic Implementer (Cursor global)

Agente + skill para **implementar una épica completa** orquestando al `story-implementer` **HU por HU mediante subagentes `agent-implementer` aislados**, con build+test tras cada HU, STOP+AskQuestion enriquecido (técnica + no técnica + soluciones) y docs siempre actualizadas.

El orquestador **no codea**: lanza un subagente `agent-implementer` nuevo por cada HU (vía `Task`), recoge su estado/evidencia y aplica build+test + sync + gates.

Diseñado para modelos medianos (Gemini Flash, Composer, GPT mini, etc.): fases cortas, checklists, STOP+AskQuestion.

## Ubicación

| Qué | Ruta |
|-----|------|
| Orquestador | `~/.cursor/skills/epic-implementer/` |
| Agente | `~/.cursor/agents/agent-epic-implementer.md` |
| Regla | `~/.cursor/rules/epic-implementer-agent.mdc` |
| Freshness (reuso) | `~/.cursor/skills/freshness-guard/` |

Windows: `C:\Users\<user>\.cursor\skills\...`

## Invocación

```text
Implementa la épica EP-001 del proyecto {nombre-proyecto}. Modo guiado.
```

```text
Implementa EP-001 en modo express
```

```text
Implementa todas las HU Must de EP-002
```

```text
Reanudar épica EP-001 desde HU-003
```

```text
Estoy bloqueado: reabrir decisión sobre dependencia de la épica
```

## Pipeline

```text
Epi0 BIND → Epi1 PREFLIGHT → Epi2 QUEUE →
  [ por cada HU:
    Epi3 LOOP (Task → subagente agent-implementer → story-implementer I0–I9) →
    Epi4 BUILD+TEST →
    Epi5 SYNC →
    Epi6 GATE
  ] →
Epi8 HANDOFF
```

## Skills

| Skill | Rol |
|-------|-----|
| `epic-implementer` | Orquestador Epi0–Epi8 (no codea) |
| `agent-implementer` (subagente) | Motor por HU — lanzado vía `Task` en Epi3; ejecuta `story-implementer` (I0–I9) aislado |
| `story-implementer` | Pipeline I0–I9 (dentro del subagente) |
| `story-context-loader` | Context pack + stack skills proyecto (Epi1) |
| `backlog-consistency-auditor` | Preflight de contradicciones/deps (Epi1, opcional) |
| `impl-decision-gate` | Matriz STOP + AskQuestion (dentro de cada HU) |
| `impl-planner` / `impl-coder` / `impl-verifier` / `impl-impact-scanner` | Vía `story-implementer` |
| `impl-doc-sync` | Auto-sync de estado/INDEX/progress (Epi5, alcance limitado) |
| `freshness-guard` | Docs oficiales (existente) |
| `stack-skills-updater` | Si meta de stack skill está stale |
| `code-craft-fundamentals` | SOLID/DRY/KISS/YAGNI/patrones (estático, sin refresh) |

## STOP + AskQuestion enriquecido

Ante duda, contradicción, drift, fallo de build/test o AC Must en rojo, el agente **para** y pregunta con:

1. **Explicación técnica** del problema.
2. **Explicación no técnica completa** (4–6 frases en llano; sin jerga; debe bastar sola para decidir).
3. **Impacto** en HU / épica / arquitectura / stack.
4. **Soluciones posibles** (2–4 opciones cerradas + "otra" + "abortar épica").

No codea hasta respuesta.

## Docs que actualiza solo (Epi5)

- Estado de cada HU (`Estado implementación: done-local — fecha`).
- `01-backlog/INDEX.md` y `traceability.md` (estado).
- `01-backlog/dependencias.md` (si se resuelve una dependencia).
- `04-sesion/epic-{EP-ID}-progress.md` (cola, fase, decisiones).
- `00-discovery/decisions-log.md` (decisiones ya respondidas por el usuario).

## Docs que NO toca sin AskQuestion explícita

- AC, BDD, alcance IN/OUT de HU.
- `EPIC.md`, `overview.md`, `stack.md`, `nfr.md`, diagramas.

Si el código fuerza un cambio de requisito → STOP + handoff a Scrum/Evolución.

## Relación con otros agentes

- **Scrum / Evolución**: generan épicas y HU. Este agente **consume** esos artefactos.
- **`agent-implementer` (HU)**: motor por HU. Este agente **lo lanza como subagente** en Epi3 (uno nuevo por HU, contexto aislado); no lo duplica ni codea.
- **Auditor de Oportunidades**: tras cerrar la épica, handoff natural para health check.

## Smoke test

1. Agent mode + modelo mediano.
2. `Implementa la épica EP-001` (con proyecto documentado).
3. Debe pedir proyecto/EP-ID si falta (Epi0) o cargar EPIC + HU hijas (Epi1).
4. Debe mostrar cola propuesta + AskQuestion de alcance/modo/build (Epi2).
5. No debe codear sin Epi2 confirmado ni saltar build/test tras cada HU.

## Optimización costo

- Epi3 con modelo mediano (delegado a `story-implementer`).
- Epi4/Epi6: AskQuestion > inventar o saltar.
- Fases cortas > monólogo largo.
- Reutilizar `story-implementer` sin reinventar el pipeline I0–I9.
