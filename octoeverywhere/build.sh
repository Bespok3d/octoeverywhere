#!/bin/sh
# Bake the OctoEverywhere companion: the app modules at a pinned tag + arm64 wheels for its deps.
# Run in CI (needs python3 + pip). Cross-downloads arm64 wheels on an x86 runner; no compile.
set -e

HERE="$(cd "$(dirname "$0")" && pwd)"
REF="4.6.8"
APP="$HERE/files/app"
WHEELS="$HERE/files/wheels"
WORK="$(mktemp -d)"

curl -fsSL "https://github.com/QuinnDamerell/OctoPrint-OctoEverywhere/archive/refs/tags/${REF}.tar.gz" -o "$WORK/app.tgz"
tar -xzf "$WORK/app.tgz" -C "$WORK"
SRC="$WORK/OctoPrint-OctoEverywhere-${REF}"

mkdir -p "$APP"
for mod in moonraker_octoeverywhere octoeverywhere linux_host; do
  cp -R "$SRC/$mod" "$APP/$mod"
done
cp "$SRC/LICENSE" "$APP/LICENSE" 2>/dev/null || true

mkdir -p "$WHEELS"
python3 -m pip download -r "$HERE/requirements.txt" -d "$WHEELS" \
  --only-binary=:all: --python-version 311 --implementation cp --abi cp311 \
  --platform manylinux2014_aarch64 --platform manylinux_2_17_aarch64 --platform manylinux_2_28_aarch64
echo "baked octoeverywhere app modules (${REF}) + arm64 wheels"
