# DerpFest Android 17 — Motorola Edge 30 Neo (`miami`)

## Estado inicial

- Base DerpFest: `DerpFest-AOSP/android_manifest`, rama `16.2` (referencia).
- Dispositivo: `LineageOS/android_device_motorola_miami`, rama `lineage-24.0`.
- Común Qualcomm: `Motorola-SM6375-Devs/android_device_motorola_sm6375-common`, rama `sixteen`.
- Kernel: `Motorola-SM6375-Devs/android_kernel_motorola_sm6375`, rama `sixteen`.
- Hardware Motorola: `LineageOS/android_hardware_motorola`, rama `lineage-24.0`.

## Dependencias detectadas

El árbol específico declara el común SM6375. El común declara el kernel SM6375 y
`hardware/motorola`. Los repositorios propios de nuestro proyecto deberán
conservar esas rutas para que el manifest sea compatible con `repo`:

```text
device/motorola/miami
device/motorola/sm6375-common
kernel/motorola/sm6375
hardware/motorola
```

## Port Android 17

La rama `lineage-24.0` ya representa la línea Android 17 para el árbol específico,
pero el común y el kernel todavía parten de `sixteen`. El primer objetivo técnico
es compilar una imagen mínima con esos componentes y registrar cada adaptación
Android 16 → 17 en commits separados.

## Próximos hitos

1. Instalar/verificar `repo`, JDK, compilador y herramientas de Android.
2. Crear forks bajo la organización GitHub del proyecto.
3. Crear manifest propio y sustituir las referencias de upstream por esos forks.
4. Sincronizar AOSP/DerpFest de forma selectiva.
5. Importar blobs desde el firmware stock exacto del teléfono.
6. Ejecutar `lunch` y obtener la primera compilación.
7. Validar boot, display, touch, audio, cámara, radio, Wi-Fi, Bluetooth, huella,
   NFC, sensores, cifrado y OTA.

## Bloqueos conocidos

- DerpFest no publica actualmente una rama Android 17; la base 16.2 se usará como
  referencia de integración mientras portamos el framework y las apps.
- El árbol común y el kernel no tienen rama `seventeen`; habrá que adaptar y
  mantener esos repositorios dentro del proyecto.
- Falta conocer el firmware/región exactos del dispositivo para extraer blobs
  reproducibles.

## Hito alcanzado

El árbol AOSP 17 ya configura correctamente `lineage_miami-trunk_staging-userdebug`
con `PLATFORM_VERSION_CODENAME=Baklava`. Están presentes los makefiles vendor de
`miami` y `sm6375-common`, y las policies QCOM/DerpFest necesarias para superar
el product configuration.

El build se está ejecutando temporalmente con `WITH_GMS=false` porque la descarga
de `vendor/gms` desde Codeberg queda bloqueada por transporte Git. El cambio es
reversible y está limitado a hacer GMS opcional en `vendor/lineage/config/derpfest.mk`.

## Hito Soong Android 17

Se adaptó `vendor/lineage/build/soong/generator/generator.go` a las APIs de
Android 17 (`GetHostToolInfo`, `PathForSource` y sandbox Sbox). El bootstrap
completo de Soong terminó correctamente y generó el grafo del producto.

El siguiente bloqueo es de dependencias Qualcomm: los blobs públicos declaran
los namespaces `hardware/qcom-caf/sm8350`, `hardware/qcom-caf/wlan`,
`vendor/qcom/opensource/commonsys/display`,
`vendor/qcom/opensource/commonsys-intf/display`,
`vendor/qcom/opensource/dataservices` y `vendor/qcom/opensource/display`,
pero esos árboles no están sincronizados. Hay que localizar/importar las
versiones compatibles antes de intentar una compilación completa.

Se identificó y añadió una base YAAP Android 17 coordinada (`build/make`,
`build/soong` y `vendor/yaap`). El entorno ya crea correctamente los enlaces,
`lunch lineage_miami-trunk_staging-userdebug` selecciona `lineage_miami` y el
bootstrap Soong termina sin conflictos de plugins duplicados.

La validación completa queda detenida en artefactos API generados de AOSP
(`art.api.combined.*.latest`, `conscrypt.api.combined.*.latest` y similares).
Es la fase de generación/actualización de APIs de la base, no un error del
árbol `miami`. El espacio disponible ronda los 18 GB y no se inicia todavía
una compilación de imágenes.

La base YAAP también requiere sus forks coordinados de `art`, `bionic` y
`frameworks/base` para cerrar la generación de APIs. El intento de sincronizar
esos tres repositorios quedó bloqueado en el transporte Git de YAAP y fue
detenido sin alterar los checkouts actuales; se retomará por proyecto cuando
el transporte responda.

La integración Qualcomm se probó con árboles YAAP `seventeen`/LineageOS
`lineage-24.0`; el grafo superó namespaces, `qmaa` y propiedades Soong
obsoletas. La siguiente barrera son módulos API generados de AOSP (`art`,
`conscrypt` y varios de `frameworks/base`), señal de que el manifest AOSP 17
puro todavía no está alineado con las capas DerpFest/Lineage usadas. No se
lanza una compilación de imágenes mientras queden sólo 16 GB libres.

