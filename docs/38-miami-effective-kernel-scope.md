# Alcance efectivo del kernel para `miami`

Configuración base: `vendor/holi-qgki_defconfig`  
Fragmentos: `vendor/ext_config/lineage_moto-holi.config` y `vendor/ext_config/moto-holi-miami.config`

## Subsistemas prioritarios

El `modules.load` de `miami` incluye componentes de cámara/CCI, audio Qualcomm y AW882xx, WLAN/Bluetooth, touch Goodix, fingerprint FOD, NFC SN1XX, sensores SAR, carga MMI/USB-PD/wireless y telemetría MMI.

## Exclusiones verificadas

`CONFIG_MSM_NPU` no forma parte de la configuración efectiva y no aparece en `modules.load`. El ciclo de headers NPU queda fuera del análisis de portabilidad de este dispositivo.

## Orden de análisis

1. Cámara y CCI.
2. Touch Goodix/FOD.
3. Carga, batería y USB-PD.
4. Audio AW882xx y codecs.
5. NFC, SAR y fingerprint.
6. WLAN/Bluetooth y módulos de conectividad.

Cada bloque se analizará con GitNexus por separado, se validará contra su configuración y se documentará antes de cualquier cambio de código.
