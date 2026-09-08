---
status: active
owner: maintainers
updated: 2026-09-08
---
# Branching y commits

## Ramas

`main` es estable. Usar `feature/`, `fix/`, `port/`, `docs/`, `build/`, `ci/`, `refactor/` y `release/`.

Formato: `type/scope/descripcion-corta`, por ejemplo `port/miami/android17-api-baseline`.

## Commits

Usar Conventional Commits: `feat(miami):`, `fix(build):`, `port(aosp):`, `docs(process):`, `ci(actions):`, `refactor(tree):`. Un commit debe representar una intención verificable.

No mezclar limpieza masiva, blobs y cambios funcionales en el mismo PR.
