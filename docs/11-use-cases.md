---
status: draft
owner: maintainers
updated: 2026-09-08
---
# Casos de uso

## UC-01 Arrancar la ROM

Actor: usuario. Precondición: bootloader y firmware compatibles. Flujo: flashear artefactos documentados, iniciar Android, completar setup. Éxito: boot completo sin crashloop. Fallos: registrar `S0` con logs y particiones afectadas.

## UC-02 Conectividad diaria

Validar llamadas, datos, Wi‑Fi, Bluetooth, GPS, NFC y USB; cada resultado se registra en [[30-validation-matrix]].

## UC-03 Actualizar

Comparar changelog, respaldar datos, instalar build firmada y verificar rollback/boot. No publicar si falla verificación criptográfica.
