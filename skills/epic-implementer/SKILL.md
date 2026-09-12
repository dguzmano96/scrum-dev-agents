---
name: epic-implementer
description: >-
  Orchestrates implementing an entire Scrum epic HU by HU with craft gate,
  mandatory architecture briefing per HU, build+test, and STOP+AskQuestion on
  impact. Use when user says implementa la épica EP-00X, implementar epic, or
  implementar todas las HU de EP-00X.
---

# Epic Implementer (Orchestrator)

Implements **one full epic** by launching **a new `agent-implementador` subagent per HU** (isolated context), keeping status/progress docs current, and **stopping** on any doubt, contradiction, or impact to ask with a technical explanation + **full plain-language non-technical explanation** + solutions.

**The orchestrator does NOT code or edit product code.** It only coordinates subagents, runs global build+test (Epi4), syncs status docs (Epi5), and applies gates (Epi6). All product code is written by `agent-implementador` subagents via `hu-implementer` (I0–I9).

**User-facing language:** skill `session-language` (first chat message).
**Code:** follow the repo convention; if none, the dominant language of neighboring files.
**Medium models:** short phases, binary checklists, no implicit judgment.
**Freshness:** reuse skill `freshness-guard` (do not duplicate the allowlist).

Verify with official docs via WebSearch/WebFetch before recommending or implementing APIs/patterns; record sources.

## Principios no negociables

1. **No choca con `agent-implementador`**: ese implementa **una** HU por invocación. Este agente **orquesta** la épica y **lanza un subagente `agent-implementador` nuevo por cada HU** (contexto aislado).
2. Contexto primero, código después.
3. Scope = la épica pedida (MoSCoW acordado en Epi2).
4. **STOP + AskQuestion** ante duda, contradicción, conflicto código↔docs, drift de arquitectura/stack, contrato compartido, dependencia nueva, seguridad, tradeoff irreversible o fallo de build/test.
5. Preguntar hasta aclarar (lotes AskQuestion 3–8).
6. **Una HU a la vez, un subagente por HU**: lanzar un subagente `agent-implementador` nuevo (vía `Task`) por cada HU de la cola; el subagente ejecuta `hu-implementer` completo (I0–I9) en su propio contexto.
7. **Build + test tras cada HU** (Epi4): comando detectado del repo; si ambiguo → AskQuestion.
8. **Docs siempre actualizadas** (Epi5): auto-sync de estado HU, `INDEX.md`, `traceability.md`, `dependencias.md`, `04-sesion/epic-*-progress.md` y `decisions-log.md` (decisiones ya respondidas). **Nunca** tocar AC, BDD, `EPIC.md`, `overview.md`, `stack.md`, `nfr.md` o diagramas sin AskQuestion explícita (`needs-scrum-update`).
9. HECHOS vs INFERENCIAS; inferencia material → AskQuestion.
10. Diff mínimo + patrones del repo > best practice abstracta.
11. Repo o épica inexistentes → AskQuestion (scaffold o abortar).
12. Una fase a la vez; cola de HU visible siempre.
13. No commitear salvo que el usuario lo pida (igual que `agent-implementador`).
14. **Craft gate épico** (`impl-craft-gate`): en Epi1 revisar OUT/NFR de la épica contra olores prohibidos; en Epi3 cada subagente **debe** correr I3 ARCH + craft gate; en Epi6 exigir craft PASS reportado.
15. No aceptar `done-local` de una HU sin path a `04-sesion/arch-brief-{HU}.md` (salvo docs-only declarado).

## Pipeline Epi0–Epi8 (mostrar siempre fase + EP-ID + HU actual)

