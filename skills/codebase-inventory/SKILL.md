---
name: codebase-inventory
description: >-
  Inventories existing codebase for brownfield Scrum evolution: modules, observed
  stack, implemented flows, TODOs, public contracts. Writes codebase-map and
  conflicts facts. Use in E1 of scrum-evolution or when mapping as-is code.
---

# Codebase Inventory (E1)

Solo **HECHOS**. Inferencias → `evolution-gap-analyzer`.

## Método

1. Localizar raíz del repo / workspace (AskQuestion si ambiguo).
2. Leer manifests: `package.json`, `*.csproj`, `pyproject.toml`, `go.mod`, `Cargo.toml`, Dockerfiles, etc.
3. Mapear entrypoints y módulos (carpetas `src/`, `app/`, `Services/`, etc.).
4. Buscar flujos relacionados a la idea de cambio (símbolos, rutas, TODOs).
5. Comparar stack observado vs `{proyecto}/02-arquitectura/stack.md` si existe.
6. Listar contratos públicos tocables (API routes, schemas, events).
7. Escribir:
   - `{proyecto}/00-discovery/as-is/codebase-map.md` (template)
   - Filas iniciales en `conflicts.md` si docs ≠ código

## Reglas

- Citar paths como evidencia.
- No proponer diseño todavía.
- No inventar features no vistas en código.
- Si repo vacío/mínimo: documentarlo y AskQuestion (¿seguir / abortar / greenfield Scrum?).

## Salida

codebase-map + señales de conflicto; devolver control al orquestador.
