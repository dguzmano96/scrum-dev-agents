# Scrum Idea → Backlog (Cursor global)

Agente + skills globales para transformar **ideas en texto libre** en un backlog Scrum documentado (épicas, HU, diagramas Mermaid, arquitectura, stack verificado).

## Ubicación

| Qué | Ruta |
|-----|------|
| Skills | `~/.cursor/skills/<nombre-skill>/` |
| Regla | `~/.cursor/rules/scrum-backlog-agent.mdc` |
| Este README | `~/.cursor/skills/scrum-idea-to-backlog/README.md` |
| Templates | `~/.cursor/skills/scrum-idea-to-backlog/templates/` |

En Windows: `C:\Users\<user>\.cursor\skills\...`

## Cómo invocar

En cualquier chat de Cursor (Agent mode):

```text
Convierte esta idea en backlog Scrum (modo guiado completo):

[pega tu idea aquí]
```

Variantes:

```text
Genera épicas y HU a partir de esta idea. Usa el wizard Scrum.
```

```text
Retomar backlog del proyecto mi-app: reabrir W3
```

```text
refresh-tech
```

## Modos de sesión (W0)

1. **Guiado completo** (default) — todas las fases con confirmación.
2. **Express** — Must + NFRs mínimos; completeness gate igual obligatorio.
3. **Retomar** — lee carpeta `{proyecto}/` existente y reabre una fase.

## Pipeline

```text
W0 modo → W1–W5 elicit → W6 gate → W7 confirm →
W8 stack (+ freshness) → AskQuestion hasta stack definido →
W8b stack-skill-generator →
Épicas → Audit → HU → Quality → Flujos → Arquitectura → Scaffold → Handoff
```

**W8 obligatorio:** la selección de stack usa la herramienta AskQuestion de Cursor.
Hasta que el usuario elija un stack, el agente **no deja de preguntar** con AskQuestion
(no auto-elige, no escribe `stack.md`, no avanza a W8b/F3+).

Comandos en chat: `pausar` · `continuar` · `modo express` · `reabrir W3` · `saltar a stack` · `refresh-tech` · `actualizar skills del stack`.

Async refresh de skills del proyecto:

```text
/loop 1d Ejecuta stack-skills-updater en proyecto {nombre-proyecto}. Solo reporta cambios o errores.
```

## Skills incluidas

| Skill | Rol |
|-------|-----|
| `scrum-idea-to-backlog` | Orquestador |
| `guided-discovery-wizard` | W0–W7 |
| `requirements-elicitor` | Preguntas + Example Mapping |
| `stack-advisor` | Stack 2–3 opciones + score |
| `stack-skill-generator` | Skills expertos en `{proyecto}/.cursor/skills/stack-*` |
| `stack-skills-updater` | Refresh async/TTL de esos skills |
| `freshness-guard` | Docs oficiales vía WebSearch/WebFetch |
| `epic-creator` | Épicas |
| `user-story-creator` | HU + AC + BDD |
| `story-splitter` | Partir HU grandes |
| `backlog-consistency-auditor` | Anti-contradicción |
| `quality-gate` | Rúbrica 8D |
| `flow-diagram-generator` | Flujo Mermaid por épica |
| `architecture-documenter` | Clases + arquitectura |
| `output-scaffold` | Árbol carpetas + IDs |
| `spike-creator` | Spikes técnicos |
| `nfr-extractor` | NFRs medibles |

## Output esperado

```text
{nombre-proyecto}/
├── .cursor/skills/STACK_MANIFEST.md + stack-*/
├── 00-discovery/
├── 01-backlog/EP-*/HU/
├── 02-arquitectura/ (stack.md, sources-ledger.md, stack-skills-index.md, diagramas/)
├── 03-calidad/
└── 04-sesion/
```

## Probar (smoke)

1. Abre Agent mode en cualquier workspace.
2. Escribe: `Convierte esta idea en backlog Scrum: app de lista de tareas para equipos remotos.`
3. Debe empezar en **W0** con AskQuestion (modo guiado/express/retomar).
4. No debe saltar a épicas sin completeness gate verde.
5. No debe nombrar frameworks concretos sin fase W8 + fuentes en ledger.
6. En W8 debe usar **AskQuestion** para elegir stack y no avanzar hasta respuesta concreta.
7. Tras W8 confirmado debe crear skills en `{proyecto}/.cursor/skills/stack-*`.

## Política anti-deprecación

Skills **no** hardcodean versiones de frameworks. Toda tech concreta se verifica con `freshness-guard` contra docs oficiales y se registra en `sources-ledger.md`.

Verify with official docs via WebSearch/WebFetch before recommending; record sources.
