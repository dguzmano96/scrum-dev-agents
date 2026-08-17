---
name: impl-architecture-guide
description: >-
  Produces a binding architecture/design-pattern briefing for one HU by reading
  the codebase and HU/epic context. Guides hu-implementer on exactly how to
  implement. Use as I3 ARCH in hu-implementer, or via agent-arquitecto-hu.
  Does not write product code.
---

# Impl Architecture Guide (guía arquitectónica por HU)

**Rol:** diseñador arquitectónico. **No codea** producto. Produce un briefing **vinculante** para `impl-planner` / `impl-coder`.

## Preferido: agente

```
# Desde el chat (subagente)
Task({
  subagent_type: "agent-arquitecto-hu",
  model: "claude-sonnet-5-thinking-medium",
  prompt: "HU-ID, path HU, raíz proyecto. Solo briefing MD. No implementar."
})

# Desde un subagente (sub-subagente con juicio) — omitir model; ver AGENTS.md
Task({
  subagent_type: "agent-arquitecto-hu",
  prompt: "HU-ID, path HU, raíz proyecto. Solo briefing MD. No implementar."
})

# Sub-subagente ligero (lectura/explore)
Task({
  subagent_type: "explore",
  model: "composer-2.5[fast=false]",
  prompt: "Solo leer área afectada; devolver paths + snippets."
})
```

Si `agent-arquitecto-hu` no está en la sesión → **ejecutar esta skill tú mismo** (mismo workflow).

## Precondiciones

- I0–I1 hechos (HU + épica + stack + overview si existe)
- I2 verde (o gaps solo no bloqueantes documentados)
- `impl-craft-gate` checklist A/B leída (no proponer olores prohibidos)

## Método

1. Leer HU (AC/BDD/OoS) + EPIC (IN/OUT/NFR).
2. Explorar codebase en el área afectada (Grep/Glob/Read; explore agent OK).
3. Identificar: seams existentes, god-classes a **no engordar**, patrones del repo a reutilizar, contratos (SSE, tools, proposal-only).
4. Elegir **pocos** patrones (máx. 3) justificados por el AC — YAGNI.
5. Escribir briefing con plantilla abajo.
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

## Reglas

1. Briefing **vincula** a I3 plan e I6 code; desvío → AskQuestion.
2. Preferir patrones **ya en el repo** sobre Clean Architecture de libro.
3. No pedir rewrite de god-class completa salvo que el AC lo sea (EP-CRAFT F3).
4. No implementar código.
5. Idioma: **Español**.

## Salida al orquestador

- Path del `arch-brief-*.md`
- Señal `arch-ok` / STOP
- 3–5 bullets “cómo hacerlo” para el prompt del coder
