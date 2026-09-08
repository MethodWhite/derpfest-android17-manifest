---
status: active
owner: maintainers
updated: 2026-09-08
---
# Estándar YAML

## Reglas

- UTF-8, dos espacios por nivel, sin tabs y líneas de máximo 120 caracteres.
- Un documento por archivo salvo que una herramienta exija múltiples documentos.
- Claves descriptivas en `snake_case` para metadatos propios; conservar nombres oficiales de GitHub Actions/AOSP.
- Citar cadenas que puedan interpretarse como booleanos, números, fechas o expresiones.
- No incluir secretos, tokens, fingerprints privados, rutas personales ni datos del dispositivo.
- Fijar Actions a versiones mayores conocidas y revisar Dependabot mensualmente.

## GitHub Actions

- Declarar permisos mínimos (`contents: read` como base).
- No imprimir entornos completos ni variables secretas.
- Preferir `env` local al job y entradas explícitas.
- Validar YAML y rutas en cada PR.

## Revisión

El workflow `Documentation check` valida archivos esenciales. Las nuevas configuraciones YAML deben incluir propósito, propietario y documentación relacionada.
