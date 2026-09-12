# Contribuir

Lee [`docs/00-index.md`](docs/00-index.md), crea o enlaza un Issue y trabaja en una rama `type/scope/description`. Mantén los PRs pequeños, explica riesgo/rollback y adjunta solo evidencia sanitizada.

Las contribuciones asistidas por IA deben seguir [`docs/42-ai-micromodular-contribution-protocol.md`](docs/42-ai-micromodular-contribution-protocol.md): investigar impacto, agrupar correcciones de la misma familia, mantener dependencias explícitas, validar por capas y entregar microcommits revisables.

Antes de solicitar revisión:

- ejecuta las validaciones relevantes;
- actualiza documentación, matriz o ADR;
- verifica `git diff --check`;
- confirma que no hay `source/out`, blobs no autorizados, claves ni datos privados;
- describe el target y el resultado.

Los cambios de device tree, kernel, vendor y CI deben permanecer separados cuando sea posible.
