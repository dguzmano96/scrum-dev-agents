---
name: guided-discovery-wizard
description: >-
  Runs guided discovery wizard phases W0–W7 for Scrum backlog creation: mode
  selection, elicitation batches, phase confirmations, completeness gate, and
  Discovery Summary. Use with scrum-idea-to-backlog, when starting product
  discovery, or when user says wizard guiado, completeness gate, or retomar fase.
---

# Guided Discovery Wizard (W0–W7)

Ejecuta discovery guiado. **No** genera épicas ni stack (delega a otras skills).

Persistir en `00-discovery/` y `04-sesion/`. Ver bank de preguntas en `reference.md`.
Usar templates de `scrum-idea-to-backlog/templates/` cuando aplique.

## Técnicas

- Process tracing (“cuéntame el último flujo de punta a punta”)
- 5 whys suave (sin interrogar de más)
- Cuantificar vaguedades: “rápido” → p95 latency objetivo; “seguro” → auth/roles/datos

## Fases

### W0 — Briefing + modo

AskQuestion corto:

- Guiado completo / Express / Retomar
- Nombre del proyecto (slug)
- Idea inicial (si no vino en el mensaje)

Crear/actualizar `04-sesion/wizard-progress.md`.

### W1 — Problema & valor

Cubrir: problema, trigger, outcome, métrica de éxito, por qué ahora.
Resumen fase → AskQuestion Confirmar/Corregir/Profundizar.
Escribir/actualizar `00-discovery/brief.md`.

### W2 — Actores & journeys

Personas, permisos, happy path Must.
→ `personas.md` + notas de journey en brief.

### W3 — Alcance

IN / OUT / Won't. Registrar Won't explícitos.
Actualizar brief + `supuestos.md` si hay límites asumidos.

### W4 — Reglas & datos

Reglas de negocio, excepciones, entidades, estados.
→ `glosario.md` + reglas en brief/supuestos.

### W5 — NFRs & constraints

Auth sí/no, datos sensibles, escala, compliance, equipo, tiempo, budget, cloud preferida (sin elegir stack aún).
Invocar `nfr-extractor` si hay vaguedad.
→ supuestos + decisions-log.

### W6 — Completeness gate

Llenar `04-sesion/completeness-gate.md` (template).
Si rojo: solo AskQuestion de gaps. No backlog.
Si verde: avanzar.

### W7 — Discovery Summary

Resumen completo (todas las secciones) → aprobación explícita AskQuestion.
Actualizar `decisions-log.md`.
Al aprobar: devolver control al orquestador para **W8 stack-advisor**.
W8 exige **AskQuestion hasta stack definido** (ver `stack-advisor`); este wizard no elige stack ni escribe `stack.md`.

## Express

Misma secuencia; menos profundidad; Must + NFRs mínimos; gate igual obligatorio.

## Retomar

Leer `{proyecto}/04-sesion/wizard-progress.md` y reabrir fase pedida sin pisar hechos confirmados salvo que usuario corrija.
