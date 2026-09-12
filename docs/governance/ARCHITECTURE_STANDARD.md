---
status: active
owner: maintainers
updated: 2026-09-12
related: [[../20-architecture-map]], [[../21-device-porting-checklist]], [[../42-ai-micromodular-contribution-protocol]]
---
# Estándar de arquitectura

La plataforma Android 17 es la capa principal. El soporte de dispositivos se implementa mediante módulos independientes y contratos explícitos.

## Capas

```text
platform / DerpFest
        ↓ contratos Android
device-common → device-specific
        ↓ interfaces de hardware
kernel / vendor / proprietary
```

Cada capa debe declarar sus dependencias, evitar ciclos y poder validarse de forma aislada. Las configuraciones comunes pertenecen al árbol common; las excepciones específicas permanecen en el dispositivo.

## Reglas

- Preferir módulos pequeños y reutilizables.
- No duplicar lógica para resolver diferencias de dispositivos.
- No ocultar errores desactivando componentes requeridos.
- Mantener nombres, interfaces y rutas compatibles con upstream cuando sea posible.
- Cambios cross-layer se separan en microcommits ordenados.
