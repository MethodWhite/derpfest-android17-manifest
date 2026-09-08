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

## Validación de configuración

`miami` combina `vendor/holi-qgki_defconfig`, `vendor/ext_config/lineage_moto-holi.config` y `vendor/ext_config/moto-holi-miami.config`. La generación y mezcla de configuración se completó en un output temporal: `CONFIG_ARCH_QCOM=y` y `CONFIG_MIAMI_DTB=y`, pero `CONFIG_MSM_NPU` no queda definido/activado en la configuración efectiva. Además, `CONFIG_MSM_NPU` declara dependencia de `ARCH_QCOM`.

## Decisión

No modificar headers ni aplicar una refactorización especulativa. El ciclo NPU no pertenece al build efectivo de `miami`, por lo que se retira del alcance de la portabilidad. El siguiente análisis debe centrarse en módulos habilitados por los fragmentos `holi`/`miami`.
