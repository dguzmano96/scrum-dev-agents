---
name: impl-planner
description: >-
  Builds a fixed-format implementation plan for one HU (max 8 steps, file lists,
  AC-to-evidence map). Use in I3 of story-implementer after clarify gate is green.
---

# Impl Planner (I3)

## Precondiciones

- I1 context pack cargado
- I2 VERDE + **`impl-craft-gate` preflight PASS** (o FAIL documentado → no planificar código)
- **`04-sesion/arch-brief-{HU}.md` con señal `arch-ok`** (salvo docs-only)
- Si no → devolver a `impl-decision-gate` / I3 ARCH

## Formato exacto (escribir en progress)

```markdown
## Plan HU-XXX
### Objetivo (1 frase, desde la HU)
### Arch-brief (path) — pasos de diseño que este plan materializa
### Archivos a tocar (paths)
### Archivos a crear (paths)
### Pasos numerados (max 8) — alineados al briefing
### Tests / evidencia por AC (mapa AC# -> test o prueba manual)
### Craft gate post-plan: PASS | FAIL
### Fuera de alcance (copiar OoS de HU)
### Riesgos / decisiones abiertas (debe ser vacio tras I2)
```

## Reglas

1. Máx **8** pasos; cada paso = cambio verificable.
2. Prohibido “refactor general” / “mejorar estructura”.
3. Solo archivos necesarios para AC Must (y Should solo si usuario lo pidió).
4. **Express:** happy path Must + validaciones críticas; edge/fail solo si AC Must lo exige.
5. Sección riesgos debe estar **vacía**; si no → volver a I2.
6. Mapear cada AC Must a evidencia planeada.
7. No nombrar libs nuevas fuera de `stack.md`; si hacen falta → `impl-decision-gate`.
8. No proponer arquitectura limpia completa ni patrones GoF especulativos fuera del arch-brief (`code-craft-fundamentals` + YAGNI).
9. **El plan no puede contradecir el arch-brief**; si el briefing pide Strategy/Policy/extracción, los pasos lo reflejan.
10. Tras redactar el plan → correr `impl-craft-gate` post-plan; FAIL → reescribir o STOP.

## Salida

- Plan en `impl-*-progress.md`
- Señal al orquestador para I4 (AskQuestion Aprobar/Ajustar/Abortar)
- Express + ≤3 archivos + cero riesgos: orquestador puede auto-continuar tras mostrar plan
- **No code**
