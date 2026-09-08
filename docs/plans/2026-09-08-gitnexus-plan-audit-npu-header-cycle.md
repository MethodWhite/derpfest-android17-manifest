# GitNexus Engineering Plan

> Task: Auditar el ciclo de inclusión de headers del subsistema NPU MSM antes de cualquier modificación.
> Evidence verified at commit 7359ee590f321f3f585f1535f8801f9343dd02d2; GitNexus index refreshed this session (--index-only), with MSM layer indexed separately.
> Evidence provenance schema 2; global dirty digest `sha256:0a9c85780067d9afcd0764f307b60891e3cee927ee11eaeb5ec7826d10fd82cd`; cited-path manifest: 3 entries; exact generated plan path excluded.

## Objective (§1)

Determinar si el ciclo `npu_common.h → npu_mgr.h → npu_hw_access.h → npu_common.h` es sólo una dependencia protegida por include guards o si provoca una compilación incorrecta, y definir una corrección mínima sólo si existe fallo reproducible.

## Current Behaviour (§2–3)

`npu_common.h` incluye `npu_mgr.h`; `npu_mgr.h` incluye `npu_hw_access.h` y `npu_common.h`; `npu_hw_access.h` incluye `npu_common.h`. Los tres headers tienen guardas. GitNexus detecta el ciclo estructural y relaciona `npu_probe` con `npu_hw_info_init` y acceso hardware; no prueba por sí solo un error de compilación.

## Findings (§4–5)

- [verified] `npu_common.h:7-34` incluye `npu_mgr.h` y define posteriormente tipos del dispositivo.
- [verified] `npu_mgr.h:7-15` incluye `npu_hw_access.h` y `npu_common.h`, formando la arista de retorno.
- [verified] `npu_hw_access.h:7-15` incluye `npu_common.h` aunque declara `struct npu_device` y prototipos propios.
- [graph] El índice `derpfest-miami-kernel-media-msm` detecta dos ciclos NPU y flujos `npu_probe → npu_hw_info_init → npu_reg_write`.
- [inferred] Las include guards pueden hacer el ciclo benigno en algunos órdenes, pero pueden dejar tipos/prototipos incompletos según el header raíz; hace falta compilar consumidores representativos antes de cambiarlo.

## Proposed Changes (§6)

No modificar producción en esta auditoría. Si la reproducción confirma un fallo, preparar una corrección separando declaraciones mínimas y eliminando inclusiones recíprocas, preservando la API y el orden de inicialización.

## Implementation Sequence (§7)

1. Enumerar consumidores directos de los tres headers y sus órdenes de inclusión.
2. Ejecutar una comprobación de preprocesado/compilación sobre el objetivo NPU disponible en el árbol del kernel.
3. Si falla, crear un cambio atómico de headers y repetir la validación; si no falla, documentar el ciclo como benigno y no tocar código.

## Test Strategy (§8)

Usar los comandos de configuración/build del kernel que existan en el árbol; añadir comprobación de compilación para consumidores NPU afectados. Validar además `git diff --check`, ciclos GitNexus y que no cambien símbolos públicos no relacionados.

## Implementation Context (§11)

Primary files: `kernel-motorola-sm6375/drivers/media/platform/msm/npu/npu_common.h`, `npu_mgr.h`, `npu_hw_access.h`. Primary runtime flow: `npu_probe` and hardware access declarations. The graph layer is source-navigation evidence; source ranges above are authoritative.

```json
{"schema_version":2,"head_commit":"7359ee590f321f3f585f1535f8801f9343dd02d2","generated_plan_path":"docs/plans/2026-09-08-gitnexus-plan-audit-npu-header-cycle.md","global_dirty_digest":{"algorithm":"sha256","canonicalization":"gitnexus-evidence-provenance-v2 NUL-framed UTF-8 records","value":"0a9c85780067d9afcd0764f307b60891e3cee927ee11eaeb5ec7826d10fd82cd"},"cited_path_manifest":[{"path":"kernel-motorola-sm6375/drivers/media/platform/msm/npu/npu_common.h","state":"untracked","untracked_digest":"sha256:138ca6bb1da3ba54ba3ec1efc411d39dc4cc7dfd2bed39ece6ee8ef4508b5b91"},{"path":"kernel-motorola-sm6375/drivers/media/platform/msm/npu/npu_hw_access.h","state":"untracked","untracked_digest":"sha256:46ff8f827e5abb67425933f4be4669e9de2b44aa988131121156844b6c883cd5"},{"path":"kernel-motorola-sm6375/drivers/media/platform/msm/npu/npu_mgr.h","state":"untracked","untracked_digest":"sha256:c417356bb0b7d52c652e9bca16f7f63ed2910838125366af374cb7030e1a4c98"}]}
```

## Assumptions and Open Questions (§12)

Assumption: the current checkout is the intended upstream kernel baseline. Open: exact kernel build target and whether the NPU driver is selected for `miami`; no reproducible compiler failure has been supplied. Deferred: broader kernel include-cycle cleanup.

## Definition of Done (§13)

Consumer list and build target identified; cycle classified with source and build evidence; no production change unless a reproducible failure exists; any fix is one atomic commit with regression validation and updated documentation.
