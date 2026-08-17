---
name: tech-research-scout
description: >-
  Expert method for modern technology research: WebSearch/WebFetch against
  official docs, compare approaches/libs/patterns, extract maturity and
  tradeoffs. Use in R2 of solution-research-ideator or when scouting tech
  options for a concrete user request.
---

# Tech Research Scout (R2)

Método experto de **investigación tecnológica** para el Investigador/Ideador.

Verify with official docs via WebSearch/WebFetch before recommending; record sources (`freshness-guard`).

## Objetivo

Encontrar **2–4 enfoques reales** para el pedido del usuario, alineados (o conscientemente divergentes) del stack as-is, con evidencia del día.

## Allowlist / Banlist

Seguir `freshness-guard`. Priorizar:
1. Docs oficiales
2. Release notes / changelog canónico
3. Registries (npm, PyPI, NuGet, Maven)
4. Cloud docs oficiales
5. RFCs / specs

## Método

1. **Reformular** el pedido en preguntas de búsqueda (problema, no solución asumida).
2. **Anclar al as-is:** ¿qué ya usa el repo? (primera búsqueda = extensión del stack actual).
3. **Abrir el abanico:** alternativas modernas (1–2) + patrón “boring but proven”.
4. Por cada candidato:
   - WebSearch + WebFetch
   - Madurez, deprecations, requisitos, licencia si importa
   - Costo de adopción vs stack actual (hipótesis marcada)
5. **Descartes tempranos** con razón (EOL, incompatible, overkill).
6. Anotar claims en `sources-ledger.md`.
7. Devolver control al orquestador con lista de candidatos.

## Prompt para subagente `agent-research-scout`

```text
Eres agent-research-scout. Pedido del usuario: {pedido}
Stack/as-is relevante: {resumen inventory}
Frente de búsqueda: {frente}
Investiga con WebSearch/WebFetch (allowlist freshness-guard).
Devuelve el formato Scout obligatorio. No modifiques código.
```

## Salida mínima

Archivo o sección `candidates.md` preliminar:

| ID | Enfoque | Familia | Madurez | Fuente principal | Nota fit |
|----|---------|---------|---------|------------------|----------|
| C1 | | | | | |

## Anti-patrones

- Una sola búsqueda y “listo”
- Copiar top-10 blogs
- Ignorar lo que el repo ya tiene
- Afirmar “industry standard” sin fuente
