---
name: nfr-extractor
description: >-
  Turns vague non-functional requirements into measurable thresholds via
  AskQuestion (latency, availability, security, scale). Use when users say
  rápido, seguro, escalable, or during W5 NFR elicitation.
---

# NFR Extractor

## Objetivo

Convertir vaguedades en umbrales medibles o en “N/A explícito”.

## Mapeo típico

| Vago | Preguntar |
|------|-----------|
| Rápido | p95 latency objetivo por operación crítica |
| Seguro | auth, roles, cifrado en tránsito/reposo, auditoría |
| Escalable | usuarios concurrentes, records, crecimiento 12 meses |
| Disponible | % uptime / ventana de mantenimiento aceptable |
| Fácil de usar | criterios observables (pasos, errores, accesibilidad) |

## Método

1. Detectar adjetivos vagos en discovery/HU.
2. AskQuestion con opciones numéricas + “no crítico / no sé”.
3. Escribir en `02-arquitectura/nfr.md` y/o NFRs de épica/HU.
4. Si “no sé” → supuesto NO bloqueante o spike; no inventar umbral Must.

## Salida mínima nfr.md

Tabla: NFR | Umbral | Medición | Prioridad MoSCoW | Fuente (usuario/decisión).