La sincronización de `frameworks/base` por HTTPS se detuvo después de superar
5 GB de objetos temporales y consumir casi todo el margen disponible; no llegó
a crear el checkout. Los paquetes temporales incompletos se movieron a la
Papelera para conservar una recuperación posible. La siguiente estrategia debe
ser una descarga superficial/filtrada con control estricto de espacio, o usar
un mirror local, antes de reintentar.

El proyecto fue trasladado temporalmente al NVMe del sistema en
`/home/methodwwhite/derpfest-miami`, incluyendo `.repo`, para recuperar
velocidad y espacio de trabajo. La metadata quedó local en
`repo-meta` y `source/.repo` apunta mediante enlace relativo.

Se materializó `prebuilts/sdk` mediante sparse checkout: APIs históricas y
`Android.bp`, sin herramientas/JARs innecesarios. Soong dejó de reportar
errores de `art`, `conscrypt` y `javax.obex`; el bloqueo actual se limita a
`service-adservices` y `service-healthfitness`, cuyos módulos
`system-server` todavía no generan sus módulos API combinados.
## Avance 2026-09-05

- El proyecto está en `/home/methodwwhite/derpfest-miami`; `.repo` también quedó local en el NVMe del sistema/home.
- El bootstrap de Soong ya supera las APIs `system-server` faltantes y el conflicto de `libqti-perfd-client` duplicado.
- Se corrigió la colisión AIDL V4/V5 de `libwfdservice` retirando la dependencia directa V4 del blob antiguo.
- La siguiente adaptación pendiente está en los genrules YAAP de headers del kernel: Android 17 no registra `KERNEL_BUILD_OUT_PREFIX`, `PATH_OVERRIDE_SOONG` ni `TARGET_PREBUILT_KERNEL_HEADERS`. El último diagnóstico quedó en `/tmp/m-nothing-home-final-20260905.log`.
- Este avance valida el grafo/Soong; todavía no se ha lanzado una compilación completa de la ROM.

## Avance 2026-09-06

- Se descargaron las extensiones de API de `prebuilts/sdk` mediante sparse checkout
  (aprox. 85 MB adicionales de payload útil). El árbol fuente conserva todos los
  componentes; el índice reducido usado para diagnóstico excluye únicamente tests,
  Trusty/SDV y otros módulos que no participan en `miami`.
- Se añadió compatibilidad del prebuilt `jsr305` con el APEX
  `com.android.tethering` (`min_sdk_version: 31` y `apex_available`).
- El diagnóstico reducido ya llega a errores de empaquetado de testing y dependencias
  APEX, en vez de fallar durante el bootstrap. El último análisis fue detenido de
  forma limpia al alcanzar el límite práctico de memoria; no se inició aún la
  compilación de la imagen.
- `prebuilts/sdk/Android.bp` mantiene temporalmente desactivado `extensions_dir` para
  evitar que los servicios YAAP con APIs de extensión 22 se mezclen prematuramente
  con la base AOSP 17. Debe reconciliarse antes del build final.
- La comparación de metadata confirmó que el problema se limita a 12 APIs
  `system-server` exclusivas de la extensión 22 (`service-art`, `service-media-s`,
  `service-permission`, `service-adservices`, `service-healthfitness` y otras).
  No se copiarán artificialmente a `37.0`; deberán generarse o integrarse con una
  release/API baseline propia cuando cerremos el port YAAP.
- Soong confirma que la vía soportada para materializar esa baseline es el flujo
  `update-api`/`<servicio>-update-current-api` de `java_sdk_library`; no existe una
  propiedad `api_dir` aplicable a estos servicios. Ese flujo se ejecutará después
  de obtener un grafo completo estable, para que los archivos generados reflejen
  las fuentes Android 17 reales.
- Se confirmó que los aliases reales incluyen el scope, por ejemplo
  `service-art.stubs.source.system_server-update-current-api`; Soong generó los
  12 aliases esperados en el grafo reducido. Para validar el flujo se sembró la
  baseline DerpFest de `service-art` en `prebuilts/sdk/37.0/system-server/api`,
  usando sus archivos `system-server-current/removed` existentes.
- Se sembraron también las baselines `system-server` de los otros 11 servicios,
  con sus archivos `current`/`removed` del propio módulo e incompatibilidades
  iniciales vacías. El grafo reducido las acepta y registra los 12 targets.
- La ejecución mediante `m` todavía fuerza el índice completo de AOSP y no llega
  a Metalava por presión de memoria; el próximo paso es invocar la generación
  desde el grafo reducido o separar el análisis de los targets API.
- Se compilaron localmente las herramientas host que faltaban para aislar esa
  cadena (`aconfig`, `aconfig-to-metalava-flags`, `merge_zips`, `sbox`,
  `zipsync` y `cp_if_changed`); el JAR de Metalava ya estaba disponible y se
  conectó mediante un lanzador local. El target de `service-art` avanzó hasta
  las reglas Aconfig, donde Soong aún detiene la ejecución por la validación
  de `prebuilt_libstd`; esto es un bloqueo del grafo host reducido, no del
  código de `miami`.
- Se sincronizó desde AOSP `prebuilts/rust-toolchain/linux-x86`, variante glibc,
  con toolchains 1.91.1–1.93.1 (aproximadamente 6,7 GB). `prebuilt_libstd` ya
  queda resuelto y la cadena avanza hasta Java/protobuf/HIDL. El siguiente
  host tool pendiente es `hidl-gen`; su módulo está en
  `system/tools/hidl/Android.bp` y aún requiere dependencias auxiliares en el
  índice reducido.
