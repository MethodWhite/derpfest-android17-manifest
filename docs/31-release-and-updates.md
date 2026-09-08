---
status: active
owner: release maintainers
updated: 2026-09-08
related: [[30-validation-matrix]], [[32-ci-cd]], [[90-decision-log]]
---
# Releases y sistema de updates

## Versionado

Usar `YYYY.MM.PATCH` para builds de desarrollo/release y tags `vYYYY.MM.PATCH`. Cada release debe indicar commit, manifest, device trees, toolchain, variante, firmware requerido, cambios, bugs conocidos, instrucciones de instalación/rollback y SHA-256.

## Puerta de release

Una release requiere CI verde, matriz de validación actualizada, revisión de seguridad, changelog, artefactos firmados y hashes publicados. Nunca publicar automáticamente un build que no tenga evidencia de boot y validación del dispositivo.

## Updates

El update checker compara el manifest fijado con upstream/forks, abre una propuesta de actualización y ejecuta compatibilidad focalizada. No modifica árboles automáticamente. Las actualizaciones de seguridad tienen prioridad P0/P1; cualquier cambio de firmware requiere migración y rollback documentados.

## Rollback

Conservar la release anterior, metadata y hashes. Todo update debe declarar cómo volver a la última versión conocida estable sin borrar datos de usuario.
