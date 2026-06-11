#!/bin/sh
# Bake the OctoEverywhere companion into the plugin so the printer fetches nothing: the app modules at
# a pinned tag (files/app, the companion runs from this source tree) plus arm64 wheels for its deps
# (files/wheels). IDEMPOTENT: it skips work already done, so the monorepo packer and CI can both run it
# on every pack without re-fetching. Needs python3 + pip + curl; cross-downloads arm64 wheels on an x86
# runner (no compile). Set B3D_FORCE_BAKE=1 to re-bake from scratch (e.g. after bumping REF).
set -e

HERE="$(cd "$(dirname "$0")" && pwd)"
REF="4.6.8"
APP="$HERE/files/app"
WHEELS="$HERE/files/wheels"
MODULES="moonraker_octoeverywhere octoeverywhere linux_host"

app_baked() {
  # The companion runs from this tree as its repo root: besides the module packages it reads
  # pyproject.toml at the root to parse its own version (linux_host/version.py), so that file is
  # part of a complete bake.
  [ -f "$APP/pyproject.toml" ] || return 1
  for mod in $MODULES; do
    [ -f "$APP/$mod/__init__.py" ] || return 1
  done
  return 0
}

bake_app() {
  work="$(mktemp -d)"
  curl -fsSL "https://github.com/QuinnDamerell/OctoPrint-OctoEverywhere/archive/refs/tags/${REF}.tar.gz" -o "$work/app.tgz"
  tar -xzf "$work/app.tgz" -C "$work"
  src="$work/OctoPrint-OctoEverywhere-${REF}"
  rm -rf "$APP"
  mkdir -p "$APP"
  for mod in $MODULES; do
    cp -R "$src/$mod" "$APP/$mod"
    [ -f "$APP/$mod/__init__.py" ] || { echo "build.sh: $mod missing after copy" >&2; exit 1; }
  done
  cp "$src/LICENSE" "$APP/LICENSE" 2>/dev/null || true
  # The companion parses its version from pyproject.toml at the repo root (linux_host/version.py).
  cp "$src/pyproject.toml" "$APP/pyproject.toml"
  [ -f "$APP/pyproject.toml" ] || { echo "build.sh: pyproject.toml missing after copy" >&2; exit 1; }
  rm -rf "$work"
}

if [ -n "${B3D_FORCE_BAKE:-}" ] || ! app_baked; then
  bake_app
  echo "baked octoeverywhere app modules (${REF})"
else
  echo "octoeverywhere app modules already baked; skipping"
fi

if [ -n "${B3D_FORCE_BAKE:-}" ] || [ -z "$(ls -A "$WHEELS" 2>/dev/null)" ]; then
  mkdir -p "$WHEELS"
  python3 -m pip download -r "$HERE/requirements.txt" -d "$WHEELS" \
    --only-binary=:all: --python-version 311 --implementation cp --abi cp311 \
    --platform manylinux2014_aarch64 --platform manylinux_2_17_aarch64 --platform manylinux_2_28_aarch64
  echo "baked octoeverywhere arm64 wheels"
else
  echo "octoeverywhere wheels already baked; skipping"
fi
