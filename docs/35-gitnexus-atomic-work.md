---
status: active
owner: maintainers
updated: 2026-09-08
related: [[03-branching-and-commits]], [[20-architecture-map]], [[33-bug-hunting]]
---
# GitNexus y commits atómicos

## Índices

El índice `derpfest-miami-main` cubre gobierno, CI y árboles de dispositivo; excluye `source/`, metadata, toolchains y `kernel-motorola-sm6375`. El kernel se analiza como repositorio separado cuando una tarea afecte su código.

## Flujo obligatorio

1. Ejecutar `gitnexus status` y confirmar que el índice está fresco.
2. Consultar contexto/impacto del símbolo o archivo antes de editar.
3. Definir un único objetivo por commit: build, device, kernel, CI, docs o release.
4. Ejecutar validación focalizada y `git diff --check`.
5. Revisar cambios con `gitnexus detect-changes` y documentar consumidores afectados.
6. Crear PR pequeño con Issue/Historia/ADR enlazado.

## Regla de separación

Si una modificación cambia más de una capa, dividirla en commits ordenados y explicar la dependencia. No mezclar fixes funcionales con formateo, blobs, documentación no relacionada o regeneración de artefactos.

## Criterio de revisión

Un commit es atómico cuando puede revertirse sin dejar una capa parcialmente actualizada, tiene una prueba o evidencia clara y su blast radius está documentado.
