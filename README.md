# DerpFest Android 17 — Plataforma y soporte multidispositivo

![DerpFest](https://raw.githubusercontent.com/DerpFest-AOSP/DerpSite/master/dist/img/logo.png)

Integración comunitaria y escalable de DerpFest Android 17, basada en el manifiesto oficial de DerpFest. La plataforma es el objetivo principal; los árboles de dispositivos, comenzando por `miami`, son capas de soporte independientes. El código fuente AOSP/ROM vive en [`source/`](source/); la documentación operativa vive en [`docs/`](docs/).

## Inicio rápido

1. Leer [`docs/00-index.md`](docs/00-index.md) y [`docs/01-project-charter.md`](docs/01-project-charter.md).
2. Consultar [`PORT_STATUS.md`](PORT_STATUS.md) para el estado técnico de plataforma y dispositivos.
3. Crear trabajo desde las plantillas de GitHub y usar ramas `type/scope/short-description`.
4. No subir blobs, credenciales, artefactos `out/` ni dumps del dispositivo.

## CI/CD público

El repositorio está diseñado para ser público: el CI por defecto valida cambios ligeros y seguros, mientras que los builds Android pesados se ejecutan bajo demanda y con artefactos/hashes trazables. Releases y updates están definidos en [`docs/31-release-and-updates.md`](docs/31-release-and-updates.md) y [`docs/32-ci-cd.md`](docs/32-ci-cd.md).

## Principios

- Trazabilidad: cada cambio debe enlazar una historia, caso de uso o bug.
- Cambios pequeños y reversibles; separar portabilidad, producto y personalización.
- Validación por capas: lint/documentación → bootstrap Soong → target focalizado → build de imagen → prueba en emulador/dispositivo.
- La documentación es parte del entregable y debe actualizarse junto con el cambio.

## Estructura

| Ruta | Propósito |
|---|---|
| `source/` | Checkout Android/DerpFest y árboles de dispositivo |
| `docs/` | Wiki Obsidian, proceso, arquitectura y decisiones |
| `.github/` | Plantillas, CODEOWNERS y Actions |
| `PORT_STATUS.md` | Estado técnico de Android 17 y dispositivos |
