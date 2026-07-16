# octoeverywhere

Standalone Bespok3d plugin: runs the OctoEverywhere Moonraker companion for free remote access + AI
failure detection. Solo repo: publishes a single atom into `Bespok3d/main-index`.

The companion app and its dependencies are baked into the package, so the printer provisions a
per-plugin venv offline and never runs pip or git (ADR-0036). OctoEverywhere is AGPL-3.0 (vendored at
a pinned tag with its LICENSE). Maintained by the Bespok3d org; contact us to claim it if you own it.

## Build locally

Needs Node.js 20+, python3 and curl. Builds run through the shared `Bespok3d/b3-builder` tool:

```sh
sh octoeverywhere/build.sh   # vendors the app modules (pinned tag) + arm64 wheels into files/
npm install github:Bespok3d/b3-builder
npx b3-builder build --source ./octoeverywhere --atom-repo Bespok3d/octoeverywhere
# -> dist/octoeverywhere-<ver>.b3 + dist/octoeverywhere.atom.json
```

## Releasing

Bump `octoeverywhere/manifest.json` `version` and push to `main`. CI runs the `Bespok3d/b3-builder`
Action, which packs the `.b3` and cuts a release; the `register-atoms` action from
`Bespok3d/main-index` then registers the atom. This repo contributes atoms only and publishes no list
of its own. Secret: `MAIN_INDEX_TOKEN` (contents:write on main-index). Signing deferred.
