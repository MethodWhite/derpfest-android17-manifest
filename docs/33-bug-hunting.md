---
status: active
owner: QA maintainers
updated: 2026-09-08
related: [[04-bug-reporting]], [[30-validation-matrix]], [[32-ci-cd]]
---
# Bug hunting y respuesta rápida

## Capas de detección

1. **Pre-commit/PR:** diff, YAML, secretos, rutas prohibidas y documentación.
2. **CI:** tests focalizados, compilación de scripts y revisión de manifests.
3. **Nightly/upstream:** detectar cambios de dependencias y regresiones del port.
4. **Dispositivo/emulador:** boot, logcat, kernel, VINTF y matriz funcional mediante job manual o runner controlado.
5. **Release:** smoke test obligatorio, hashes y comparación contra la última release estable.

## Respuesta

Un fallo reproducible abre Issue con `bug`, severidad y evidencia sanitizada. S0/S1 bloquea releases; S2 entra al siguiente ciclo; S3 se agrupa con mejoras. Cada fix debe añadir una prueba o una condición de regresión.

## Privacidad

No subir logcat sin sanitizar, IMEI, números telefónicos, tokens, dumps de usuario ni imágenes de particiones. Los artefactos CI deben tener retención limitada y solo contener información reproducible.
