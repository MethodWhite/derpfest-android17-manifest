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
- La referencia Java HIDL fue retirada de `frameworks/base/Android.bp`: no tiene consumidores Java y el servicio Motorola usa `vendor.lineage.touch-V1-ndk`; el árbol Lineage actual publica Touch mediante AIDL.
- Los paquetes opcionales Motorola `MotoActions` y `StylusKeyHandler` quedaron deshabilitados mientras falta `org.lineageos.settings.resources`; se reactivarán al sincronizar el Settings Lineage compatible.
- Las variantes auxiliares `libunwindstack_demangle`, `libunwindstack_stdout_log` y `libunwindstack_no_dex` se deshabilitaron porque el toolchain Rust mezclado no ofrece `prebuilt_libstd` Android; el módulo base no se modifica.
- Se reemplazó esa mitigación por un puente nativo `prebuilt_libstd_android`, usando los `libstd` Android fijados del toolchain 1.93.1 por arquitectura; Soong superó correctamente la validación de variantes Rust/C++.
- El siguiente bloqueo es `vendor.display.config@2.0`: el checkout contiene clientes y blobs WFD, pero no la definición HIDL de la interfaz. No se crea un stub; debe recuperarse la procedencia Qualcomm compatible antes de integrar WFD.
- La interfaz HIDL compatible `vendor.display.config@2.0` se recuperó desde Lineage `lineage-24.0` y Soong superó ese bloqueo. El nuevo faltante es `libheif`, dependencia de WFD; no está en el manifest ni en el checkout, por lo que WFD queda pendiente sin stubs.
- El análisis del blob `libwfdcommonutils.so` confirma que `libheif` es una dependencia dinámica real de WFD, no una referencia decorativa. Se conserva la dependencia y se bloquea la integración de WFD hasta obtener la biblioteca compatible.
- El namespace `hardware/qcom-caf/wlan/qcwcn` se añadió para resolver `lib_driver_cmd_qcwcn`. El siguiente bloqueo es `libsnapdragoncolor-manager.so`, cuyo NEEDED exige `libtinyxml2-v34.so`; `libtinyxml2_1.so` no se sustituye sin verificar ABI/SONAME.

## Criterio de cierre

`m nothing` debe generar `source/out/soong/build.lineage_miami.ninja` sin errores. Después se ejecutarán `bootimage` y `vendorbootimage`. Los artefactos `out/` permanecen fuera del repositorio público.
