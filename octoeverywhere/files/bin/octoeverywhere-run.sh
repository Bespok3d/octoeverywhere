#!/bin/sh
# Launch the OctoEverywhere Moonraker companion. $1 = the plugin's venv, $2 = the plugin dir (both
# expanded by the daemon). The companion takes its config as a urlsafe-base64 JSON arg; we build it
# here with the runtime paths, point it at the local Moonraker, and exec the venv python.
set -e

VENV="$1"
PLUGIN="$2"
APP="$PLUGIN/files/app"
STATE="$PLUGIN/var/octoeverywhere"
CFGDIR="$STATE/config"
LOGDIR="$STATE/logs"
mkdir -p "$CFGDIR" "$LOGDIR" "$STATE/store"

CONF="$CFGDIR/octoeverywhere.conf"
if ! grep -q '\[companion\]' "$CONF" 2>/dev/null; then
  printf '[companion]\nip_or_hostname: localhost\nport: 7125\n' > "$CONF"
fi

JSON=$(printf '{"ConfigFolder":"%s","LogFolder":"%s","LocalFileStoragePath":"%s","ServiceName":"octoeverywhere","VirtualEnvPath":"%s","RepoRootFolder":"%s","IsCompanion":true}' \
  "$CFGDIR" "$LOGDIR" "$STATE/store" "$VENV" "$APP")
B64=$(printf '%s' "$JSON" | base64 | tr -d '\n' | tr '+/' '-_')

export PYTHONPATH="$APP"
export MALLOC_TRIM_THRESHOLD_=65536
export MALLOC_ARENA_MAX=2
exec "$VENV/bin/python3" -m moonraker_octoeverywhere "$B64"
