---
name: freshness-guard
description: >-
  Forces live verification of frameworks, APIs, and versions via WebSearch and
  WebFetch against official docs before tech recommendations; maintains
  sources-ledger.md. Use before stack advice, architecture tech names,
  refresh-tech, or any version/API claim. Verify with official docs via
  WebSearch/WebFetch before recommending; record sources.
---

# Freshness Guard (anti-deprecación)

Verify with official docs via WebSearch/WebFetch before recommending; record sources.

## Principio

Skills = método + templates Scrum (estables).  
**No** versiones de frameworks ni “best stack of YEAR” hardcodeados.  
Toda afirmación tecnológica concreta nace de WebSearch + WebFetch **del día**.

## Allowlist (prioridad)

1. Docs oficiales (`docs.*`, `learn.microsoft.com`, `developer.mozilla.org`, `react.dev`, `nextjs.org/docs`, etc.)
2. Release notes / changelog del repo canónico GitHub
3. Registries: npm, PyPI, NuGet, Maven (current/LTS)
4. Cloud docs oficiales (Azure/AWS/GCP)
5. Specs (RFCs, W3C)

## Banlist (no fuente primaria)

- Listicles SEO (“top 10 stacks”)
- Posts sin fecha o >18 meses sin corroborar en docs oficiales
- Foros como única prueba
- Contenido que contradiga docs oficiales sin release note

## Protocolo obligatorio

ANTES de recomendar stack, nombrar lib/servicio, afirmar vigencia de API, o escribir config de framework:

1. WebSearch: `"{tech} official documentation {tema}"` y/o `"{tech} release notes"`
2. WebFetch 1–3 URLs allowlist
3. Extraer: estable/LTS, deprecations, reemplazos
4. Anotar en `02-arquitectura/sources-ledger.md`:
   - url
   - fecha_fetch (ISO)
   - claim_soportado
   - deprecations_encontradas
5. Si falla/ambiguo → AskQuestion o `SPK-*`; no afirmar certeza

## Caducidad

- `fecha_fetch` > 90 días → re-fetch
- Comando `refresh-tech` → re-validar `stack.md` completo
- Nueva sesión tocando tech → revisar ledger; re-fetch selectivo

## Offline OK (sin web)

Formato Épica/HU, INVEST, MoSCoW, BDD, rúbrica, wizard W0–W11, estructura carpetas, anti-contradicción de negocio.

## Nunca hardcodear

“Usa Next.js 14 / Angular 15 / .NET 6”, listas fijas de stack ganador, APIs de vendor sin verificar.
En su lugar: determinar guidance vía este protocolo y documentar en stack.md + ledger.
