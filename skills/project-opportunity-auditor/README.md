# Project Opportunity Auditor (Cursor global)

Agente de **mejora continua**: descubre oportunidades en proyectos con backlog y/o código, las prioriza como `OPP-*` y hace handoff a Evolución o Implementador.

## Ubicación

| Qué | Ruta |
|-----|------|
| Orquestador | `~/.cursor/skills/project-opportunity-auditor/` |
| Regla | `~/.cursor/rules/project-opportunity-auditor-agent.mdc` |

Windows: `C:\Users\<user>\.cursor\skills\...`

## Invocación

```text
Audita oportunidades de mejora en el proyecto taskflow. Modo completo.
```

```text
Health check del dashboard — foco rendimiento y seguridad.
```

```text
Busca deuda técnica y gaps de tests en @proyecto/
```

```text
Pre-release audit del proyecto antes de producción.
```

```text
Retomar auditoría: reabrir O6
```

## Pipeline

```text
O0 MODE → O1 INVENTORY → O2 ALIGNMENT → O3 NFR → O4 TESTS →
O5 QUALITY → O6 DEPS → O7 STACK → O8 CONSOLIDATE → O9 SELECT → O10 OUTPUT
```

## Skills propias

| Skill | Rol |
|-------|-----|
| `project-opportunity-auditor` | Orquestador O0–O10 |
| `nfr-compliance-checker` | NFR vs evidencia (O3) |
| `test-gap-analyzer` | AC/BDD vs tests (O4) |
| `dependency-health-scanner` | CVE, EOL, deps (O6) |
| `opportunity-scorer` | Priorización OPP (O8) |

## Reutiliza

`codebase-inventory`, `backlog-as-is-mapper`, `as-is-backlog-bootstrap`, `backlog-consistency-auditor`, `evolution-gap-analyzer`, `code-craft-fundamentals`, `freshness-guard`, `stack-skills-updater`, `quality-gate`, `nfr-extractor`, `spike-creator`.

## Cuádruplo de agentes

1. `scrum-idea-to-backlog` — greenfield  
2. `scrum-evolution` — cambio concreto → delta  
3. `story-implementer` — implementa HU  
4. `project-opportunity-auditor` — **descubre** qué mejorar

## Flujo típico

```text
Implementador (varias HU) → Auditor → usuario elige OPP → Evolución → Implementador
```

También útil **antes del primer código** (auditar backlog listo para implementar).

## Smoke test

1. Agent mode en repo con código o backlog.
2. Pegar: `Audita oportunidades de mejora. Modo express.`
3. Debe empezar O0 → O1 inventory (no saltar a OPP sin evidencia).
4. Debe usar WebSearch en O6 si hay manifests de deps.
5. No debe implementar código de producto.

## Comandos

`pausar` · `continuar` · `modo express` · `foco seguridad` · `pre-release` · `refresh-tech`