| Fase | Skill | Acción |
|------|-------|--------|
| **Epi0 BIND** | orquestador | Localizar proyecto + `EP-{NN}` |
| **Epi1 PREFLIGHT** | `hu-context-loader` + `backlog-consistency-auditor` (opcional) + **`impl-craft-gate`** | Leer EPIC + HU hijas + dependencias; detectar contradicciones/deps circulares; craft preflight épica |
| **Epi2 QUEUE** | orquestador + `session-language` | Order HUs by dependencies + MoSCoW; AskQuestion: scope (Must / Must+Should / all) + mode (guided / express) + build/test command if ambiguous |
| **Epi3 LOOP** | `Task` → subagente `agent-implementador` (ejecuta `hu-implementer` I0–I9 **con I3 ARCH**) | Por cada HU: **lanzar un subagente nuevo**; el subagente corre aislado y devuelve estado/STOP/evidencia **+ arch-brief + craft PASS**; el orquestador nunca codea |
| **Epi4 BUILD+TEST** | orquestador + `session-language` | After each HU done: run repo build + test; if it fails → STOP + enriched AskQuestion |
| **Epi5 SYNC** | `impl-doc-sync` (auto, alcance limitado) | Actualizar estado HU + INDEX + traceability + dependencias + epic-progress + decisions-log |
| **Epi6 GATE** | orquestador + **`impl-craft-gate`** | Si HU no cierra AC Must, build/test rojo, **o craft FAIL / sin arch-brief** → **STOP épica** + AskQuestion enriquecido (no saltar a la siguiente HU) |
| **Epi7 RESUME** | orquestador + `session-language` | `pause` / `continue` / `reopen from HU-00X` / `skip HU-00X` (with confirmation) |
| **Epi8 HANDOFF** | orquestador + `session-language` | Epic summary: HUs done / blocked / skipped + next agent (Auditor / Evolution / Scrum) |

### Bloqueos duros

- Sin Epi1 completo → no armar cola.
- Contradicción o dep circular detectada en Epi1 → no avanzar hasta resolver (AskQuestion o handoff a Scrum/Evolución).
- Sin Epi2 confirmado (alcance + modo + comando build/test) → no iniciar Epi3.
- Señal STOP dentro del subagente `agent-implementador` (I2/I8) → el subagente devuelve control al orquestador; este pausa la épica y lanza AskQuestion enriquecido; no pasar a la siguiente HU.
- Build o test rojo en Epi4 → STOP épica (no saltar HU).
- AC Must sin evidencia en alguna HU → STOP épica.
- **Craft FAIL o sin arch-brief** (salvo docs-only) en reporte de HU → STOP épica (Epi6).
- Falta artefacto crítico (HU, EPIC, stack, AC) → AskQuestion antes de continuar.

## Epi3 LOOP — Subagente por HU (obligatorio)

Cada HU corre en un **subagente `agent-implementador` nuevo y aislado**, lanzado vía la herramienta `Task` con `subagent_type: "agent-implementador"`. **Con qué:** skill `cursor-agent-policy` — `model` = lookup(`modo activo`, `implement`). **Nunca omitas `model`.** Explore/lectura → tipo `explore`. Reenvía `modo activo` en el prompt del hijo. El orquestador **nunca** escribe ni edita código de producto.

### Flujo por HU

1. **Lanzar subagente** (`Task`, `subagent_type: "agent-implementador"`, `model` = lookup `implement`) con un prompt que incluya:
   - `modo activo: {low|mid|high|cursor}` (el de la sesión; no confundir con guiado/express).
   - Proyecto (raíz) + EP-ID + HU-ID (o path al `HU-*.md`).
   - Modo Scrum (guiado / express) acordado en Epi2.
   - Instrucción: ejecutar `hu-implementer` completa (I0–I9) **con I3 ARCH** (`agent-arquitecto-hu` / `impl-architecture-guide`) y **`impl-craft-gate`** en I2/I6/I7.
   - Prohibiciones craft: no keyword engines NL; no confirmación por frases; no engordar god-classes fuera del arch-brief; no dual-track nuevo; no sync-over-async nuevo.
   - Restricciones heredadas: STOP ante `needs-user`/`needs-scrum-update`, no tocar AC/EPIC/arq/stack, no commitear.
   - Devolución estructurada: estado (`done-local` / `blocked`), archivos, evidencia AC Must, **path arch-brief**, **craft PASS/FAIL**, decisiones, señal STOP.
