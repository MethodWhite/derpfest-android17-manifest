---
status: active
owner: CI maintainers
updated: 2026-09-08
related: [[02-scrum-ban]], [[31-release-and-updates]]
---
# CI/CD público

## Pipelines

| Pipeline | Evento | Propósito |
|---|---|---|
| Hygiene | cada PR | secretos, artefactos y diff |
| Docs/YAML | cada PR | documentación y configuración |
| Port smoke | manual | manifest, targets y scripts |
| Upstream watch | semanal | detectar cambios upstream |
| Release | tag protegido | crear release con metadata/hashes |

## Seguridad

El repositorio es público y no depende de secretos para CI básico. Permisos mínimos, Actions fijadas a versiones mayores, nada de dumps/credenciales en logs y `contents: write` solo en el workflow de tags. Los builds completos se ejecutan bajo demanda y no se publican sin aprobación/revisión.

## Artefactos

Nunca versionar `out/`, imágenes ni zips. Publicar únicamente artefactos de release desde GitHub Releases u otro almacenamiento explícitamente elegido, acompañados de SHA-256, manifest y changelog.
