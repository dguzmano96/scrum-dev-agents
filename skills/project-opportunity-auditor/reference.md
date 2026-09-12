# Referencia — Project Opportunity Auditor

## Árbol salida

```text
{nombre-proyecto}/
├── 00-discovery/as-is/          ← reutilizado de O1 (codebase-map, backlog-map, conflicts)
├── 02-arquitectura/
│   └── sources-ledger.md        ← actualizar en O6/O7 si hay claims tech
├── 03-calidad/
│   ├── opportunity-report.md    ← resumen ejecutivo + top OPP
│   ├── audit-trail.md           ← qué se revisó, cuándo, modo
│   ├── nfr-compliance.md        ← salida O3
│   ├── test-gaps.md             ← salida O4
│   ├── dependency-health.md     ← salida O6
│   └── opportunities/
│       ├── OPP-001-{slug}.md
│       └── OPP-002-{slug}.md
└── 04-sesion/
    └── audit-{slug}-progress.md
```

## Severidad OPP

| Nivel | Criterio |
|-------|----------|
| **Crítica** | Seguridad explotable, Must roto en prod, NFR Must incumplido con evidencia |
| **Alta** | Bloquea release, deuda que impide próximas HU, gap Must sin workaround |
| **Media** | Should/Could; mejora medible pero no bloqueante |
| **Baja** | Nice-to-have, polish, optimización marginal |

## Agente siguiente por tipo

| Tipo OPP | Agente | Condición |
|----------|--------|-----------|
| Nueva funcionalidad / cambio amplio | `scrum-evolution` | Siempre |
| HU ya existe en backlog | `story-implementer` | HU identificada y ready |
| Backlog/documentación incompleta | `scrum-idea-to-backlog` | Retomar wizard |
| Solo actualizar deps / fix puntual | `story-implementer` o spike | Si usuario prefiere HU mínima |

## Templates

Ver `templates/`: audit-progress, opportunity-report, opportunity-card, audit-trail.