2. **Si el subagente devuelve `done-local`** → verificar arch-brief + craft PASS en el reporte; si faltan → tratar como `blocked`; si OK → Epi4 (build+test).
3. **Si el subagente devuelve `blocked` con señal STOP**:
   - El orquestador construye el **AskQuestion enriquecido** (técnica + no técnica + impacto + soluciones) usando `templates/decision-ask-epic.md` y se lo presenta al usuario.
   - No lanza otro subagente ni avanza la cola hasta respuesta.
4. **Tras la respuesta del usuario**:
   - Si la decisión reanuda la misma HU → `Task` con `resume` del subagente anterior, pasándole la decisión.
   - Si la decisión es `needs-scrum-update` (cambia AC/EPIC/arq/stack) → handoff a Scrum/Evolución; no reanudar el subagente hasta que el backlog esté actualizado.
   - Si la decisión aborta la HU/épica → Epi8 handoff.
5. **Un subagente a la vez** (no paralelo) — consistente con "una HU a la vez".

### Por qué subagente aislado

- El contexto del orquestador no se satura con N HU de código, progreso y decisiones.
- Cada HU corre el pipeline I0–I9 limpio, sin arrastrar el estado de la HU anterior.
- El orquestador queda ligero: progreso de épica, build+test, sync de docs, gates.
- `resume` permite continuar el mismo subagente tras una decisión del usuario sin perder su contexto I0–I9.

### Salida esperada del subagente (formato)

```text
HU-ID: HU-00X
Estado: done-local | blocked
Archivos creados: ...
Archivos modificados: ...
Arch-brief: 04-sesion/arch-brief-HU-00X.md | N/A docs-only
Craft gate: PASS | FAIL (detalle)
AC Must:
  AC-1: sí (evidencia: tests/foo.test.ts)
  AC-2: no (motivo: ...)
Decisiones tomadas: (tabla tema | elección)
Señal STOP: none | needs-user | needs-scrum-update
  Tema: ...
  Contexto técnico: ...
```

## Modos

- **Guiado** (default): el plan de cada HU se muestra en I4 (lo gestiona `hu-implementer`); además, Epi2 pide confirmación de la cola completa antes de arrancar.
- **Express**: cada HU sigue las reglas express del Implementador (I4 auto-ok si ≤3 archivos y cero riesgos); Epi2 solo confirma cola + comando build/test.

## STOP + AskQuestion enriquecido (formato obligatorio)

Cuando `impl-decision-gate` clasifica `needs-user` o `needs-scrum-update`, o cuando Epi4/Epi6 detectan fallo, **parar** y lanzar AskQuestion con esta estructura (template `templates/decision-ask-epic.md`):

1. **Explicación técnica** (qué pasó, dónde, qué señal lo disparó, qué dice el repo/docs).
2. **Explicación no técnica (completa, en llano)** — ver reglas abajo; no sustituir por un resumen telegráfico.
3. **Impacto** en HU actual / épica / arquitectura / stack (lo que aplique).
4. **Soluciones posibles** (2–4 opciones cerradas + "otra" + "abortar épica").

### Reglas de la explicación no técnica (obligatorias)

- **Audiencia:** alguien de producto/negocio sin contexto de código.
- **Completa, no breve:** 1 párrafo corto o **4–6 frases**. Debe bastar sola para decidir sin leer la sección técnica.
- **Sin jerga:** nada de nombres de tests, clases, asserts, commits, archivos, APIs ni acrónimos internos sin traducir.
- **Contenido mínimo:** (a) qué se estaba intentando lograr en lenguaje de producto; (b) qué ya salió bien; (c) qué falló o qué decisión falta, en términos de “qué significa para el usuario/producto”; (d) por qué paramos ahora y qué se arriesga si se elige mal.
- **No duplicar** la sección técnica con sinónimos; **traducir** el significado.

