---
name: impl-decision-gate
description: >-
  Classifies implementation decisions (local-ok vs needs-user vs needs-scrum-update)
  and forces STOP+AskQuestion using the impact matrix. Use in I2 clarify, anytime
  ambiguity appears, or before risky changes during HU implementation.
---

# Impl Decision Gate (I2 + runtime STOP)

## Clasificación (obligatoria)

| Clase | Significado | Acción |
|-------|-------------|--------|
| `local-ok` | Detalle local sin impacto en HU/épica/arquitectura/stack | Continuar |
| `needs-user` | Usuario debe elegir | STOP + AskQuestion |
| `needs-scrum-update` | Cambia backlog/arquitectura documentada | STOP + AskQuestion; sugerir Scrum agent; `impl-doc-sync` solo si autorizan |

## Matriz STOP → AskQuestion

Parar **inmediatamente** si:

1. **Ambigüedad requisito** — AC contradictorio; BDD vs AC; término fuera de glosario
2. **Cambio alcance** — feature no en HU/épica; “agrego X de paso”
3. **Drift arquitectura** — nuevo contexto/DB/servicio; romper capas
4. **Drift stack** — lib no en `stack.md`; cambiar ORM/auth/hosting
5. **Contrato compartido** — schema/API pública usada por otras HU
6. **Seguridad/compliance** — authz, PII, secretos, logs sensibles sin NFR
7. **Dependencia nueva** — package no previsto
8. **Tradeoff irreversible** — migración, rename masivo, borrar módulo
9. **Test strategy** — no hay harness y hay que elegir framework
10. **Conflicto código vs docs** — código hace A, HU pide B

## Formato AskQuestion

Usar `story-implementer/templates/decision-ask.md`:

- 2–4 bullets (hecho vs opciones)
- Impacto HU / épica / arquitectura
- Opciones cerradas + “otra”
- No continuar hasta respuesta

## I2 Clarify gate

1. Revisar HU + supuestos bloqueantes + gaps del loader.
2. Emitir AskQuestion en lotes 3–8 hasta resolver bloqueantes.
3. Marcar I2 VERDE en progress solo si no quedan bloqueantes.
4. Si usuario dice “asume X” → anotar en progress + pedir si va a `decisions-log` vía `impl-doc-sync`.

## Regla de oro

Ante duda entre `local-ok` y `needs-user` → **needs-user**.
