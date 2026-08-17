---
name: output-scaffold
description: >-
  Creates the standard Scrum project folder tree, stable IDs (EP/HU/SPK),
  INDEX.md, traceability.md, and session progress files. Use at start of a
  guided backlog session, during F9, or when initializing project structure.
---

# Output Scaffold

## Árbol obligatorio

```text
{nombre-proyecto}/
├── .cursor/skills/
│   ├── STACK_MANIFEST.md
│   └── stack-*/                 # lo llena stack-skill-generator tras W8
├── 00-discovery/
├── 01-backlog/
│   ├── INDEX.md
│   ├── traceability.md
│   ├── dependencias.md
│   └── EP-{NN}-{slug}/
│       ├── EPIC.md
│       ├── flujo.mmd
│       └── HU/
├── 02-arquitectura/
│   ├── stack.md
│   ├── sources-ledger.md
│   ├── stack-skills-index.md
│   ├── overview.md
│   ├── nfr.md
│   └── diagramas/
├── 03-calidad/
└── 04-sesion/
    ├── wizard-progress.md
    └── completeness-gate.md
```

Crear directorio `.cursor/skills/` vacío + placeholder `STACK_MANIFEST.md` (tabla vacía) si aún no existen skills.
`stack-skill-generator` completa el contenido tras confirmar stack.
## IDs

- Zero-padded: `EP-001`, `HU-012`, `SPK-001`
- slug kebab-case corto
- Mantener contador en `04-sesion/wizard-progress.md` o `01-backlog/INDEX.md`

## INDEX.md

Tabla de épicas y HU con estado (draft / in-review / ready).

## traceability.md

| HU | Épica | Outcome | MoSCoW | Nota calidad |

## Cuándo

- Temprano: crear árbol vacío + session files
- F9: asegurar archivos finales y links rotos
