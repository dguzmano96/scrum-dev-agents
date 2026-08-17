# Referencia — Solution Research Ideator

## Árbol salida

```text
{nombre-proyecto}/
├── 00-discovery/as-is/                 ← reutilizado de R1 si aplica
│   └── codebase-map.md
├── 02-arquitectura/
│   └── sources-ledger.md               ← append en R2/R6
├── 03-calidad/research/
│   ├── solution-report-{slug}.md       ← entrega principal
│   ├── candidates.md                   ← R3
│   └── debate-transcript.md            ← R4 síntesis
└── 04-sesion/
    └── research-{slug}-progress.md
```

## Scoring (R5) — dimensiones 1–5

| Dimensión | 1 | 5 |
|-----------|---|---|
| **Fit as-is** | Rompe stack / reescritura | Reusa patrones y deps actuales |
| **Modernidad vigente** | Legacy/EOL | Docs oficiales actuales + comunidad sana |
| **Riesgo** | 5 = mucho riesgo (invertir en fórmula) | 1 = bajo |
| **Esfuerzo** | 5 = XL | 1 = XS |
| **Confianza evidencia** | Inferencia | Fuentes allowlist + código citado |

### Fórmula (0–100)

```
raw = (Fit×3 + Modernidad×2 + Confianza×2) - (Riesgo×2 + Esfuerzo×2)
score = clamp(round(raw / 10 × 100), 0, 100)
```

- **#1** = mayor score (desempate: Fit > Confianza > menor Esfuerzo).
- **#2** = siguiente distinta en enfoque (no variante cosmética de #1).

## Cuándo monopolio (solo 1 opción)

Documentar en el reporte:
- Por qué no hay alternativa razonable
- Qué se descartó y por qué
- Spike si la incertidumbre es alta (`SPK-*` sugerido, no creado como backlog final)

## Relación Auditor vs Investigador

| | Auditor | Investigador |
|--|---------|--------------|
| Pregunta | ¿Qué mejorar? | ¿Cómo implementar este pedido? |
| Salida | `OPP-*` | `solution-report-*` |
| Debate | No | Sí (panel) |

## Templates

Ver skill `solution-report-writer` → `templates/`.
