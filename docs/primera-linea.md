# Agentes de primera línea

Estos son los agentes con los que **hablas directamente en el chat** de Cursor. Cada uno orquesta skills y subagentes internos; no necesitas invocar los internos salvo casos especiales.

## Mapa de agentes

```mermaid
flowchart TB
    subgraph primera_linea["Primera línea (hablas con ellos)"]
        scrum["agent-scrum"]
        evolucion["agent-evolucion"]
        ideador["agent-investigador-ideador"]
        impl["agent-implementador"]
        impl_epi["agent-implementador-epicas"]
        verif["agent-verificador"]
        auditor["agent-auditor-oportunidades"]
        refactor["agent-refactor-malas-practicas"]
    end

    subgraph internos["Internos (orquestados)"]
        arq["agent-arquitecto-hu"]
        scout["agent-research-scout"]
        adv["agent-debate-advocate"]
        skep["agent-debate-skeptic"]
        fit["agent-debate-fit"]
    end

    scrum --> impl
    evolucion --> impl
    ideador --> scout
    ideador --> adv
    ideador --> skep
    ideador --> fit
    impl_epi --> impl
    impl --> arq
    impl --> verif

    style scrum stroke-width:3px
    style evolucion stroke-width:3px
    style ideador stroke-width:3px
    style impl stroke-width:3px
    style impl_epi stroke-width:3px
    style verif stroke-width:3px
    style auditor stroke-width:3px
    style refactor stroke-width:3px

    style arq stroke-dasharray: 5 5
    style scout stroke-dasharray: 5 5
    style adv stroke-dasharray: 5 5
    style skep stroke-dasharray: 5 5
    style fit stroke-dasharray: 5 5
```

**Línea sólida** = primera línea. **Línea punteada** = internos (el orquestador los lanza; tú no tienes que llamarlos).

---

## Primera línea

| Agent | Cuándo usarlo | Qué hace |
|-------|---------------|----------|
| **agent-scrum** | Idea nueva, producto greenfield | Discovery guiado → épicas MoSCoW → HU INVEST (AC + BDD) → arquitectura → stack. No codea. |
| **agent-evolucion** | Producto existente (brownfield) | Inventario as-is → brecha → backlog **delta** (épicas/HU nuevas). No codea. |
| **agent-investigador-ideador** | "¿Cómo implementar X?", comparar enfoques | Escanea repo, investiga con web, debate opciones, entrega reporte (#1 + #2). Readonly. |
| **agent-implementador** | Una sola HU | Pipeline I0–I9: craft gate, arch-brief, plan, código en slices, evidencia AC/BDD. |
| **agent-implementador-epicas** | Toda una épica | Orquesta HU por HU vía subagentes implementador; build+test tras cada HU. |
| **agent-verificador** | Tras implementación o antes de marcar done | Escéptico: tests, AC Must, craft gate. Veredicto PASS/FAIL con evidencia. Readonly. |
| **agent-auditor-oportunidades** | Health check, pre-release, deuda | Audita NFR, tests, deps/CVE, craft → fichas OPP-* priorizadas. No codea. |
| **agent-refactor-malas-practicas** | Olores de diseño, plan de refactor | Reporte Markdown priorizado bajo `03-calidad/refactor/`. No implementa salvo petición explícita. |

---

## Internos (referencia breve)

| Agent | Rol |
|-------|-----|
| **agent-arquitecto-hu** | Fase I3: escribe `arch-brief-{HU}.md` vinculante (patrones, seams, anti-patrones). Excepción: puedes pedir solo briefing sin implementar. |
| **agent-research-scout** | Búsqueda de libs, patrones y docs oficiales (lanzado por investigador-ideador). |
| **agent-debate-advocate** | Argumenta a favor de una opción candidata. |
| **agent-debate-skeptic** | Riesgos, costos ocultos, "por qué no". |
| **agent-debate-fit** | Encaje con stack y código as-is del repo. |

---

## Si quieres… usa…

| Objetivo | Agent |
|----------|-------|
| Convertir una idea en backlog Scrum completo | `agent-scrum` |
| Agregar o cambiar features en producto existente | `agent-evolucion` |
| Investigar la mejor forma técnica sin tocar código | `agent-investigador-ideador` |
| Implementar **una** historia de usuario | `agent-implementador` |
| Implementar **todas** las HU de una épica | `agent-implementador-epicas` |
| Confirmar que algo está realmente hecho | `agent-verificador` |
| Auditar salud del proyecto antes de release | `agent-auditor-oportunidades` |
| Plan de refactor / malas prácticas | `agent-refactor-malas-practicas` |
| Solo briefing arquitectónico de una HU | `agent-arquitecto-hu` (o pide briefing dentro de implementador) |

---

## Prompts de ejemplo

### Greenfield (idea → backlog → implementación)

```
Usa agent-scrum: convierte esta idea en backlog Scrum (modo guiado completo):
[describe tu producto]
```

Tras backlog aprobado:

```
Usa agent-implementador: implementa HU-001 del proyecto [nombre].
```

Tras implementación:

```
Usa agent-verificador: valida HU-001 — no aceptes claims sin evidencia.
```

Para una épica entera:

```
Usa agent-implementador-epicas: implementa la épica EP-001 (todas las HU Must).
```

### Brownfield (producto existente)

```
Usa agent-evolucion: evoluciona este producto — quiero agregar [feature].
Hay código existente. Modo guiado.
```

Si necesitas investigar antes de decidir:

```
Usa agent-investigador-ideador: investiga la mejor forma de agregar autenticación OAuth
a este repo. Entrega reporte con opción #1 y #2. No toques código.
```

Luego implementación con el delta generado por evolución.

### Calidad y mantenimiento

```
Usa agent-auditor-oportunidades: audita oportunidades de mejora en el proyecto.
Modo completo. Foco seguridad y tests.
```

```
Usa agent-refactor-malas-practicas: escanea el módulo src/api y genera plan de refactor
priorizado. Solo reporte, no implementes.
```

```
Usa agent-verificador: pre-release check — valida que EP-002 está done con evidencia.
```

### Solo arquitectura (sin código)

```
Usa agent-arquitecto-hu: genera arch-brief para HU-005 — patrones, seams y anti-patrones.
No implementes código.
```

---

## Flujos típicos

### Greenfield

1. **agent-scrum** — discovery, épicas, HU, arquitectura, stack
2. (Opcional) **agent-investigador-ideador** — si hay dudas técnicas grandes antes de implementar
3. **agent-implementador** o **agent-implementador-epicas** — código HU por HU
4. **agent-verificador** — tras cada HU o al cerrar épica
5. (Opcional) **agent-auditor-oportunidades** — health check pre-release

### Brownfield

1. **agent-evolucion** — inventario, brecha, backlog delta
2. (Opcional) **agent-investigador-ideador** — debate de enfoques para el cambio
3. **agent-implementador** / **agent-implementador-epicas** — implementación del delta
4. **agent-verificador** — validación escéptica
5. (Opcional) **agent-refactor-malas-practicas** — si el cambio expuso deuda en el área tocada

---

## Notas

- Idioma por defecto: **español** en artefactos y preguntas.
- Los agentes de implementación **no commitean** salvo que lo pidas explícitamente.
- Para skills de tu stack (Next.js, .NET, etc.), genera las tuyas con `stack-skill-generator` en el proyecto; este plugin no incluye skills de stack de terceros.
