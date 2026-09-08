---
status: active
owner: maintainers
updated: 2026-09-08
related: [[35-gitnexus-atomic-work]], [[20-architecture-map]], [[33-bug-hunting]]
---
# Plan de distribución de análisis GitNexus

## Índices y límites

| Alias | Alcance | Política |
|---|---|---|
| `derpfest-miami-main` | gobierno, CI, docs y device trees | índice permanente |
| `derpfest-miami-kernel-build` | build/config del kernel | índice por etapa |
| `derpfest-miami-kernel-gpu-msm` | `drivers/gpu/msm` | índice focalizado |
| `derpfest-miami-kernel-media` | `drivers/media` | crear bajo demanda |
| `derpfest-miami-kernel-power` | energía/reguladores | crear bajo demanda |
| `derpfest-miami-kernel-soc` | integración Qualcomm | crear bajo demanda |

Usar `--workers 2` y `--max-file-size 128` inicialmente. Si el índice supera 2 GB o tarda más de 5 minutos sin progreso, detenerlo y subdividir por directorio/driver.

## Flujo por etapa

1. Crear/seleccionar un alias de un único subsistema.
2. Indexar sin `--embeddings`; activar PDG solo para una función crítica.
3. Registrar nodos, relaciones, clusters, flujos y advertencias de truncamiento.
4. Consultar `context`/`impact` solo sobre símbolos concretos.
5. Crear plan con archivos, consumidores, riesgos y validación.
6. Ejecutar un cambio por commit; correr `detect-changes` antes de confirmar.
7. Refrescar solo el alias afectado y ejecutar la prueba focalizada.

## Interpretación

Advertencias C/C++ sobre candidate caps, propiedades entre lenguajes o flows truncados no prueban ausencia de dependencias. En esos casos la fuente, compilador y logs tienen prioridad sobre el grafo; el plan debe marcar la evidencia como parcial y limitar el blast radius declarado.

## Distribución de recursos

El índice principal se mantiene ligero. Los índices de kernel son temporales/locales y no se suben a GitHub. Cada sesión debe registrar fecha, alias, commit, límites, duración, memoria máxima y resultado.
