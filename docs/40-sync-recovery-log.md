---
status: active
owner: maintainers
updated: 2026-09-08
related: [[21-device-porting-checklist]], [[32-ci-cd]], [[90-decision-log]]
---
# Registro de recuperación del checkout

## Incidencia

El checkout Android 17 estaba incompleto por sparse-checkout y repositorios auxiliares ausentes. Soong fue ejecutado con `lineage_miami-userdebug` y cada error se registró antes de recuperar la dependencia siguiente.

## Hallazgos y acciones

- API opcional de OnDevice Intelligence: se añadió tolerancia explícita a API latest ausente en `packages/modules/NeuralNetworks/service/Android.bp`.
- Se restauraron JUnit, JSpecify, JSR330, KMOD, JUnit Params y los paths públicos/system/module-lib/test del SDK disponibles en el repositorio cacheado.
- `external/jxmpp` existe como repositorio AOSP vacío; no se debe inventar contenido ni sustituirlo sin fijar una fuente compatible.
- Falta resolver la interfaz Lineage `vendor.lineage.touch-V1.0-java` y su dependencia `hardware/google/pixel`.

## Criterio de cierre

`m nothing` debe generar `source/out/soong/build.lineage_miami.ninja` sin errores. Después se ejecutarán `bootimage` y `vendorbootimage`. Los artefactos `out/` permanecen fuera del repositorio público.
