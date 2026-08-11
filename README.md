# octoeverywhere

[![licence](https://img.shields.io/badge/licence-AGPL--3.0-blue)](LICENSE)
[![release](https://img.shields.io/github/v/release/Bespok3d/octoeverywhere)](https://github.com/Bespok3d/octoeverywhere/releases)
[![version](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FBespok3d%2Foctoeverywhere%2Fmain%2Foctoeverywhere%2Fmanifest.json&query=%24.version&label=version&color=blue)](octoeverywhere/manifest.json)
![printer](https://img.shields.io/badge/printer-Snapmaker%20U1-informational)
![stock firmware](https://img.shields.io/badge/stock%20firmware-no%20flashing-brightgreen)

Standalone Bespok3d plugin: runs the OctoEverywhere Moonraker companion for free remote access + AI
failure detection. Solo repo: publishes a single atom into `Bespok3d/main-index`.

The companion app and its dependencies are baked into the package, so the printer provisions a
per-plugin venv offline and never runs pip or git. OctoEverywhere is AGPL-3.0 (vendored at
a pinned tag with its LICENSE). Maintained by the Bespok3d org; contact us to claim it if you own it.

## Build locally

Needs Node.js 20+, python3 and curl. Builds run through the shared `Bespok3d/b3-builder` tool; `--bake`
vendors the app modules (pinned tag) and downloads the arm64 wheels into `files/` before packing:

```sh
npm install github:Bespok3d/b3-builder
npx b3-builder build --source ./octoeverywhere --atom-repo Bespok3d/octoeverywhere --bake
# -> dist/octoeverywhere-<ver>.b3 + dist/octoeverywhere.atom.json
```

## Releasing

Bump `octoeverywhere/manifest.json` `version` and push the tag `plugin-<name>-v<version>` naming
that plugin and that exact number. A push to `main` publishes nothing, and the run is refused if the
tag and the manifest disagree. CI runs the `Bespok3d/b3-builder` Action, which packs the `.b3` and
cuts a release; the `register-atoms` action from `Bespok3d/main-index` then registers the atom. This
repo contributes atoms only and publishes no list of its own. Secrets: `MAIN_INDEX_TOKEN`
(contents:write on main-index) and `REGISTRY_SIGNING_KEY` (the org registry key the `b3-builder`
Action signs each `.b3` and atom with).

## Composition

Bespok3d's own code in this repository is under the repository licence below. The works listed here
are separate works, aggregated with it, each under its own licence. They are not under the repository
licence.

| Component | Licence | Where its licence text is |
| --- | --- | --- |
| OctoEverywhere 4.6.8 | AGPL-3.0-only | [vendor/octoeverywhere/](vendor/octoeverywhere/) |
| Launcher, from the Extended Firmware overlay `65-app-cloud` | GPL-3.0-only | [vendor/octoeverywhere-launcher/](vendor/octoeverywhere-launcher/) |
| The companion's Python dependencies, 19 packages | each as its project declares | [octoeverywhere/doc/ATTRIBUTIONS.md](octoeverywhere/doc/ATTRIBUTIONS.md) |

The OctoEverywhere source and the Python wheels are not stored in this repository. They are fetched
at build time, pinned by URL and sha256, and enter only the built package; each `vendor/` directory
records the exact pin. The launcher is the one file here that derives from third-party code: it ships
at `octoeverywhere/files/bin/octoeverywhere-run.sh` because the package payload root is fixed at
`<plugin>/files`, and it carries its modification notice in its own header.

OctoEverywhere is a commercial service. Using this plugin means agreeing to its terms.

## Licence

Copyright (C) 2026 unlucio and the Bespok3d contributors

This program is free software: you can redistribute it and/or modify it under the terms of the GNU
Affero General Public License as published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without
even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero
General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If
not, see <https://www.gnu.org/licenses/>. The full text is in [LICENSE](LICENSE).

Bespok3d is a project of the Bespok3d Organisation, which is not a legal entity. Copyright is held by
the individual authors named above.

This licence covers Bespok3d's own code. It does not cover the separate works listed under
Composition, which keep their own licences.
