---
name: impl-architecture-guide
description: >-
  Produces a binding architecture/design-pattern briefing for one HU by reading
  the codebase and HU/epic context. Guides hu-implementer on exactly how to
  implement. Use as I3 ARCH in hu-implementer, or via agent-arquitecto-hu.
  Does not write product code.
---

# Impl Architecture Guide (HU architecture guide)

**Role:** architecture designer. **Does not write product code.** Produces a binding briefing for `impl-planner` / `impl-coder`.

## Preferido: agente

```
# Cualquier nivel (principal o anidado) — SIEMPRE model vía cursor-agent-policy
Task({
  subagent_type: "agent-arquitecto-hu",
  model: "<lookup modo activo × decide>",
  prompt: "modo activo: {low|mid|high|cursor}\nHU-ID, path HU, raíz proyecto. Solo briefing MD. No implementar."
})

# Subagente ligero (lectura/explore)
Task({
  subagent_type: "explore",
  model: "<lookup modo activo × explore>",
  prompt: "modo activo: {low|mid|high|cursor}\nSolo leer área afectada; devolver paths + snippets."
})
```

No hardcodees slugs. No omitas `model`. Lee skill `cursor-agent-policy` antes del Task.

Si `agent-arquitecto-hu` no está en la sesión → **ejecutar esta skill tú mismo** (mismo workflow).

## Precondiciones

- I0–I1 hechos (HU + épica + stack + overview si existe)
- I2 verde (o gaps solo no bloqueantes documentados)
- `impl-craft-gate` checklist A/B leída (no proponer olores prohibidos)

## Método

1. Leer HU (AC/BDD/OoS) + EPIC (IN/OUT/NFR).
2. Explorar codebase en el área afectada (Grep/Glob/Read; explore agent OK).
3. Identify: existing seams, god-classes not to bloat, repo patterns to reuse, contracts (SSE, tools, proposal-only).
4. Elegir **pocos** patrones (máx. 3) justificados por el AC — YAGNI.
5. Write the briefing using the template below.
6. Si el AC de la HU **obliga** un olor del craft-gate → señal `needs-scrum-update` (no inventar bypass).

## Patrones típicos a considerar (catálogo corto; no forzar)

| Situación | Preferir |
|-----------|----------|
| Confirmación usuario | Structured signals + Policy; Strategy/`IConfirmationPolicy` |
| Éxito de tool / claims | Guard por `successfulToolIds` / resultado tool; no NLP |
| Activación tools | LLM + `HasActiveConversationFlow` / feature gate; no keyword engine |
| Bubble vs Test duplicados | Template Method / shared use-case + adapters auth/billing |
| HTTP + domain mezclados | Extraer transport vs orchestrator (solo si el AC toca esa zona) |
| Varias implementaciones | Strategy / DI ya usada en el repo |
| Validación entrada | Existing validators / Result types del repo |

## Archivo de salida

`{proyecto}/04-sesion/arch-brief-{HU-ID}.md`

(Si no existe `04-sesion/`, crearla.)

## Plantilla obligatoria

```markdown
# Arch brief — {HU-ID}

| Campo | Valor |
|-------|--------|
| HU | |
| Épica | |
| Fecha | |
| Craft gate A/B | PASS previsto / FAIL → STOP |

## Contexto codebase (HECHOS)

- Seams / tipos a reutilizar:
- Tipos que NO engordar:
- Contratos a respetar:

## Cómo implementarlo (vinculante)

1. Enfoque (1 párrafo)
2. Pasos de diseño (max 6) — qué crear/mover/extender
3. Patrones aplicados (nombre + por qué + dónde)
4. Anti-patrones explícitamente prohibidos en este diff
5. Límites SRP (qué NO meter en el mismo tipo)

## Mapa a AC

| AC# | Enfoque de diseño |
|-----|-------------------|
| | |

## Riesgos / AskQuestion

- (vacío o lista)

## Señal

- `arch-ok` | `needs-scrum-update` | `needs-user`
```

## Rules

1. The briefing **binds** to the I3 plan and I6 code; deviations → AskQuestion.
2. Prefer patterns already present in the repo over textbook Clean Architecture.
3. Do not request a complete rewrite of a god-class unless the AC explicitly requires it (EP-CRAFT F3).
4. Do not implement code.
5. session-language: follow the `session-language` skill; output and diagrams must use the session language. Gherkin keywords remain English.

## Output to the orchestrator

- Path of `arch-brief-*.md`
- Signal `arch-ok` / STOP
- 3–5 “how to do it” bullets for the coder prompt
