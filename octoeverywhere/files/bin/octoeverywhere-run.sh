#!/bin/sh
# Derived from the Snapmaker U1 Extended Firmware overlay 65-app-cloud, credited upstream to
# @QuinnDamerell. Copyright (C) the Extended Firmware contributors. Licensed under GPL-3.0-only; the
# licence text and the provenance note are in vendor/octoeverywhere-launcher/ at the root of this
# repository.
#
# Modified by the Bespok3d project on 2026-07-28: rewritten for the Bespok3d daemon's runtime layout,
# taking the plugin venv and plugin directory as arguments and building the companion configuration
# from them.
#
# Launch the OctoEverywhere Moonraker companion. $1 = the plugin's venv, $2 = the plugin dir (both
# expanded by the daemon). The companion is a SOURCE package: it runs from its repo root (here
# files/app) with that root on PYTHONPATH, exactly as upstream's embedded launcher does
# (py_installer/Service.py sets WorkingDirectory + PYTHONPATH = RepoRootFolder; start-stop-daemon
# cannot set env vars, so it goes inline in a launch script like this one). It takes its config as a
# urlsafe-base64 JSON arg we build here from the runtime paths.
set -e

VENV="$1"
PLUGIN="$2"
APP="$PLUGIN/files/app"
STATE="$PLUGIN/var/octoeverywhere"
CFGDIR="$STATE/config"
LOGDIR="$STATE/logs"

# Fail loud and actionable if the app source did not deploy. The companion is a source package, so a
# missing files/app means the plugin's files never landed (a stale or partial install) and the only
# other symptom is a cryptic "No module named moonraker_octoeverywhere". This message lands in the
# service log, which the app surfaces in the plugin's Captured output / Install log tabs.
if [ ! -f "$APP/moonraker_octoeverywhere/__init__.py" ]; then
  echo "octoeverywhere: app source missing at $APP; reinstall the plugin." >&2
  echo "octoeverywhere: $APP contains: $(ls -A "$APP" 2>/dev/null || echo '<nothing>')" >&2
  echo "octoeverywhere: $PLUGIN/files contains: $(ls -A "$PLUGIN/files" 2>/dev/null || echo '<nothing>')" >&2
  exit 1
fi

mkdir -p "$CFGDIR" "$LOGDIR" "$STATE/store"

CONF="$CFGDIR/octoeverywhere.conf"
if ! grep -q '\[companion\]' "$CONF" 2>/dev/null; then
  printf '[companion]\nip_or_hostname: localhost\nport: 7125\n' > "$CONF"
fi

JSON=$(printf '{"ConfigFolder":"%s","LogFolder":"%s","LocalFileStoragePath":"%s","ServiceName":"octoeverywhere","VirtualEnvPath":"%s","RepoRootFolder":"%s","IsCompanion":true}' \
  "$CFGDIR" "$LOGDIR" "$STATE/store" "$VENV" "$APP")
B64=$(printf '%s' "$JSON" | base64 | tr -d '\n' | tr '+/' '-_')

# Run from the repo root with it on PYTHONPATH (mirrors upstream's WorkingDirectory + PYTHONPATH).
cd "$APP"
export PYTHONPATH="$APP"
export MALLOC_TRIM_THRESHOLD_=65536
export MALLOC_ARENA_MAX=2
exec "$VENV/bin/python3" -m moonraker_octoeverywhere "$B64"
