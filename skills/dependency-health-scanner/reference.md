# Referencia — Dependency Health Scanner

## Fuentes allowlist (vía freshness-guard)

1. GitHub Advisory Database / repo Security tab
2. npmjs.com/advisories, PyPI, NuGet audit docs
3. CVE databases oficiales (NVD) — corroborar con vendor
4. Release notes del proyecto upstream
5. Docs oficiales del runtime (Node LTS, .NET support policy, etc.)

## Comandos locales (opcional, no sustituyen web)

Si el entorno lo permite y el usuario no bloqueó terminal:

- `npm audit --json` / `dotnet list package --vulnerable`
- `pip audit` / `cargo audit`

Siempre corroborar hallazgos con advisory URL en ledger.

## Severidad CVE

| Nivel | Acción OPP |
|-------|------------|
| Crítica/Alta en dep runtime o expuesta | OPP Crítica, handoff urgente |
| Media | OPP Alta |
| Baja / dev-only | OPP Media o Baja según exposición |
