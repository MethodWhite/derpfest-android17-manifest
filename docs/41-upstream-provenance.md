# Procedencia y atribuciones

Este repositorio coordina una integración de DerpFest Android 17. La capa de
integración, documentación, automatización y parches propios se distribuye bajo
Apache-2.0, salvo que un archivo indique otra licencia.

## Fuentes upstream

- DerpFest: https://github.com/DerpFest-AOSP
- Manifiesto Android 17: https://github.com/DerpFest-AOSP/android_manifest/tree/17
- AOSP: https://android.googlesource.com/
- LineageOS y proyectos de terceros: cada repositorio conserva su licencia,
  copyright, historial y atribuciones originales.

## Reglas de migración

1. No copiar ni relicenciar código upstream sin conservar sus avisos legales.
2. Registrar el repositorio, rama, commit base y motivo de cada adaptación.
3. Mantener separados los cambios de plataforma, DerpFest y soporte de
   dispositivos.
4. No incluir blobs propietarios, credenciales, artefactos de compilación ni
   dumps del dispositivo.
5. Las licencias del código upstream prevalecen sobre la licencia de esta capa
   de coordinación.

Los cambios específicos de Android 17 se documentan junto con su validación en
`docs/` y en el historial de commits.
