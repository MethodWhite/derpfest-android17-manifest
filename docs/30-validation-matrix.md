---
status: draft
owner: testers
updated: 2026-09-08
---
# Matriz de validación

| Área | Caso | Resultado | Evidencia | Build |
|---|---|---|---|---|
| Boot | cold boot/reboot | ☐ | | |
| Radio | llamada/SMS/datos | ☐ | | |
| Conectividad | Wi‑Fi/BT/GPS/NFC/USB | ☐ | | |
| Multimedia | cámara/audio/vídeo | ☐ | | |
| Sensores | proximidad/giroscopio/huella | ☐ | | |
| Energía | carga/suspensión/batería | ☐ | | |
| Seguridad | AVB/SELinux/encryption | ☐ | | |

Comando estándar: `tools/device-smoke.sh reports/<build>-<device>`. Un fallo S0/S1 bloquea la release y debe enlazar un Issue.
