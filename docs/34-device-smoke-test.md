---
status: active
owner: QA maintainers
updated: 2026-09-08
related: [[30-validation-matrix]], [[31-release-and-updates]], [[33-bug-hunting]]
---
# Smoke test de dispositivo

Ejecutar `tools/device-smoke.sh reports/<build>-<device>` con el emulador o el Edge 30 Neo conectado por ADB. El reporte debe conservar state, getprop, servicios, VINTF y logcat sanitizado.

## Bloqueadores

- `adb get-state` distinto de `device`.
- Boot incompleto, crashloop, ANR persistente o kernel panic.
- `checkvintf` fallido o AVC denials nuevos en una ruta crítica.
- Radio, Wi‑Fi, Bluetooth, sensores, cámara o carga no funcionales.

No subir el reporte sin ejecutar `tools/bug-hunter.sh`; los archivos con datos privados se quedan localmente.
