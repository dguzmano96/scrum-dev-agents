---
name: architecture-documenter
description: >-
  Documents architecture derived only from Must backlog and NFRs: overview,
  nfr.md, class and architecture Mermaid diagrams. Verify with official docs via
  WebSearch/WebFetch before recommending; record sources. Use in F8 or when
  user asks for diagrama de clases/arquitectura.
---

# Architecture Documenter

Verify with official docs via WebSearch/WebFetch before recommending; record sources.

## Precondiciones

- Stack confirmado en `02-arquitectura/stack.md`
- Claims tech en `sources-ledger.md` (invocar `freshness-guard`)
- Backlog Must disponible

## Salidas

- `02-arquitectura/overview.md`
- `02-arquitectura/nfr.md`
- `02-arquitectura/diagramas/clases.mmd`
- `02-arquitectura/diagramas/arquitectura.mmd`
- Opcional: `secuencia-critica.mmd`, `er.mmd`

## Método

1. Derivar componentes SOLO de capacidades Must + NFRs + stack elegido.
2. **No** inventar features nuevas.
3. Antes de nombrar libs/servicios → `freshness-guard`.
4. Clases/módulos = lenguaje de dominio (glosario) + bordes del sistema.
5. Si falta info técnica → AskQuestion o `spike-creator`, no adivinar proveedores.

## overview.md mínimo

Contexto, contenedores/componentes, decisiones clave (ADR cortos), threats/notas, links a diagramas y stack.
