# Plantilla AskQuestion — decisión de épica

Usar cuando `impl-decision-gate` clasifica **needs-user** o **needs-scrum-update**, o cuando Epi4/Epi6 detectan fallo de build/test o AC Must en rojo.

## Título sugerido

Decisión requerida — {EP-ID} — HU {HU-ID} — {tema corto}

## Cuerpo (obligatorio, 4 bloques)

### 1. Explicación técnica

Qué pasó, dónde, qué señal lo disparó (matriz STOP, build, test, AC, drift), qué dice el repo/docs/stack skill. 2–4 bullets.

### 2. Explicación no técnica (completa, en llano)

Para alguien de producto/negocio **sin** contexto de código. Debe bastar sola para decidir sin leer el bloque técnico.

- **Extensión:** 1 párrafo corto o **4–6 frases** (completa, no telegráfica).
- **Sin jerga:** no nombres de tests, clases, asserts, commits, archivos, APIs ni acrónimos internos sin traducir.
- **Incluir siempre:** qué se quería lograr; qué ya salió bien; qué falló o qué falta decidir (en efecto de producto); por qué paramos ahora y qué se arriesga si se elige mal.
- **No** reescribir la sección técnica con otras palabras: **traducir** el significado.

### 3. Impacto

- **HU actual:** …
- **Épica:** … (si aplica)
- **Arquitectura / stack:** … (si aplica)
- **Contratos / dependencias:** … (si aplica)

### 4. Soluciones posibles (cerradas)

1. Opción A (recomendada): …
2. Opción B: …
3. Opción C: …
4. Abortar épica
5. Otra (especificar)
6. Aprobar y actualizar docs Scrum también (si aplica — `needs-scrum-update`)

## Regla

No escribir ni un archivo más hasta respuesta del usuario. Si la decisión es `needs-scrum-update`, sugerir handoff a Scrum/Evolución; solo sincronizar docs si el usuario autoriza.

## Ejemplo mínimo

### 1. Explicación técnica

- Build falla en `src/auth/login.ts`: tipo `User` ya no existe en `stack-nextjs` (cambió en v15).
- `freshness-guard` confirma breaking change en la API.
- AC-2 (login con 2FA) depende de este endpoint.

### 2. Explicación no técnica (completa, en llano)

Estábamos cerrando la historia de login seguro. La parte del producto que el usuario ve ya encaja con lo pedido, pero al pasar la revisión automática de calidad apareció un fallo en un chequeo que habla con un servicio externo de autenticación: a veces ese servicio responde vacío o distinto de lo esperado. Eso no demuestra que el login de la historia esté roto, pero sí impide declarar la historia “terminada” con la barra de calidad completa. Por eso paramos: o reintentamos por si fue un fallo pasajero, o acordamos cerrar sin ese chequeo externo, o investigamos el servicio antes de seguir con la siguiente historia.

### 3. Impacto

- **HU actual:** HU-003 bloqueada hasta resolver.
- **Épica:** EP-001 (auth) — HU-004 también depende del mismo endpoint.
- **Arquitectura / stack:** requiere actualizar `stack-nextjs` o migrar a nueva API.

### 4. Soluciones posibles

1. Migrar a la nueva API de `next-auth` v15 (recomendada)
2. Fijar versión anterior de `next-auth` y documentar deuda
3. Abortar épica y volver a Scrum para replanear auth
4. Otra (especificar)
