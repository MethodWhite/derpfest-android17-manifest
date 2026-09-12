---
status: active
owner: maintainers
updated: 2026-09-12
related: [[../01-project-charter]], [[../03-branching-and-commits]], [[../42-ai-micromodular-contribution-protocol]]
---
# Gobernanza del proyecto

DerpFest Android 17 se desarrolla como una plataforma upstream-first con soporte de dispositivos desacoplado. Las decisiones deben ser trazables, revisables y reversibles.

## Roles

- **Maintainers:** alcance, integridad del árbol, releases y decisiones de arquitectura.
- **Contributors:** cambios acotados, evidencia, licencias y documentación.
- **Reviewers:** impacto, seguridad, compatibilidad y validación independiente.
- **Automation/IA:** análisis y ejecución asistida; nunca aprobación final ni sustitución de revisión humana.

## Decisiones

Toda decisión que cambie alcance, arquitectura, procedencia, seguridad o release requiere issue/ADR enlazado. Las capas platform, device, kernel, vendor y CI se revisan por separado.

## Aceptación

Un cambio se acepta cuando cumple criterios de aceptación, tiene validación reproducible, conserva licencias, no incluye secretos y deja rollback claro.
