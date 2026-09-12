# Scrum Evolution (Cursor global)

Agente brownfield: idea de **cambio** + código existente → backlog Scrum **delta** (épicas/HU), con el mismo wizard/filtros que `scrum-idea-to-backlog`.

## Ubicación

| Qué | Ruta |
|-----|------|
| Orquestador | `~/.cursor/skills/scrum-evolution/` |
| Regla | `~/.cursor/rules/scrum-evolution-agent.mdc` |

## Invocación

```text
Evoluciona este producto: quiero agregar exportar reportes a CSV. Modo guiado.
```

```text
Hay codigo existente (incompleto). Quiero modificar el flujo de login para agregar 2FA.
```

```text
Mejora: reducir tiempo de carga del dashboard. Genera epicas/HU delta.
```

```text
Retomar evolution: reabrir E10
```

## Pipeline

```text
E0 MODE → E1 INVENTORY → E2 GAP → E3–E7 elicit → E8 GATE → E9 SUMMARY →
E10 IMPACT → E11 BACKLOG delta → E12 ARCH/handoff
```

## Skills propias

| Skill | Rol |
|-------|-----|
| `scrum-evolution` | Orquestador E0–E12 |
| `codebase-inventory` | Mapa código as-is |
| `backlog-as-is-mapper` | Índice backlog existente |
| `evolution-gap-analyzer` | As-is vs idea |
| `change-impact-gate` | Local/Módulo/Breaking/Arquitectura |
| `delta-backlog-writer` | EP/HU delta + changelog |
| `as-is-backlog-bootstrap` | Stub: backlog as-is si no hay docs |
| `stack-skill-generator` | Si E10 agrega tech → skill en `.cursor/skills/stack-*` |
| `stack-skills-updater` | Refrescar skills de stack del proyecto |

## Reutiliza

`freshness-guard`, `guided-discovery-wizard`, `requirements-elicitor`, `epic-creator`, `user-story-creator`, `story-splitter`, `backlog-consistency-auditor`, `quality-gate`, `flow-diagram-generator`, `architecture-documenter`, `output-scaffold`, `stack-advisor`, `spike-creator`, `nfr-extractor`, templates de `scrum-idea-to-backlog`.

## Stack skills

Cualquier tech nueva aprobada en E10 → `stack-skill-generator` crea/actualiza `{proyecto}/.cursor/skills/stack-{slug}/`.
Mantenimiento: `stack-skills-updater` o `/loop 1d`.

## Trío de agentes

1. `scrum-idea-to-backlog` — greenfield  
2. `scrum-evolution` — cada cambio sustancial  
3. `story-implementer` — `Implementa la HU-0XX`

## Smoke test

1. Agent mode en repo con código (o vacío a propósito).
2. Pegar: `Evoluciona: agregar export CSV. Modo guiado.`
3. Debe empezar E0 → E1 inventory (no saltar a épicas).
4. Sin implementar código de producto.
