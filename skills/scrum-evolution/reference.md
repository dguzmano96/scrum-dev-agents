# Referencia — Scrum Evolution

## Árbol salida

```text
{nombre-proyecto}/
├── 00-discovery/
│   ├── brief.md
│   ├── personas.md
│   ├── supuestos.md
│   ├── glosario.md
│   ├── decisions-log.md
│   └── as-is/
│       ├── codebase-map.md
│       ├── backlog-map.md
│       └── conflicts.md
├── 01-backlog/
│   ├── INDEX.md
│   ├── traceability.md
│   ├── dependencias.md
│   ├── changelog-backlog.md
│   └── EP-*/...
├── 02-arquitectura/
├── 03-calidad/
└── 04-sesion/
    ├── wizard-progress.md
    ├── completeness-gate.md
    └── evolution-{slug}-progress.md
```

## Templates locales

Ver `templates/`: codebase-map, backlog-map, conflicts, changelog-backlog, evolution-progress, impact-ask.

EPIC/HU/gate/rúbrica: `../scrum-idea-to-backlog/templates/`.

## Política supersede vs modify

1. Preferir **HU nueva** que supersede a la antigua (link IDs).
2. Modificar HU existente solo con AskQuestion + sección "Historial de cambios".
3. Nunca borrar AC implementados en silencio → `deprecated` / `replaced by HU-XXX`.
