---
name: test-gap-analyzer
description: >-
  Maps Must acceptance criteria and BDD scenarios to test evidence; finds AC
  without coverage and orphan tests. Use in O4 of project-opportunity-auditor
  or when auditing DoD completeness.
---

# Test Gap Analyzer (O4)

Detecta **gaps entre AC/BDD Must y evidencia de verificación**.

## Inputs

- `01-backlog/**/HU/*.md` — AC checklist + escenarios BDD
- `03-calidad/` — evaluation-report, ac-evidence si existe
- Tests en repo: `**/*test*`, `**/*spec*`, `e2e/`, `cypress/`, etc.
- Notas de `impl-verifier` en sesiones previas si hay

## Método

1. Listar todas las HU con estado Must (desde INDEX / backlog-map).
2. Por cada HU Must:
   - Extraer AC-1, AC-2… y escenarios BDD Given/When/Then
   - Buscar evidencia: test automatizado, manual documentado, o commit referenciado
   - Estado: **Cubierto** | **Parcial** | **Sin evidencia**
3. Detectar tests huérfanos (cubren comportamiento sin HU/AC).
4. Detectar HU marcadas done sin evidencia en I7 style.
5. Escribir `03-calidad/test-gaps.md`.
6. Gaps Must → candidatos OPP.

## Salida mínima test-gaps.md

| HU | AC/BDD | MoSCoW | Evidencia encontrada | Estado | Notas |
|----|--------|--------|----------------------|--------|-------|
| HU-003 | AC-2 export CSV | Must | ninguna | Sin evidencia | |

## Resumen

- Total AC Must: X
- Cubiertos: Y
- Sin evidencia: Z
- HU Must sin ningún AC cubierto: [lista]

## Reglas

- No escribir tests aquí.
- "Cubierto" requiere path a test o doc de evidencia explícito.
- BDD y AC se evalúan por separado pero en la misma tabla.

## OPP típicas

- AC Must sin test en path crítico
- Escenario BDD happy path sin e2e
- HU done en INDEX sin ac-evidence
