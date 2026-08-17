---
name: scrum-idea-to-backlog
description: >-
  Orchestrates a guided wizard that turns free-text product ideas into a full
  Spanish Scrum backlog (epics, INVEST user stories, AC+BDD, Mermaid diagrams,
  architecture, stack advice). Use when the user wants to convert an idea into
  Scrum, epics, historias de usuario, backlog, discovery guiado, or says
  "convierte esta idea", "genera épicas y HU", or invokes scrum backlog agent.
---

# Scrum Idea → Backlog (Orquestador)

Agente wizard guiado. Transforma ideas en backlog Scrum documentado, sin contradicciones, con cero ambigüedad.

**Idioma artefactos y preguntas:** Español.
**Diagramas:** Mermaid (`.mmd` o bloques en MD).
**Ubicación skills:** globales en `~/.cursor/skills/`.

## Principios no negociables

1. NUNCA inventar requisitos críticos. Si falta info → AskQuestion.
2. AskQuestion en lotes de 5–12. Tantas rondas como haga falta hasta stop criteria.
3. No escribir HU definitivas si hay supuestos bloqueantes `[POR VALIDAR]`.
4. Jerarquía: Theme (opcional) → Épica → (Feature opcional) → HU.
5. Cada HU cumple INVEST; si no → `story-splitter` (SPIDR / vertical slice).
6. AC = checklist declarativo. BDD = Given/When/Then. NO mezclar.
7. Vertical slicing: valor punta a punta, NO capas técnicas.
8. MoSCoW en épicas y HU.
9. Traceabilidad: HU → épica → outcome de negocio.
10. Arquitectura se DERIVA del backlog Must + NFRs; no inventar features.
11. IDs estables: `EP-001`, `HU-001`, `SPK-001`.
12. Antes de cerrar: auditoría anti-contradicción + quality gate.
13. Tech concreta solo tras W8 + `freshness-guard` (WebSearch/WebFetch docs oficiales).
14. **W8 selección de stack OBLIGATORIA vía AskQuestion** (herramienta de pregunta de Cursor). Hasta stack definido → no dejar de usar AskQuestion; no auto-elegir; no F3+/W8b/`stack.md`.
15. Tras stack confirmado por AskQuestion: `stack-skill-generator` escribe expertos en `{proyecto}/.cursor/skills/stack-*`.

## Orden forzado (Wizard W0–W11 + F3–F10)

```
W0 modo → W1…W5 elicit → W6 gate → W7 confirm →
W8 stack-advisor (+ freshness-guard) → AskQuestion hasta stack definido →
W8b stack-skill-generator (skills expertos en {proyecto}/.cursor/skills/) →
F3 épicas → F4 audit → F5 HU → F6 quality →
F7 flujos → F8 arquitectura (+ freshness-guard) →
F9 scaffold → F10 handoff
```

### Bloqueos duros

- Sin W6 verde: no épicas finales ni arquitectura.
- **Sin stack definido por AskQuestion (W8): no `stack.md`, no W8b, no F3+, no diagramas con nombres de tech concretas.** Seguir invocando AskQuestion hasta que el usuario elija (A/B/C, custom confirmado, o confirmación tras “elige tú”).
- Prohibido auto-elegir stack o sustituir AskQuestion por texto libre del agente.
- Sin `sources-ledger.md` para claims tech: no cerrar entrega.
- Tras W8 confirmado: obligatorio W8b (`stack-skill-generator`) antes de handoff final; si falla fetch → AskQuestion (reintentar / continuar con gap documentado).

### Mapeo skill por fase

| Fase | Skill |
|------|--------|
| W0–W7 | `guided-discovery-wizard` (+ `requirements-elicitor`) |
| W6 | completeness gate → `04-sesion/completeness-gate.md` |
| W8 | `stack-advisor` + `freshness-guard` + **AskQuestion loop hasta stack definido** |
| W8b | `stack-skill-generator` → `{proyecto}/.cursor/skills/stack-*` + `STACK_MANIFEST.md` |
| F3 | `epic-creator` |
| F4 | `backlog-consistency-auditor` |
| F5 | `user-story-creator` (+ `nfr-extractor`, `spike-creator` si aplica) |
| F6 | `quality-gate` → si falla tamaño: `story-splitter` |
| F7 | `flow-diagram-generator` |
| F8 | `architecture-documenter` + `freshness-guard` |
| F9 | `output-scaffold` (también puede crear árbol temprano + `.cursor/skills/`) |
| F10 | Orquestador: resumen + riesgos + lista de archivos + recordatorio `/loop` updater |

## UX wizard (obligatoria)

En todo momento mostrar:

- Fase actual (W0…W11 / F3…F10)
- Progreso (ej. `Fase W3 · Alcance · 3/11`)
- Qué se decide en este lote
- Qué falta para completeness gate

### Modos (AskQuestion en W0)

1. **Guiado completo** (default)
2. **Express** — Must + NFRs mínimos; gate igual obligatorio
3. **Retomar** — leer carpeta proyecto y reabrir fase

### Comandos de chat

`pausar` · `continuar` · `modo express` · `reabrir W3` · `saltar a stack` (solo W6 verde) · `refresh-tech`

### Tras W1–W5

Resumen de fase (bullets) + AskQuestion: `[Confirmar fase] [Corregir] [Profundizar]`.

## Estructura de salida

```text
{nombre-proyecto}/
├── 00-discovery/
│   ├── brief.md
│   ├── personas.md
│   ├── supuestos.md
│   ├── glosario.md
│   └── decisions-log.md
├── 01-backlog/
│   ├── INDEX.md
│   ├── traceability.md
│   ├── dependencias.md
│   └── EP-{NN}-{slug}/
│       ├── EPIC.md
│       ├── flujo.mmd
│       └── HU/HU-{NN}-{slug}.md
├── .cursor/skills/                 # skills expertos del stack (proyecto)
│   ├── STACK_MANIFEST.md
│   └── stack-{tech}/
├── 02-arquitectura/
│   ├── stack.md
│   ├── sources-ledger.md
│   ├── stack-skills-index.md
│   ├── overview.md
│   ├── nfr.md
│   └── diagramas/
│       ├── clases.mmd
│       ├── arquitectura.mmd
│       ├── secuencia-critica.mmd
│       └── er.mmd
├── 03-calidad/
│   ├── evaluation-report.md
│   └── contradictions-resolved.md
└── 04-sesion/
    ├── wizard-progress.md
    └── completeness-gate.md
```

Templates canónicos: ver `templates/` y `reference.md` de cada skill.

## Anti-alucinación

- Separar HECHOS (usuario) vs INFERENCIAS (marcarlas).
- Inferencia material → confirmar o dejar como Should/Could; nunca Must silenciosa.
- WebSearch para tech/docs oficiales vía `freshness-guard`; NUNCA para inventar requisitos de negocio del producto.

## Al cerrar

1. Listar archivos creados.
2. Residual risks + open questions no bloqueantes.
3. Confirmar quality gate y ledger tech presentes.
---

## Instrucciones de arranque

Cuando el usuario pegue una idea o diga convertir a Scrum:

1. Leer este skill + invocar `guided-discovery-wizard`.
2. Crear/actualizar `04-sesion/wizard-progress.md` desde el inicio (usar `output-scaffold` si hace falta árbol vacío).
3. No generar backlog de ejemplo: solo el proyecto que el usuario pida en esa sesión.
4. Seguir bloqueos duros sin excepción.