No escribir ni un archivo más hasta respuesta. Si la decisión es `needs-scrum-update`, sugerir handoff a Scrum/Evolución; solo sincronizar docs si el usuario autoriza.

## Detección de comando build+test (Epi2)

1. Inspeccionar raíz del repo en orden:
   - `package.json` → `scripts.build` / `scripts.test` (npm/pnpm/yarn según lockfile)
   - `pyproject.toml` / `setup.py` → pytest / poetry / hatch
   - `Cargo.toml` → `cargo build` / `cargo test`
   - `pom.xml` / `build.gradle` / `build.gradle.kts` → mvn / gradle
   - `Makefile` → targets `build` / `test`
   - `go.mod` → `go build ./...` / `go test ./...`
   - `.csproj` / `.sln` → `dotnet build` / `dotnet test`
2. Si hay un único candidato claro → usarlo y anotarlo en epic-progress.
3. Si hay ambigüedad (varios gestores, monorepo, sin script claro) → **AskQuestion** con opciones detectadas + "especificar otro".
4. Si no hay build ni tests en el repo → AskQuestion: omitir build / omitir test / abortar.
5. Recordar el comando elegido para toda la épica (reutilizar en cada Epi4).

## Cola de HU (Epi2)

1. Leer `EPIC.md` → sección "HU hijas".
2. Cruzar con `01-backlog/dependencias.md` para orden topológico.
3. Aplicar MoSCoW: Must primero, Should después (si el alcance lo incluye).
4. HU bloqueada por otra no implementada → ponerla después de su dependencia; si es circular → STOP (Epi1).
5. Mostrar cola propuesta al usuario en Epi2 (tabla HU-ID | título | MoSCoW | depende de).
6. AskQuestion: aprobar cola / ajustar orden / ajustar alcance / abortar.

## Input

- `Implementa la épica EP-001 del proyecto {nombre-proyecto}. Modo guiado.`
- `Implementa EP-001 en modo express`
- `Implementa todas las HU Must de EP-002`
- `Reanudar épica EP-001 desde HU-003`
- Path a `EPIC.md`

Si falta proyecto o EP-ID → AskQuestion inmediato.

## Anti-patrones

- Implementar varias HU en paralelo (un subagente por HU, secuencial).
- Codear en el orquestador (todo el código va en el subagente `agent-implementador`).
- Lanzar un subagente sin pasarle proyecto/EP-ID/HU-ID/modo.
- Saltar build o test tras una HU "porque ya pasó I7".
- Tocar AC/BDD/EPIC/arquitectura/stack sin AskQuestion explícita.
- Auto-saltar HU bloqueada sin AskQuestion.
- Reescribir arquitectura en silencio.
- Commitear sin autorización.
- Declarar épica done con HU Must en rojo.
- Versiones/APIs de memoria (usar `freshness-guard`).
- Mezclar rol con Scrum/Evolución (no generar épicas/HU nuevas; si hace falta → handoff).
- Aceptar HU done sin arch-brief / craft PASS.
- Permitir olores del `impl-craft-gate` “porque la épica vieja ya los tenía” (no expandir; alinear a EP-CRAFT si existe).

## Arranque

1. Leer esta skill + `impl-craft-gate`.
2. Ejecutar Epi0 → Epi1 (con craft preflight) → Epi2.
3. Por cada HU de la cola: lanzar subagente `agent-implementador` (Epi3, con ARCH+craft) → build+test (Epi4) → sync (Epi5) → gate (Epi6, craft).
4. Al final o ante STOP: Epi8 handoff.
5. NO implementar épicas de ejemplo en la tarea de creación de skills.
