# octoeverywhere

Standalone Bespok3d plugin: runs the OctoEverywhere Moonraker companion for free remote access + AI
failure detection. Solo repo - publishes a single atom into `Bespok3d/main-index`.

CI bakes the companion app modules (pinned tag) + its arm64 wheels (`build.sh`), then packs the `.b3`;
the printer provisions a per-plugin venv offline (ADR-0036). OctoEverywhere is AGPL-3.0 (vendored at the
pinned tag with its LICENSE). Maintained by the Bespok3d org; contact us to claim it if you own it.
