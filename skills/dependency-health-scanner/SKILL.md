---
name: dependency-health-scanner
description: >-
  Scans project dependencies for CVEs, EOL versions, and outdated packages
  using WebSearch/WebFetch and official advisories. Use in O6 of
  project-opportunity-auditor or refresh-tech dependency audit.
---

# Dependency Health Scanner (O6)

Audita **salud de dependencias** con verificación en vivo.

**Obligatorio:** WebSearch + WebFetch vía `freshness-guard` antes de afirmar CVE, EOL o versión recomendada.

## Inputs

- Manifests: `package.json`, `package-lock.json`, `pnpm-lock.yaml`, `*.csproj`, `requirements.txt`, `poetry.lock`, `go.mod`, `Cargo.toml`, etc.
- `02-arquitectura/stack.md` — versiones esperadas
- `02-arquitectura/sources-ledger.md` — actualizar con hallazgos

## Método

1. Inventariar dependencias directas (y transitivas críticas si el manifest lo permite).
2. Por cada dep relevante al stack Must o con historial de CVE:
   - WebSearch: `"{package} security advisory"` / `"{package} CVE"`
   - WebSearch: `"{package} end of life"` / `"{package} LTS"`
   - WebFetch: npm/PyPI/NuGet, GitHub security advisories, docs oficiales
3. Comparar versión instalada vs última estable/LTS documentada.
4. Clasificar:
   - **CVE crítica/alta** — con ID y URL advisory
   - **EOL** — sin parches de seguridad
   - **Desactualizada** — varias majors detrás (Should)
   - **OK** — dentro de política del stack
5. Escribir `03-calidad/dependency-health.md`.
6. Registrar cada claim en `sources-ledger.md` (url, fecha_fetch, claim).

## Salida mínima dependency-health.md

| Dependencia | Versión actual | Última estable/LTS | Estado | CVE/EOL | Fuente | fecha_fetch |
|-------------|----------------|-------------------|--------|---------|--------|-------------|
| next | 14.1.0 | 15.x (ver ledger) | Desactualizada | — | nextjs.org/docs | 2026-07-18 |

## Resumen ejecutivo deps

- Críticas: N
- Altas: N
- Desactualizadas (no CVE): N
- OK: N

## Reglas

- Sin WebSearch/WebFetch → no marcar CVE ni EOL (estado "no verificado").
- No ejecutar `npm audit` como única fuente; corroborar advisory oficial.
- No actualizar dependencias aquí → OPP + handoff.
- Secretos en repo (.env commiteado, API keys) → OPP severidad Crítica (evidencia path).

## OPP típicas

- CVE alta en dep de producción
- Runtime/framework EOL
- Lockfile ausente o inconsistente
- Dependencia sin uso (dead dependency) — evidencia: no imports
