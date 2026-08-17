# Freshness Guard — referencia

## Queries útiles

```text
{tech} official documentation
{tech} release notes
{tech} LTS version site:docs.
{tech} deprecation
{package} site:npmjs.com
{package} site:pypi.org
```

## Template fila ledger

| fecha_fetch | tech | url | claim_soportado | deprecations | allowlist OK |
|-------------|------|-----|-----------------|--------------|--------------|
| 2026-07-16T21:00:00-05:00 | PostgreSQL | https://www.postgresql.org/docs/ | Stable major documentado en docs oficiales | (si hay) | sí |

## Quién debe invocar

- `stack-advisor` (siempre)
- `architecture-documenter` (antes de nombres tech)
- Orquestador en `refresh-tech`
- Cualquier skill que cite versión/API
