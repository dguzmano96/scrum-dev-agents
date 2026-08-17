# Referencia rápida — Epic Implementer

## Templates

Ver `templates/`:

- `epic-progress.md`
- `decision-ask-epic.md`

## Progress file path

`{proyecto}/04-sesion/epic-{EP-ID}-progress.md`

Ejemplo: `mi-app/04-sesion/epic-EP-001-progress.md`

## Mapa skill → fase

| Fase | Skill |
|------|--------|
| Epi0 | epic-implementer (orquestador) |
| Epi1 | hu-context-loader + backlog-consistency-auditor (opcional) |
| Epi2 | epic-implementer (AskQuestion cola + modo + build) |
| Epi3 | `Task` → subagente `agent-implementador` → `hu-implementer` (I0–I9) |
| Epi4 | epic-implementer (build + test) |
| Epi5 | impl-doc-sync (auto, alcance limitado) |
| Epi6 | epic-implementer (gate de bloqueo) |
| Epi7 | epic-implementer (resume) |
| Epi8 | epic-implementer (handoff) |

## Detección de build+test (orden)

1. `package.json` (npm/pnpm/yarn según lockfile)
2. `pyproject.toml` / `setup.py` (pytest/poetry/hatch)
3. `Cargo.toml` (cargo)
4. `pom.xml` / `build.gradle` / `build.gradle.kts` (mvn / gradle)
5. `Makefile` (targets build/test)
6. `go.mod` (go)
7. `.csproj` / `.sln` (dotnet)
8. Ambiguo → AskQuestion
9. No hay → AskQuestion: omitir build / omitir test / abortar

## STOP triggers (cuándo parar la épica)

- `impl-decision-gate` clasifica `needs-user` o `needs-scrum-update` (dentro del subagente).
- Contradicción o dependencia circular en Epi1.
- Build o test rojo en Epi4.
- AC Must sin evidencia en alguna HU (Epi6).
- Falta artefacto crítico (HU, EPIC, stack, AC).
- Drift de arquitectura/stack detectado por `impl-impact-scanner` (I8 dentro del subagente).

Cuando el subagente devuelve `blocked` con señal STOP, el orquestador construye el AskQuestion enriquecido (técnica + no técnica + impacto + soluciones) y no lanza otro subagente hasta respuesta. Tras respuesta, reanuda el mismo subagente vía `Task` con `resume`.

## Comandos de control (Epi7)

- `pausar` — detener loop, guardar progress.
- `continuar` — retomar desde la HU actual.
- `reabrir desde HU-00X` — retomar desde una HU específica.
- `saltar HU-00X` — saltar con confirmación AskQuestion.
- `refresh-tech` — revalidar stack antes de continuar.
