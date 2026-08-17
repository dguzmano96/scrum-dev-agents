---
name: change-impact-gate
description: >-
  Classifies change impact (Local, Module, Breaking, Architecture/stack) and
  forces STOP+AskQuestion before delta Must stories. Use in E10 of scrum-evolution
  or when brownfield changes may break contracts.
---

# Change Impact Gate (E10)

Verify with official docs via WebSearch/WebFetch before recommending; record sources.

## Niveles

| Nivel | Ejemplos | Acción |
|-------|----------|--------|
| Local | copy UI, validación local, bugfix acotado | Continuar |
| Módulo | endpoint interno nuevo, tabla no compartida | AskQuestion resumen |
| Breaking | API pública, schema compartido, auth, migración, dep mayor | STOP + AskQuestion |
| Arquitectura/stack | nueva DB/servicio, cambiar framework | STOP + `freshness-guard` + posible `stack-advisor` + AskQuestion |

## Método

1. Leer gap E2 + discovery delta aprobado (E9) + codebase-map.
2. Clasificar nivel (si duda → subir nivel).
3. Si Breaking/Arquitectura: AskQuestion con template `scrum-evolution/templates/impact-ask.md`.
4. Opciones tipicas: aprobar impacto / reducir alcance / spike SPK / abortar.
5. Registrar en `00-discovery/decisions-log.md`.
6. Si Arquitectura/stack aprobado: invocar `freshness-guard`; `stack-advisor` solo si hace falta reevaluar stack.
7. Si se **agrega** lenguaje/framework/servicio a `stack.md`: invocar `stack-skill-generator`
   para crear `{proyecto}/.cursor/skills/stack-{slug}/` (WebSearch/WebFetch obligatorio).
8. Bloquear E11 Must breaking hasta decisión.

## Reglas

- Sin decisión usuario en Breaking/Arquitectura → no documentar como Must.
- Spikes vía `spike-creator` si eligen opción 3.
