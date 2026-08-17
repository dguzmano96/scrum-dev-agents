---
name: stack-advisor
description: >-
  Suggests 2–3 scored tech stacks for a product idea after discovery approval
  (W8), using official docs via freshness-guard. Use when choosing stack,
  recommending frontend/backend/DB/hosting, or after Discovery Summary.
---

# Stack Advisor (W8)

Verify with official docs via WebSearch/WebFetch before recommending; record sources.

## Precondiciones

- W6 verde + W7 Discovery Summary aprobado
- Constraints de equipo/cloud/timeline en discovery

## Selección de stack — OBLIGATORIA vía AskQuestion

**W8 no cierra** hasta que el usuario elija un stack concreto con la herramienta **AskQuestion** de Cursor.

| Regla | Detalle |
|-------|---------|
| AskQuestion obligatorio | Tras mostrar 2–3 candidatos + scores + tradeoffs, **siempre** invocar AskQuestion |
| Sin respuesta = no avanzar | Si el usuario no responde, responde ambiguo en chat, o pide más info → **volver a AskQuestion** (no pasar a W8b / F3 / `stack.md`) |
| Prohibido auto-elegir | No asumir preferencia, no “elegir por el usuario”, no escribir `stack.md` sin opción AskQuestion resuelta |
| Loop hasta definir | Mientras el stack no esté definido y confirmado → **seguir usando AskQuestion**; no sustituir por párrafos de chat |
| Confirmación escrita | Solo entonces: `02-arquitectura/stack.md` + ledger + marcar W8 confirmado en `wizard-progress.md` |

### Plantilla AskQuestion (selección)

Pregunta: `¿Qué stack adoptamos?` (fase W8)

Opciones tipicas (adaptar labels a los candidatos reales):

1. **Stack A** — resumen una línea (score)
2. **Stack B** — resumen una línea (score)
3. **Stack C** — resumen una línea (score) *(si hay 3)*
4. **Quiero otro / ajustar constraints** — recalcular candidatos
5. **Elige tú y justifica** — el agente recomienda **una** opción y **debe** lanzar AskQuestion de confirmación:

   - `[Confirmar stack X]` / `[Elegir otra]`  
   - Sin confirmar → no escribir `stack.md`; AskQuestion de nuevo.

### Criterio de “stack definido”

Stack definido solo si AskQuestion devolvió:

- una opción A/B/C concreta, **o**
- confirmación explícita tras “Elige tú…” (`Confirmar stack X`), **o**
- un stack custom propuesto tras “ajustar”, **confirmado** en un AskQuestion posterior.

Cualquier otra cosa → **no definido** → AskQuestion otra vez.

## Método

1. Clasificar arquetipo (**AskQuestion** si dudoso): SaaS B2B web, marketplace, mobile-first, data/ML, realtime, contenido/CMS, enterprise/compliance, otro.
2. Recoger constraints: skills equipo, cloud, web/mobile, compliance, timeline, budget. Si faltan → AskQuestion (no inventar).
3. **Obligatorio** `freshness-guard` antes de recomendar.
4. Proponer **2–3** candidatos con score:

| Criterio | Peso |
|----------|------|
| Familiaridad del equipo | 25% |
| Hiring pool | 20% |
| Exit velocity / handoff | 20% |
| Ecosistema (auth, payments, obs) | 15% |
| Fit al arquetipo | 10% |
| Salud comunidad | 10% |

Veto si algún criterio = 1–2.

5. Tradeoffs: pros/contras, lock-in, costo cognitivo (texto breve en el mensaje).
6. **AskQuestion de selección** (ver sección obligatoria arriba). Repetir hasta stack definido.
7. Solo con stack definido: escribir `02-arquitectura/stack.md` + actualizar `sources-ledger.md` + `04-sesion/wizard-progress.md` (W8 = confirmado).
8. **Obligatorio:** invocar `stack-skill-generator` (W8b) para crear/actualizar
   `{proyecto}/.cursor/skills/stack-*` + `STACK_MANIFEST.md` + `stack-skills-index.md`
   (una skill experta por componente material, con WebSearch/WebFetch del día).

## Bloqueos duros (W8)

- Sin AskQuestion de selección resuelta → **no** `stack.md`, **no** W8b, **no** F3+.
- Sin stack definido → **no** nombres de tech concretas en diagramas/arquitectura.
- “Saltar a épicas” / “elige tú sin preguntar” en chat → ignorar avance; AskQuestion de stack.

## Anti-patrones

- Moda sin allowlist + evidencia
- Microservicios por defecto en MVP
- Versiones de memoria del modelo
- Blogs vs docs oficiales → ganan docs oficiales
- Sin evidencia → AskQuestion + spike
- Auto-confirmar stack “para no molestar”
- Escribir stack.md y pedir “si no te gusta dímelo” después

## Nunca hardcodear en esta skill

Versiones fijas de frameworks. Siempre verificar el día de la sesión.
