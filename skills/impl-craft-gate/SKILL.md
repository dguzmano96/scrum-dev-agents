---
name: impl-craft-gate
description: >-
  Binary craft/architecture gate for HU and epic implementation: forbids NL
  keyword engines, god-class growth, dual-track hacks, and other design smells
  before and after coding. Use in hu-implementer (I2/I6/I7) and epic-implementer
  (Epi1/Epi3/Epi6). Blocks done-local if violations remain.
---

# Impl Craft Gate (filtro anti-malas-prácticas)

Gate **binario** (PASS/FAIL). No “casi”. Si falla → **STOP**: no I6 code / no `done-local` / no avanzar HU en épica.

**Honestidad:** no garantiza “100 %” mágica; **sí** hace imposible marcar done con olores prohibidos detectables en plan o diff.

## Cuándo correr

| Momento | Quién | Acción si FAIL |
|---------|-------|----------------|
| Tras I2 (antes de plan/arch) | `hu-implementer` | STOP; si la HU **exige** olor → `needs-scrum-update` |
| Tras I3b ARCH + I3 PLAN | `hu-implementer` | Re-plan o STOP |
| Tras cada slice I6 | `impl-coder` | Revertir/arreglar slice antes de seguir |
| I7 VERIFY | `impl-verifier` | No `done-local` |
| Epi1 / Epi3 prompt / Epi6 | `epic-implementer` | No lanzar o no cerrar HU |

## Skills a leer (obligatorio)

1. `skill-BestPractices`
2. `code-craft-fundamentals`
3. `{proyecto}/.cursor/skills/stack-*` aplicables
4. Si existe: `03-calidad/research/hardcoding-i18n-design-error-review.md`
5. Si existe: último plan en `03-calidad/refactor/*malas-practicas*` (contexto; no reintroducir olores “superseded”)

## Checklist PROHIBIDO (FAIL si el plan o el diff introduce/expande)

### A — Motores léxicos / “i18n intent”

- [ ] Diccionarios/listas de frases por locale para **confirm/reject/intent**
- [ ] `Contains(phrase)` / keyword engines como arquitectura de orquestación
- [ ] Confirmar escritura por texto libre del visitante
- [ ] “Mover frases a JSON/resx” como “fix” del mismo diseño
- [ ] Activación de tools por keywords de idioma (salvo PoC aislado **fuera** de prod DI)

**Correcto:** señales estructuradas (`confirmed`, `proposal_id`, `choice_id`), estado de ejecución (`successfulToolIds`), LLM + flujo/receta.

### B — Arquitectura / SRP

- [ ] Engordar god-class existente (>~400 LOC o ya monolito) con **nueva** responsabilidad no pedida por AC (HTTP+loop+UI+billing en un solo tipo)
- [ ] Duplicar pipeline Bubble↔Test en vez de extraer compartido cuando el AC toca ambos
- [ ] Dual-track (dos mecanismos para el mismo feature) sin plan de retirar uno
- [ ] Side-channel UI acoplado a transporte LLM sin tipo de turn explícito (si el AC permite mejor)
- [ ] Sync-over-async (`.GetAwaiter().GetResult()`) en hot path nuevo
- [ ] `catch (Exception)` que traga errores en path de producto nuevo

### C — Craft básico

- [ ] Secrets hardcodeados
- [ ] Dependencia nueva sin AskQuestion + freshness
- [ ] Over-engineering GoF no justificado por dolor del AC (YAGNI)
- [ ] Refactor cosmético fuera del plan
- [ ] Tests que **codifican** el anti-patrón (p. ej. “NL confirm must execute”)

## Checklist OBLIGATORIO (PASS solo si todos los aplicables están ✔)

- [ ] Briefing de `impl-architecture-guide` / `agent-arquitecto-hu` leído y citado en progress (salvo HU docs-only)
- [ ] Diff sigue “Cómo implementarlo” del briefing (desvíos → AskQuestion)
- [ ] Confirmaciones/escrituras: solo señales estructuradas + proposal-only si aplica
- [ ] Activación/claim: estructural o LLM; **no** nuevos diccionarios es/en
- [ ] Cambios en chat: un path coherente (no reintroducir structured-output legacy de chips si ya retirado)
- [ ] Evidencia de tests o checklist manual que **rechaza** el anti-patrón cuando el AC lo implica

## Salida (pegar en progress)

```markdown
## Craft gate
- Momento: I2 | post-plan | post-slice | I7 | Epi6
- Resultado: PASS | FAIL
- Violaciones: (ninguna | lista A/B/C + path)
- Briefing arch: path o N/A (docs-only)
```

## Relación con EP-CRAFT-001

Si el proyecto tiene `EP-CRAFT-001`, no reabrir olores que esa épica elimina. Preferir patrones del briefing alineados a F1 (confirm early, claim estructural, sin heuristic).
