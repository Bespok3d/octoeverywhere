# Attributions - octoeverywhere

**Plugin author:** Quinn Damerell and the OctoEverywhere contributors, packaged by Bespok3d; OctoEverywhere on the U1 was first done by @QuinnDamerell in the Extended Firmware overlay `65-app-cloud`

Connects the printer to OctoEverywhere's cloud remote access.

| Upstream project | Author | Licence | Needed at runtime | Code ships in this package |
| --- | --- | --- | --- | --- |
| OctoEverywhere 4.6.8 | Quinn Damerell and the OctoEverywhere contributors | AGPL-3.0-only | yes | yes |
| Launcher, from Extended Firmware overlay `65-app-cloud` | the Extended Firmware contributors | GPL-3.0-only | yes | yes |

The OctoEverywhere companion is downloaded at build time at the pinned release tag 4.6.8, pinned by
URL and sha256, and shipped inside the package together with its own LICENSE file. Nothing of
OctoEverywhere's is stored in this repository and Bespok3d modifies nothing in it. The licence text
and the provenance note are in `vendor/octoeverywhere/` at the root of this repository.

The launcher `files/bin/octoeverywhere-run.sh` derives from the Extended Firmware overlay
`65-app-cloud`, credited upstream to @QuinnDamerell. It stays under that overlay's licence,
GPL-3.0-only, and carries its modification notice in its own header. The licence text and the
provenance note are in `vendor/octoeverywhere-launcher/` at the root of this repository.

OctoEverywhere is a commercial service. Using this plugin means agreeing to their terms.

## Python dependencies

Built as wheels at build time from `requirements.txt` and installed into the plugin's own virtual
environment on the printer. Each is a separate work under its own licence. None is stored in this
repository. Licences are as declared by each project in its own package metadata.

| Package | Version | Licence |
| --- | --- | --- |
| anyio | 4.14.2 | MIT |
| certifi | 2026.6.17 | MPL-2.0 |
| charset-normalizer | 3.4.9 | MIT |
| configparser | 7.2.0 | MIT |
| dnspython | 2.8.0 | ISC |
| h11 | 0.16.0 | MIT |
| httpcore | 1.0.9 | BSD-3-Clause |
| httpx | 0.28.1 | BSD-3-Clause |
| idna | 3.18 | BSD-3-Clause |
| octoflatbuffers | 24.3.27 | Apache-2.0 |
| octowebsocket-client | 1.8.3 | Apache-2.0 |
| paho-mqtt | 2.1.0 | EPL-2.0 OR BSD-3-Clause |
| pillow | 12.2.0 | MIT-CMU |
| pyasn1 | 0.6.4 | BSD-2-Clause |
| qrcode | 8.0 | BSD-3-Clause |
| requests | 2.34.2 | Apache-2.0 |
| rsa | 4.9.1 | Apache-2.0 |
| sentry-sdk | 2.66.0 | MIT |
| urllib3 | 2.7.0 | MIT |
