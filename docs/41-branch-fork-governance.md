---
status: active
owner: maintainers
updated: 2026-09-08
related: [[03-branching-and-commits]], [[05-contribution-guide]], [[32-ci-cd]]
---
# Gobierno de branches y forks

`main` es la rama protegida y única fuente de releases. El trabajo entra mediante forks públicos y Pull Requests; nunca se concede escritura directa a terceros.

Las ramas de trabajo siguen `type/scope/descripcion-corta`: `port/`, `fix/`, `build/`, `ci/`, `docs/`, `refactor/` y `release/`. Los commits son atómicos y cada PR declara origen, base, pruebas y riesgo.

## Auditoría de forks

El workflow `fork-audit.yml` consulta periódicamente la API pública de GitHub con permisos de lectura, registra owner, repositorio, rama por defecto, fecha de creación y última actualización, y publica un artefacto JSON sanitizado. No clona forks, no descarga secretos y no ejecuta código de terceros.

Un fork se considera contribuidor potencial, no colaborador confiable: el código siempre pasa CI, revisión CODEOWNERS, escaneo de secretos y validación de procedencia antes de integrarse.

## Política de integración

1. Detectar el fork en la auditoría.
2. Abrir PR desde la rama de trabajo del fork hacia `main`.
3. Ejecutar CI ligero y GitNexus sobre el diff.
4. Revisar dependencias, blobs, licencias y credenciales.
5. Fusionar solo con checks verdes y aprobación de mantenedores.
