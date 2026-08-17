# Change Impact Gate — referencia

## Señales Breaking frecuentes

- Cambiar response shape de API consumida por clientes
- Migración que reescribe datos productivos
- Cambiar proveedor auth
- Añadir dependencia major que obliga upgrade transversal
- Romper compatibilidad mobile/web compartida

## Tras aprobar Arquitectura/stack

1. `freshness-guard`
2. `stack-advisor` solo si hay candidatos reales de cambio
3. Actualizar `stack.md` + ledger en E12 con autorización
4. `architecture-documenter` para diagramas impactados
