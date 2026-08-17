---
name: impl-verifier
description: >-
  Maps HU acceptance criteria and BDD scenarios to evidence (tests or manual
  checklist); blocks done if Must items fail. Use in I7 of hu-implementer.
---

# Impl Verifier (I7)

## Método

1. Leer AC y BDD de la HU.
2. Llenar template `hu-implementer/templates/ac-evidence.md` (o sección en progress).
3. Preferir tests automatizados alineados a BDD si el repo tiene harness.
4. Si **no** hay harness → AskQuestion:
   - Crear tests mínimos
   - Checklist manual
   - Abortar
5. Ejecutar tests existentes relevantes si aplica (comando del repo).
6. Marcar cada AC Must: sí/no + evidencia path o pasos.

## Reglas done

- Cualquier AC **Must** en rojo → estado `blocked` o seguir code; **no** `done-local`.
- BDD Must: cubrir o exención explícita del usuario vía AskQuestion.
- Express: igual para Must; Should puede quedar pendiente documentado.
- **`impl-craft-gate` FAIL** en el diff final → **no** `done-local` (aunque AC estén verdes).
- Sin `arch-brief` (salvo docs-only) → **no** `done-local`.

## Craft verify (obligatorio)

1. Ejecutar checklist A/B/C de `impl-craft-gate` sobre archivos tocados.
2. Confirmar que no se reintrodujeron keywords NL, dual-track, o engorde de god-class fuera del brief.
3. Anexar bloque `## Craft gate` (PASS/FAIL) a la evidencia.

## Salida

- Tabla evidencia actualizada
- Craft gate PASS/FAIL
- Señal verde/roja al orquestador para I8
