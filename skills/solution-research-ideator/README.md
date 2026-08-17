# Solution Research Ideator

Orquestador global del **Agente Investigador/Ideador**.

## Instalación

Viene en el pack de agentes Cursor (`skills/solution-research-ideator/` + hermanas + agents + rule).

## Invocación

```text
Investiga la mejor forma de {pedido} en este proyecto. Modo completo.
```

## Pipeline

R0 BRIEF → R1 SCAN → R2 RESEARCH → R3 CANDIDATES → R4 DEBATE → R5 SCORE → R6 REPORT → R7 SELECT → R8 HANDOFF

## Skills hermanas

| Skill | Fase |
|-------|------|
| `tech-research-scout` | R2 |
| `solution-debate-panel` | R4–R5 |
| `solution-report-writer` | R6 |
| `codebase-inventory` | R1 |
| `freshness-guard` | R2+ |

## Subagentes

`agent-research-scout`, `agent-debate-advocate`, `agent-debate-skeptic`, `agent-debate-fit`
