# OctoEverywhere launcher, derived from the Snapmaker U1 Extended Firmware overlay

A separate work, aggregated with this repository. Not covered by this repository's licence.

| | |
| --- | --- |
| Upstream | <https://github.com/paxx12/SnapmakerU1-Extended-Firmware> |
| Copyright | the Extended Firmware contributors |
| Origin | the `65-app-cloud` overlay, credited upstream to @QuinnDamerell |
| Licence text retrieved | 2026-07-28 |
| Licence | GPL-3.0-only, in [LICENSE](LICENSE) |

## What it is

The shell launcher that starts the OctoEverywhere companion as a service on the printer. Bespok3d's
version derives from the Extended Firmware overlay named above and stays under that overlay's
licence, GPL-3.0-only. It is not relicensed.

## Where the file is

The file ships to the printer, so it lives at its package path rather than in this directory:

```text
octoeverywhere/files/bin/octoeverywhere-run.sh
```

The package payload root is fixed at `<plugin>/files`, so a launcher stored under `vendor/` would
not reach the printer. This directory carries its licence text and this provenance note; the file
itself carries the modification notice in its own header.

## Modification notice

GPLv3 section 5(a) requires a modified work to carry prominent notices stating that it was modified
and the date. That notice is in the header of the file named above. What changed, in one clause: the
launcher was rewritten for the Bespok3d daemon's runtime layout, passing the plugin venv and plugin
directory as arguments and building the companion's configuration from them.
