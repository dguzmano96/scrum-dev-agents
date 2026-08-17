---
name: requirements-elicitor
description: >-
  Elicits product requirements with AskQuestion batches, Example Mapping, and
  assumption tracking for Scrum discovery. Use when clarifying ambiguities,
  validating assumptions, Example Mapping, or supporting guided-discovery-wizard.
---

# Requirements Elicitor

Complementa el wizard con profundidad de elicitation.

## Cuándo

- Gaps en completeness gate
- Usuario elige “Profundizar”
- Aparecen contradicciones o términos sin glosario
- Hay `[POR VALIDAR]` bloqueantes

## Método

1. **Example Mapping** por capacidad crítica:
   - Historia/regla (amarillo)
   - Ejemplos (verde)
   - Preguntas abiertas (rojo)
2. Convertir preguntas rojas → AskQuestion (lote temático).
3. Registrar:
   - HECHOS en brief/personas/glosario
   - Decisiones en `decisions-log.md`
   - Supuestos en `supuestos.md` con etiqueta `BLOQUEANTE` o `NO BLOQUEANTE`
4. Si usuario dice “asume X” → decisión explícita en supuestos + decisions-log (ya no bloqueante salvo que diga lo contrario).

## Reglas AskQuestion

- Lotes 5–12, un tema por lote
- Opciones cerradas cuando el dominio lo permita
- Explicitar impacto en backlog
- No mezclar auth con billing en el mismo lote si confunde

## Stop

Devolver control cuando no queden bloqueantes y el tema profundizado esté confirmado.
