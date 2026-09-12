---
name: impl-impact-scanner
description: >-
  Scans completed HU work for architecture/stack/contract/scope drift and forces
  STOP+AskQuestion on unauthorized impact. Use in I8 of story-implementer before handoff.
---

# Impl Impact Scanner (I8)

## Checklist binario (responder en progress)

- [ ] ¿Cambié contratos públicos?
- [ ] ¿Toqué schema/migración?
- [ ] ¿Añadí dependencia?
- [ ] ¿Cambié auth/roles?
- [ ] ¿Implementé algo fuera de OoS de la HU?
- [ ] ¿Contradije overview/stack/nfr?

## Método

1. Diff mental/real vs plan aprobado + stack.md + overview + OoS HU.
2. Comparar package manifests si existen (package.json, *.csproj, requirements, etc.).
3. Cualquier **sí** no autorizado previamente → STOP + `impl-decision-gate`.
4. Si duda entre sí/no → tratar como **sí** (AskQuestion).
5. Si todo no → OK para I9.

## Rollback

Si impacto no autorizado y usuario no aprueba: proponer revertir archivos del slice conflictivo.
