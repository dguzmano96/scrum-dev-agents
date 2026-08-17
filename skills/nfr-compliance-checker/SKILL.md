---
name: nfr-compliance-checker
description: >-
  Audits defined NFRs against measurable evidence in code, tests, config, and
  observability. Use in O3 of project-opportunity-auditor or when checking if
  performance/security/scale requirements are verified.
---

# NFR Compliance Checker (O3)

Contrasta **NFRs documentados** con **evidencia verificable** en el proyecto.

Verify with official docs via WebSearch/WebFetch when recommending measurement tools or thresholds; record sources (`freshness-guard`).

## Inputs

- `02-arquitectura/nfr.md`
- NFRs en épicas/HU si no hay nfr.md central
- `00-discovery/as-is/codebase-map.md`
- Código, tests, config (CI, monitoring, Docker)

## Método

1. Extraer tabla NFR: requisito | umbral | medición | prioridad MoSCoW.
2. Por cada NFR Must/Should:
   - **Cumple** — evidencia (test, métrica, config, doc operativa)
   - **Parcial** — umbral definido pero sin medición automatizada
   - **Incumple** — evidencia contraria o ausencia en Must
   - **Indefinido** — umbral vago ("rápido") → marcar para `nfr-extractor`, no Must
3. Buscar NFR implícitos en código sin documentar (inferencia → confianza baja).
4. Para herramientas de medición recomendadas → `freshness-guard`.
5. Escribir `03-calidad/nfr-compliance.md`.
6. Por cada gap material → proponer fila OPP para `opportunity-scorer`.

## Salida mínima nfr-compliance.md

| NFR | Umbral doc | MoSCoW | Estado | Evidencia | Gap |
|-----|------------|--------|--------|-----------|-----|
| p95 API login | <200ms | Must | Parcial | solo comentario | sin test ni APM |

## Reglas

- No inventar umbrales; si falta umbral → OPP tipo "definir NFR medible".
- Citar paths como evidencia.
- No implementar métricas aquí.

## OPP típicas

- NFR Must sin test de carga / contrato
- Seguridad documentada sin HTTPS, secrets en repo, RBAC no reflejado en código
- Disponibilidad sin health check
- a11y Must sin pruebas ni criterios observables
