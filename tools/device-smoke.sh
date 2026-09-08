#!/usr/bin/env bash
set -euo pipefail

out_dir=${1:-reports/device-$(date +%Y%m%d-%H%M%S)}
mkdir -p "$out_dir"
command -v adb >/dev/null || { echo 'adb no está instalado' >&2; exit 2; }
adb wait-for-device
adb get-state > "$out_dir/state.txt"
adb shell getprop > "$out_dir/getprop.txt"
adb shell 'dumpsys bootstat; dumpsys activity processes' > "$out_dir/boot-services.txt" || true
adb shell 'dumpsys -l | grep -E "vintf|wifi|bluetooth|location|sensor"' > "$out_dir/services.txt" || true
adb shell 'cmd checkvintf 2>&1' > "$out_dir/vintf.txt" || true
adb logcat -d -b all -v threadtime > "$out_dir/logcat.raw.txt"
sed -E 's/(imei|serial.?number|android_id)[=:[:space:]]+[0-9A-Za-z-]+/\1=[REDACTED]/gi; s/(authorization|token|password)[=:[:space:]]+[^[:space:]]+/\1=[REDACTED]/gi' "$out_dir/logcat.raw.txt" > "$out_dir/logcat.txt"
rm -f "$out_dir/logcat.raw.txt"
echo "Reporte generado en $out_dir"
echo 'Ejecuta tools/bug-hunter.sh sobre logcat.txt antes de adjuntarlo.'
