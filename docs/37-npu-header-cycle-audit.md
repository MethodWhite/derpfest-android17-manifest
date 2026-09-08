# Auditoría NPU MSM — resultado

Fecha: 2026-09-08  
Plan: `docs/plans/2026-09-08-gitnexus-plan-audit-npu-header-cycle.md`  
Commit de referencia: `b285fc9`

## Resultado

El ciclo estructural observado es:

`npu_common.h → npu_mgr.h → npu_hw_access.h → npu_common.h`

Los tres headers poseen include guards. El ciclo está confirmado por GitNexus y por lectura directa de los archivos, pero no se ha demostrado que provoque un error de compilación.

## Consumidores identificados

`npu_dev.c`, `npu_mgr.c`, `npu_hw_access.c`, `npu_host_ipc.c`, `npu_debugfs.c` y `npu_dbg.c` incluyen uno o más headers del grupo. El `Makefile` construye `msm_npu.o` con esos objetos cuando `CONFIG_MSM_NPU` está activo.

## Bloqueo de validación

El checkout no contiene `.config` y no se encontró un target de build específico para `miami`. Además, `CONFIG_MSM_NPU` declara dependencia de `ARCH_QCOM`. No se ejecutó una compilación artificial porque podría producir un diagnóstico falso y no representa el kernel objetivo.

## Decisión

No modificar headers ni aplicar una refactorización especulativa. El siguiente paso válido es obtener o generar el target/configuración real del kernel para `miami` y repetir la compilación del módulo NPU. Si la compilación pasa, el ciclo se documentará como benigno; si falla, se preparará una corrección atómica con regresión.
