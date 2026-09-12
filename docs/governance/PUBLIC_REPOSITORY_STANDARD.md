---
status: active
owner: maintainers
updated: 2026-09-12
related: [[../41-upstream-provenance]], [[../32-ci-cd]], [[../42-ai-micromodular-contribution-protocol]]
---
# Estándar de repositorio público

El repositorio público contiene coordinación, manifest, documentación, scripts seguros y configuración CI. El árbol completo de Android y los artefactos generados no se versionan aquí.

Debe incluir README fiel al manifest, LICENSE, SECURITY, CONTRIBUTING, CODE_OF_CONDUCT, CODEOWNERS, changelog y workflows revisables.

Nunca se publican tokens, llaves, certificados, credenciales, dumps privados, blobs sin autorización, `out/`, imágenes de build ni archivos generados de gran tamaño.

Los releases requieren tag protegido, manifest exacto, hashes SHA-256, changelog y revisión humana.
