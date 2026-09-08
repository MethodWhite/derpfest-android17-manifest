#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 || ! -f "$1" ]]; then
  echo "Uso: $0 LOG_SANITIZADO" >&2
  exit 2
fi

log_file=$1
echo "Analizando: $log_file"
echo "--- indicadores de crash/boot ---"
rg -ni 'fatal exception|watchdog|kernel panic|avc: denied|tombstone|segfault|bootloop|crash|anr' "$log_file" || true
echo "--- indicadores de radio/conectividad ---"
rg -ni 'modem|ril|ims|wlan|bluetooth|nfc|gps|sensor' "$log_file" || true
echo "--- privacidad ---"
if rg -ni 'imei|serial.?number|BEGIN .* PRIVATE KEY|authorization: bearer|password=' "$log_file"; then
  echo 'ERROR: el archivo contiene posibles datos sensibles; no adjuntarlo.' >&2
  exit 1
fi
echo 'OK: análisis terminado; revisar coincidencias y adjuntar solo evidencia sanitizada.'
