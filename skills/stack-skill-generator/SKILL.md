---
name: stack-skill-generator
description: >-
  After stack.md is confirmed, generates project-local expert skills per
  technology under {proyecto}/.cursor/skills/stack-* using WebSearch/WebFetch
  official docs. Use after W8 stack-advisor, evolution new tech, or regenerate
  stack skills.
---

# Stack Skill Generator

Crea **skills expertos del stack del proyecto** para que `hu-implementer` las use.
Ubicación: **dentro del proyecto** (no en `~/.cursor/skills/` global).

Verify with official docs via WebSearch/WebFetch before recommending; record sources.

## Ubicación obligatoria

```text
{nombre-proyecto}/
├── .cursor/skills/
│   ├── STACK_MANIFEST.md
│   ├── stack-{tech-slug}/
│   │   ├── SKILL.md
│   │   ├── reference.md
│   │   └── meta.md
│   └── ...
└── 02-arquitectura/
    ├── stack.md
    ├── sources-ledger.md
    └── stack-skills-index.md    # índice que apunta a .cursor/skills
```

`{tech-slug}` = kebab-case (ej. `stack-nextjs`, `stack-postgresql`, `stack-dotnet`).

**Nota Cursor:** para auto-descubrimiento, el workspace abierto debe ser `{nombre-proyecto}` (o la raíz que contenga ese `.cursor/skills`).

## Cuándo invocar

1. Tras confirmar stack (W8 / `stack-advisor`) en greenfield.
2. Tras E10/E12 en `scrum-evolution` si se **agrega** lenguaje/framework/servicio nuevo a `stack.md`.
3. Comando usuario: `generar stack skills` / `regenerar skill de {tech}`.

## Precondiciones

- `02-arquitectura/stack.md` con stack elegido **y confirmado vía AskQuestion en W8** (greenfield). Si falta confirmación AskQuestion → no generar skills; devolver control a `stack-advisor`.
- Invocar `freshness-guard` **por cada** componente antes de escribir su skill

## Método (determinista)

1. Parsear `stack.md` → lista de componentes (frontend, backend, DB, auth, hosting, cache, etc.).
2. Leer `STACK_MANIFEST.md` si existe → skills ya creadas.
3. Para cada componente **sin** skill o marcado `stale`:
   a. WebSearch: `"{tech} official documentation"` + release notes / LTS
   b. WebFetch 1–3 URLs allowlist (`freshness-guard`)
   c. Crear carpeta `stack-{slug}/` con template (ver `templates/`)
   d. Rellenar: patrones vigentes, gotchas, deprecations, Do/Don't, links oficiales, versión/canal del día
   e. `meta.md`: `last_verified` ISO, `ttl_days: 30`, urls, claims
   f. Append/update fila en `sources-ledger.md` y `STACK_MANIFEST.md`
4. Escribir/actualizar `02-arquitectura/stack-skills-index.md`.
5. **No** hardcodear versiones de memoria: solo lo verificado hoy.

## Contenido mínimo de cada stack skill

- Frontmatter `name` + `description` (triggers: nombre tech + "implementar con…")
- Convenciones del proyecto (cómo usarlo **en este** stack.md)
- Patrones recomendados **vigentes** (docs del día)
- Anti-patrones / APIs deprecadas encontradas
- Testing / lint tipico si docs lo cubren
- Links oficiales + fecha verificación
- Instrucción: ante duda → re-fetch docs; no inventar

Omitir `disable-model-invocation` (deben poder auto-invocarse en el proyecto).

## Una skill por componente material

Sí: Next.js, NestJS, PostgreSQL, Prisma, Azure Functions, Redis…  
No: “todo el stack en un solo skill” (demasiado grande para modelos medianos).  
Opcional: `stack-overview` corto que solo lista componentes y apunta a cada skill.

## Salida

Lista de skills creadas/actualizadas + aviso: “Implementer debe leer STACK_MANIFEST + skills stack-* en I1/I5/I6”.
