---
status: active
owner: maintainers
updated: 2026-09-08
---
# Mapa de arquitectura

`AOSP/DerpFest → frameworks/vendor → hardware Motorola/Qualcomm → sm6375-common → miami → kernel/vendor blobs → imagen`

Los cambios deben indicar en qué capa viven. Los monolitos se separan por responsabilidad: build/API, device, common hardware, kernel, vendor, validación y CI. Antes de refactorizar, crear ADR y tests/criterios de regresión.
