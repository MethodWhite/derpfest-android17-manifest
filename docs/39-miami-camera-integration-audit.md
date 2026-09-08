# Auditoría de integración de cámara — `miami`

## Evidencia

- La configuración activa `CONFIG_CAMERA_CCI_INTF=m`, `CONFIG_CAMERA_CCI_ADDR_SWITCH=y` y `CONFIG_CAM_SENSOR_PROBE_RETRY=y`.
- `device-motorola-miami/modules.load` carga `camera.ko` y `cci_intf.ko`.
- Los blobs propietarios declaran sensores `hi1336`, `ov32b40`, `ov32c4c` y `s5kgw3`, junto con EEPROM, tuning y módulos de sensor específicos de `miami`.
- El árbol público del dispositivo no contiene un DTS de cámara; la descripción física queda en el DTB/vendor del kernel.
- `device-motorola-miami/vendor.prop` establece `persist.vendor.camera.physical.num=3`.

## Riesgos y decisión

La presencia de cuatro familias de sensor no demuestra que las cuatro sean cámaras físicas simultáneas; pueden representar variantes de proveedor. La propiedad de tres cámaras debe validarse contra el DTB y la configuración CamX antes de cambiarla. No se modifica todavía: falta extraer/inspeccionar el DTB efectivo y validar el inventario de sensores en hardware o emulador.

## Siguiente validación

Comparar nodos de cámara del DTB de `miami` con las cuatro bibliotecas de sensor, verificar el orden de módulos y ejecutar smoke tests de apertura, cambio de cámara, flash y grabación.
