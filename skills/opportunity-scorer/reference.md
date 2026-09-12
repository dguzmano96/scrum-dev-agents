# Referencia — Opportunity Scorer

## Desempate (mismo score)

1. Mayor severidad documentada
2. Mayor confianza en evidencia
3. Menor esfuerzo (quick wins)
4. Dependencia: OPP que desbloquea otras primero

## Mapeo agente siguiente

| Señal en OPP | Agente |
|--------------|--------|
| Cambio de alcance, módulo nuevo, breaking | `scrum-evolution` |
| HU existente con gap de implementación/tests | `story-implementer` |
| Falta discovery/NFR/backlog base | `scrum-idea-to-backlog` |
| Solo bump de dependencia acotada | `story-implementer` o spike HU |

## Ejemplo score

| OPP | Impacto | Urgencia | Esfuerzo | Riesgo | Confianza | Score |
|-----|---------|----------|----------|--------|-----------|-------|
| CVE alta en dep directa | 5 | 5 | 2 | 5 | 5 | ~85 |
| Copy UI inconsistente | 2 | 1 | 1 | 1 | 4 | ~35 |
