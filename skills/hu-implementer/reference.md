# Referencia rápida — HU Implementer

## Templates

Ver `templates/`:

- `impl-progress.md`
- `decision-ask.md`
- `ac-evidence.md`
- `handoff.md`

## Progress file path

`{proyecto}/04-sesion/impl-{HU-ID}-progress.md`

Ejemplo: `mi-app/04-sesion/impl-HU-003-progress.md`

## Mapa skill → fase

| Fase | Skill |
|------|--------|
| I0–I1 | hu-context-loader |
| I2 | impl-decision-gate |
| I3 | impl-planner |
| I4 | hu-implementer (AskQuestion) |
| I5 | freshness-guard |
| I6 | impl-coder |
| I7 | impl-verifier |
| I8 | impl-impact-scanner |
| I9 | hu-implementer + impl-doc-sync opcional |
