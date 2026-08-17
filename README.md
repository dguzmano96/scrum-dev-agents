# Scrum Dev Agents

Plugin de agentes y skills para **Cursor** orientado a equipos que trabajan con Scrum en español: discovery de producto, historias INVEST, implementación HU por HU, briefings arquitectónicos, debate de soluciones y verificación escéptica.

## Qué incluye

- **13 agentes** de primera línea e internos (ver [docs/primera-linea.md](docs/primera-linea.md))
- **46 skills** propias de Scrum, implementación y calidad (arquitectura, backlog, craft gate, NFR, tests, etc.)
- Pipelines documentados: greenfield (W0–W8b), brownfield (E0–E12), investigación (R0–R8), implementación (I0–I9), épicas (Epi0–Epi8)

## Instalación

1. Abre **Cursor**
2. Ve a **Customize → Plugins**
3. Selecciona **Add from GitHub**
4. Pega la URL: `https://github.com/dguzmano96/scrum-dev-agents`

Los agentes aparecerán en el selector de agentes; las skills se cargan automáticamente desde `./skills/`.

## Uso rápido

Habla en el chat con el agente de primera línea que corresponda. Ejemplos:

- `Usa agent-scrum: convierte esta idea en backlog Scrum (modo guiado).`
- `Usa agent-evolucion: quiero agregar exportación CSV a este producto brownfield.`
- `Usa agent-implementador: implementa HU-003 del proyecto.`
- `Usa agent-verificador: valida que HU-003 está realmente done.`

Consulta [docs/primera-linea.md](docs/primera-linea.md) para el mapa completo de agentes, flujos greenfield vs brownfield y prompts de ejemplo.

## Licencia

MIT — ver [LICENSE](LICENSE). Copyright (c) 2026 Diego Guzman.

## Qué NO incluye

Este plugin **no** incluye:

- `agent-Sonarqube` (análisis estático SonarQube-style; no publicado)
- Skills de terceros o de stack específico de un PC: Cloudflare, Workers, Wrangler, Durable Objects, Turnstile, web-perf, sandbox-*, agents-sdk
- Skills de stack concreto: Next.js, Node.js, .NET (usa `stack-skill-generator` en tu proyecto para generar las tuyas)
- Configuración global del usuario (`AGENTS.md`, políticas, planes, extensiones)

Para generar skills de tu stack en el proyecto, usa `stack-advisor` + `stack-skill-generator` tras instalar el plugin.
