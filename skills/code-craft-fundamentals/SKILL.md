---
name: code-craft-fundamentals
description: >-
  Static software craft theory for HU implementation: SOLID, DRY, KISS, YAGNI,
  Clean Code basics, GoF/enterprise pattern catalog, coupling/cohesion. Use with
  hu-implementer, impl-coder, code review, or when user asks SOLID DRY buenas
  practicas patrones. Does NOT auto-refresh (stable theory).
---

# Code Craft Fundamentals (teoría estable)

Skill **global** y **estático** para el agente implementador.

**Política de actualización:** NO. Esta skill **no** entra en `stack-skills-updater` ni requiere WebSearch periódico. La teoría base (SOLID/DRY/KISS/YAGNI/patrones clásicos) cambia poco; no regenerar ni “refrescar TTL”.

**WebSearch:** opcional solo si el usuario pide un ejemplo *idiomático del lenguaje/stack concreto*. La doctrina de esta skill basta para I3/I6.

**Prioridad al implementar:**
1. AC/BDD de la HU + arquitectura/stack del proyecto  
2. Skills `stack-*` del proyecto  
3. Esta teoría (sin over-engineering)  
4. Memoria del modelo

## Principios núcleo

### SOLID (Robert C. Martin / acrónimo Michael Feathers)

| Letra | Principio | Checklist rápido |
|-------|-----------|------------------|
| **S** | Single Responsibility | ¿Una sola razón de cambio? |
| **O** | Open/Closed | ¿Extender sin romper lo estable? |
| **L** | Liskov Substitution | ¿El subtipo puede sustituir al base sin sorpresas? |
| **I** | Interface Segregation | ¿El cliente depende solo de lo que usa? |
| **D** | Dependency Inversion | ¿Alto nivel depende de abstracciones, no de detalles? |

**Regla práctica:** SOLID guía dependencias en código que **va a cambiar**. Utilidad trivial → no forzar interfaces/factories.

### DRY (Don’t Repeat Yourself — Hunt & Thomas)

> Cada pieza de **conocimiento** debe tener una representación autoritativa única.

- Mal DRY: fusionar código que solo se *parece* (coincidente).
- Bien DRY: una regla de negocio / schema / validación en un solo lugar.
- Opuesto informal: WET (Write Everything Twice) cuando la duplicación es deliberada y barata.

### KISS (Keep It Simple)

La solución más simple que cumple la HU gana. Complejidad solo si el AC/NFR la exige.

### YAGNI (You Aren’t Gonna Need It)

No construir features, capas o abstracciones “por si acaso”. Si no está en la HU / plan aprobado → no.

### Nota sobre “CRY”

No hay principio estándar llamado CRY. Interpretación útil alineada a *The Pragmatic Programmer*:

- **DRY** + código **shy** (bajo acoplamiento / Law of Demeter) + **Tell, Don’t Ask**.

Si el usuario dijo CRY por KISS, aplicar KISS.

### Otros clásicos (aplicar con juicio)

| Idea | En una línea |
|------|----------------|
| Separation of Concerns | Una preocupación por módulo/capa |
| High cohesion / Low coupling | Cosas que cambian juntas, juntas; dependencias mínimas |
| Composition over inheritance | Preferir componer comportamientos |
| Law of Demeter | Hablar con amigos cercanos, no con la cadena entera |
| Fail fast | Detectar inválido pronto y claro |
| Pure-ish core | Lógica de dominio testeable; I/O en bordes |
| Naming | Nombres revelan intención; sin abreviaturas oscuras |
| Boy Scout Rule | Dejar el módulo un poco mejor **sin** ampliar scope de la HU |

## Clean Code (básico, Uncle Bob — práctica)

- Funciones pequeñas, un nivel de abstracción
- Nombres honestos; booleans sin negaciones dobles
- Efectos secundarios evidentes
- Errores explícitos; no tragar excepciones
- Comentarios para *por qué*, no para *qué* obvio
- No dead code / magia numérica sin nombre

## Patrones de diseño (catálogo — usar solo si el problema ya existe)

### GoF — Creacionales
Factory Method, Abstract Factory, Builder, Singleton (**evitar** salvo estado realmente global inevitable), Prototype.

### GoF — Estructurales
Adapter, Bridge, Composite, Decorator, Facade, Flyweight, Proxy.

### GoF — Comportamiento
Strategy, Observer, Command, Template Method, State, Iterator, Mediator, Memento, Visitor, Chain of Responsibility, Interpreter.

### Frecuentes en apps
Repository, Unit of Work, DTO, Mapper, DI/IoC, Options/Settings, Middleware/Pipeline, CQRS (solo si el dominio lo pide), Circuit Breaker (NFR resiliencia).

**Regla:** el patrón es remedio a un dolor **presente** (condicionales crecientes, duplicación de orquestación, etc.). No decorar la HU con patrones de moda.

## Checklist pre-código (I3/I6) — modelos medianos

Antes de cada slice:

1. [ ] ¿Esto está en el plan/AC? (YAGNI)
2. [ ] ¿Es la forma más simple que pasa AC? (KISS)
3. [ ] ¿Estoy duplicando conocimiento o solo texto parecido? (DRY)
4. [ ] ¿Esta clase/función tendrá una sola razón de cambio? (SRP)
5. [ ] ¿Estoy acoplando a un detalle concreto sin necesidad? (DIP)
6. [ ] ¿Necesito un patrón GoF **ahora** o basta una función clara?
7. [ ] ¿Respeto `stack-*` del proyecto y estilo del repo?

Si 6 = “patrón” pero el repo no lo usa → Preferir patrón local; AskQuestion solo si el patrón implica contrato/arquitectura nueva.

## Anti-patrones (prohibidos en implementer)

- God class / god module
- Shotgun surgery (un cambio toca 15 archivos sin necesidad)
- Abstracción prematura (interfaces de un solo implementor “por SOLID”)
- Copiar-pegar reglas de negocio
- Singleton + estado mutable escondido
- Refactor cosmético fuera del plan
- Imponer Clean Architecture completa en una HU chica

## Relación con otros skills

| Skill | Rol |
|-------|-----|
| `code-craft-fundamentals` (este) | Teoría estable |
| `stack-*` (proyecto) | Cómo aplicar teoría **en** ese stack hoy |
| `freshness-guard` | APIs/versiones (cambiante) |
| `skill-BestPractices` | Alternativa más amplia; este skill es el **default del implementer** |

## Cuándo NO aplicar al pie de la letra

Scripts one-off, spikes (`SPK-*`), prototipos throwaway: KISS/YAGNI primero; SOLID ligero.
