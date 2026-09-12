---
status: active
owner: maintainers
updated: 2026-09-12
related: [[03-branching-and-commits]], [[04-bug-reporting]], [[30-validation-matrix]], [[35-gitnexus-atomic-work]], [[41-upstream-provenance]]
---
# Protocolo de contribución asistida por IA

Este proyecto usa IA como apoyo de ingeniería, no como sustituto de revisión humana. Toda contribución debe preservar la arquitectura upstream de DerpFest/AOSP y dejar cambios pequeños, trazables y fáciles de migrar a otros dispositivos.

## Método de trabajo

1. **Descubrir:** identificar el módulo, su namespace, consumidores, upstream y licencia. Usar GitNexus para contexto e impacto cuando el repositorio esté indexado.
2. **Agrupar:** reunir errores de la misma familia (por ejemplo, imports Soong, AXT, Bedstead o Ravenwood) y corregirlos en una pasada, sin mezclar capas distintas.
3. **Micromodularizar:** mantener dependencias explícitas, interfaces claras y configuración reutilizable. No duplicar lógica ni ocultar fallos desactivando componentes requeridos.
4. **Validar:** ejecutar primero la prueba focalizada y después el build o test del target completo. Registrar el error original, la corrección y el resultado.
5. **Asegurar:** revisar diff, licencias, origen de archivos y secretos antes de publicar. Nunca subir tokens, claves, certificados, dumps privados, blobs no autorizados ni artefactos generados.
6. **Entregar:** crear un microcommit por objetivo reversible. El mensaje debe indicar capa y propósito; el PR debe incluir impacto, validación y rollback.

## Reglas para agentes y colaboradores

- No inventar módulos, APIs, namespaces, licencias ni datos de hardware: verificar en el árbol o en el upstream oficial.
- Antes de editar un símbolo o módulo, revisar sus consumidores y dependencias; después, revisar el blast radius.
- Si aparecen errores en cadena, corregir la familia detectada y volver a validar; no realizar cambios masivos especulativos.
- Mantener separados platform, device, kernel, vendor, CI y documentación.
- Una contribución asistida por IA debe declarar qué se automatizó y qué validó una persona.

## Definition of Done

La contribución está lista cuando el cambio es atómico, el diff está limpio, las validaciones pasan o tienen bloqueo documentado, las licencias se conservan, no hay secretos y la documentación refleja el estado real del manifest.
