# Agentes de primera línea

Estos son los **agentes que tú llamas en el chat** de Cursor. Cada uno orquesta skills y otros agentes por detrás; en el día a día no necesitas invocar a los que trabajan en segundo plano.

> **Guía principal:** el [README](../README.md) explica instalación, recetas típicas (app nueva vs app existente), los 8 especialistas con prompts copiables, y por qué el pack no es “otro chatbot” (skills de tu stack, docs al día, verificación escéptica, tarjetas de mejora, etc.).

## Mapa de agentes

```mermaid
flowchart TB
    subgraph primera_linea["Tú los llamas en el chat"]
        scrum["agent-scrum"]
        evolucion["agent-evolucion"]
        ideador["agent-investigador-ideador"]
        impl["agent-implementador"]
        impl_epi["agent-implementador-epicas"]
        verif["agent-verificador"]
        auditor["agent-auditor-oportunidades"]
        refactor["agent-refactor-malas-practicas"]
    end

    subgraph internos["Otros agentes los llaman solos"]
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

**Línea sólida** = los que tú invocas. **Línea punteada** = los que el orquestador lanza por ti.

---

## Primera línea

| Agent | Cuándo usarlo | Qué hace |
|-------|---------------|----------|
| **agent-scrum** | Idea nueva, producto desde cero | Discovery guiado → épicas → HU bien escritas (criterios de aceptación + escenarios Given/When/Then por separado) → arquitectura → stack. No codea. |
| **agent-evolucion** | Producto existente | Inventario de lo que hay → brecha del cambio → backlog **solo con lo nuevo** (épicas/HU nuevas o que reemplazan). No codea. |
| **agent-investigador-ideador** | "¿Cómo implementar X?", comparar enfoques | Escanea repo, investiga con web, debate opciones, entrega reporte (#1 + #2). Solo lectura. |
| **agent-implementador** | Una sola HU | Chequeo de diseño → briefing arquitectónico → plan → código en trozos → evidencia de criterios de aceptación. |
| **agent-implementador-epicas** | Toda una épica | Coordina una HU tras otra vía subagentes; build+test tras cada una. |
| **agent-verificador** | Tras implementación o antes de marcar done | Escéptico: tests, criterios obligatorios, chequeo de diseño. PASS/FAIL con evidencia. Solo lectura. |
| **agent-auditor-oportunidades** | Health check, pre-release, deuda | Audita NFR, tests, dependencias, calidad → tarjetas de mejora priorizadas. No codea. |
| **agent-refactor-malas-practicas** | Olores de diseño, plan de refactor | Reporte Markdown priorizado bajo `03-calidad/refactor/`. No implementa salvo petición explícita. |

---

## Los que trabajan detrás (referencia breve)

| Agent | Rol |
|-------|-----|
| **agent-arquitecto-hu** | Escribe `arch-brief-{HU}.md` vinculante (patrones, límites, anti-patrones) antes de codear. Excepción: puedes pedir solo briefing sin implementar. |
| **agent-research-scout** | Búsqueda de libs, patrones y docs oficiales (lanzado por investigador-ideador). |
| **agent-debate-advocate** | Argumenta a favor de una opción candidata. |
| **agent-debate-skeptic** | Riesgos, costos ocultos, "por qué no". |
| **agent-debate-fit** | Encaje con stack y código actual del repo. |

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

### App nueva (idea → backlog → implementación)

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

### App existente (producto con código)

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

### App nueva

1. **agent-scrum** — discovery, épicas, HU, arquitectura, stack
2. (Opcional) **agent-investigador-ideador** — si hay dudas técnicas grandes antes de implementar
3. **agent-implementador** o **agent-implementador-epicas** — código HU por HU
4. **agent-verificador** — tras cada HU o al cerrar épica
5. (Opcional) **agent-auditor-oportunidades** — health check pre-release

### App existente

1. **agent-evolucion** — inventario, brecha, backlog delta
2. (Opcional) **agent-investigador-ideador** — debate de enfoques para el cambio
3. **agent-implementador** / **agent-implementador-epicas** — implementación del delta
4. **agent-verificador** — validación escéptica
5. (Opcional) **agent-refactor-malas-practicas** — si el cambio expuso deuda en el área tocada

---

## Notas

- Idioma por defecto: **español** en artefactos y preguntas.
- Los agentes de implementación **no commitean** salvo que lo pidas explícitamente.
- Para skills de tu stack (Next.js, .NET, etc.), el pack las genera en tu proyecto al elegir tecnologías; no trae guías de terceros embebidas.
