# Templates canónicos — referencia rápida

Ver archivos en `templates/`:

- `EPIC.md`
- `HU.md`
- `stack.md`
- `sources-ledger.md`
- `completeness-gate.md`
- `quality-rubric.md`

## Rúbrica calidad HU (1–3 c/u, max 24 → nota /10)

1. Claridad de persona
2. Valor de negocio medible
3. Calidad de AC
4. Cobertura BDD (4 tipos)
5. Tamaño (1 sprint / 1–3 días ideal)
6. Edge cases
7. Dependencias explícitas
8. Concisión + NFRs + out of scope

**≥9.0** ready · **7.0–8.9** refine · **<7.0** rework/split

## Completeness gate (W6)

- [ ] Problema + outcome medible
- [ ] ≥1 persona/actor con permisos claros
- [ ] Happy path Must narrado
- [ ] IN / OUT / Won't
- [ ] Reglas de negocio críticas o explícitamente "ninguna aún"
- [ ] Entidades/datos mínimos o "CRUD simple"
- [ ] NFRs mínimos (auth sí/no, datos sensibles sí/no, escala esperada)
- [ ] Restricciones de equipo/tiempo/budget (o "sin restricción")
- [ ] Cero supuestos BLOQUEANTES abiertos
