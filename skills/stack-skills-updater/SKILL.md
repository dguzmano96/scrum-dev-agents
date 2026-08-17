---
name: stack-skills-updater
description: >-
  Asynchronously or on schedule refreshes project stack expert skills by
  checking last_verified TTL, re-fetching official docs, and updating
  .cursor/skills/stack-* plus STACK_MANIFEST. Use with refresh-tech, /loop
  stack skills, or actualizar skills del stack.
---

# Stack Skills Updater (async / periódico)

Mantiene **actualizados** los skills expertos en `{proyecto}/.cursor/skills/stack-*`.

Verify with official docs via WebSearch/WebFetch before recommending; record sources.

## Triggers

- Usuario: `actualizar skills del stack` / `refresh-tech` / `refresh stack skills`
- `/loop 1d actualizar skills del stack del proyecto {nombre}` (u otro intervalo)
- Al inicio de sesión de `hu-implementer` si algún `meta.md` está **stale** (aviso + oferta de update; update completo puede diferirse)

## TTL default

- `ttl_days: 30` en cada `meta.md` (configurable en STACK_MANIFEST)
- Stale si `now - last_verified > ttl_days`
- Fuerza re-fetch si usuario pide refresh aunque no esté stale

## Método (un ciclo)

1. Localizar `{proyecto}/.cursor/skills/STACK_MANIFEST.md` (AskQuestion si falta proyecto).
2. Leer manifest + cada `stack-*/meta.md`.
3. Clasificar: `fresh` | `stale` | `missing` (en stack.md pero sin skill) | `orphan` (skill sin entrada en stack.md).
4. **missing** → invocar `stack-skill-generator` para ese componente.
5. **stale** (o refresh forzado):
   a. `freshness-guard` / WebSearch+WebFetch docs oficiales
   b. Diff: deprecations nuevas, LTS/cambios de API, links rotos
   c. Actualizar `SKILL.md` / `reference.md` / `meta.md` (`last_verified` = ahora)
   d. Actualizar `sources-ledger.md` + manifest
6. **orphan** → AskQuestion: archivar skill / quitar de stack / mantener.
7. Escribir log: `{proyecto}/04-sesion/stack-skills-refresh-log.md` (append).
8. Resumen corto al usuario: qué se actualizó / qué sigue fresco / fallos de fetch.

## Modo async (/loop)

Al armar loop:

```text
/loop 1d Ejecuta skill stack-skills-updater en proyecto {nombre-proyecto}. Solo reporta cambios o errores.
```

O intervalo pedido por usuario (`6h`, `1d`, `7d`). Preferir **1d** default para no gastar tokens.

Reglas loop:
- Un solo loop de stack-skills por proyecto (no duplicar).
- Si fetch falla: log + no borrar skill vieja; marcar `last_attempt` y `status: fetch-failed`.
- No modificar código de producto; solo skills/docs de stack.

## Relación

| Quién | Qué |
|-------|-----|
| `stack-skill-generator` | Crear / regenerar desde stack.md |
| `stack-skills-updater` | Refrescar por TTL / loop |
| `freshness-guard` | Protocolo allowlist |
| `hu-implementer` | Consume skills; si stale en I5 → preferir updater o fetch puntual |

## Fuera de alcance de este updater

- Skills globales de teoría estable (ej. `code-craft-fundamentals`) — **nunca** refrescar aquí
- Código de producto
- Backlog Scrum / HU

## Anti-patrones

- Actualizar desde listicles SEO
- Borrar skill sin AskQuestion si solo falló la red
- Meter secrets en skills
- “Actualizar” sin cambiar `last_verified`
- Incluir `code-craft-fundamentals` u otras skills de teoría en el ciclo TTL
