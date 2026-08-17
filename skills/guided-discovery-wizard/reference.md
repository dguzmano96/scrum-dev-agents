# Bank de preguntas — Guided Discovery

Usar AskQuestion (lotes 5–12). Preferir opciones cerradas; texto libre si hace falta matiz.
Explicar por qué se pregunta (impacto en backlog).

## W0

- ¿Modo? Guiado completo / Express / Retomar
- ¿Nombre del proyecto? (slug kebab-case)
- ¿Ya existe carpeta de proyecto a retomar?

## W1 — Problema & valor

- ¿Qué problema concreto resuelve esto hoy?
- ¿Quién sufre el problema (rol)?
- ¿Cómo se mide el éxito en 30–90 días? (métrica)
- ¿Qué pasa si no se construye?
- ¿Hay deadline o evento externo?

## W2 — Actores & journeys

- Lista de roles que usan el sistema
- Permisos por rol (CRUD / admin / lectura)
- Happy path Must en 5–10 pasos
- ¿Qué pasa a mitad de flujo si falla un paso?
- ¿Usuarios internos, externos, ambos?

## W3 — Alcance

- Must para MVP (lista corta)
- Should / Could
- Won't explícito (fuera de alcance ahora)
- ¿Multi-tenant? ¿Multi-idioma? ¿Offline?

## W4 — Reglas & datos

- Reglas de negocio críticas (o “ninguna aún”)
- Entidades principales y campos mínimos
- Estados / ciclo de vida
- Datos sensibles (PII, pagos, salud)
- Fuente de verdad si hay sistemas legacy

## W5 — NFRs & constraints

- ¿Auth requerida? Método preferido desconocido OK
- Escala esperada (usuarios concurrentes / records)
- Disponibilidad objetivo (o “no crítico”)
- Cloud preferida: Azure / AWS / GCP / ninguna / no sé
- Skills del equipo (lenguajes/frameworks conocidos)
- Timeline MVP y budget infra (o “sin restricción”)

## Confirmación post-fase

Tras W1–W5 siempre:

1. Confirmar fase
2. Corregir
3. Profundizar este tema

## Stop criteria (alineado a gate W6)

Actores claros · problema medible · IN/OUT · flujos Must · reglas críticas · entidades mínimas · NFRs mínimos · cero `[POR VALIDAR]` bloqueantes.
