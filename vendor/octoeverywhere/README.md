# OctoEverywhere

A separate work, aggregated with this repository. Not covered by this repository's licence.

| | |
| --- | --- |
| Upstream | <https://github.com/QuinnDamerell/OctoPrint-OctoEverywhere> |
| Copyright | Quinn Damerell and the OctoEverywhere contributors |
| Version shipped | 4.6.8 |
| Licence text retrieved | 2026-07-28, from tag `4.6.8` |
| Licence | AGPL-3.0-only, in [LICENSE](LICENSE) |

## What it is

The OctoEverywhere Moonraker companion: the Python application that connects the printer to the
OctoEverywhere service. The `octoeverywhere` plugin runs it as a managed service.

OctoEverywhere is a commercial service. Using this plugin means agreeing to its terms.

## What ships and where it comes from

Nothing of OctoEverywhere's is stored in this repository. The plugin's manifest carries a bake
directive that downloads the upstream release tarball at build time, pinned by URL and sha256, and
places its source tree in the built package:

```text
url     https://github.com/QuinnDamerell/OctoPrint-OctoEverywhere/archive/refs/tags/4.6.8.tar.gz
sha256  f3d7e5198b42d33afa3842dc499ab84142589b37725ae8c725739ed36f64ce29
members OctoPrint-OctoEverywhere-4.6.8/moonraker_octoeverywhere  ->  files/app/moonraker_octoeverywhere
        OctoPrint-OctoEverywhere-4.6.8/octoeverywhere            ->  files/app/octoeverywhere
        OctoPrint-OctoEverywhere-4.6.8/linux_host                ->  files/app/linux_host
        OctoPrint-OctoEverywhere-4.6.8/LICENSE                   ->  files/app/LICENSE
        OctoPrint-OctoEverywhere-4.6.8/pyproject.toml            ->  files/app/pyproject.toml
```

The source is shipped byte for byte as downloaded, with its own `LICENSE` alongside it. Bespok3d
modifies nothing in it. The companion runs from that tree as a source package, which is how upstream
runs it.

## Python dependencies

The companion's Python dependencies are built as wheels at build time from
[`octoeverywhere/requirements.txt`](../../octoeverywhere/requirements.txt) and installed into the
plugin's own virtual environment on the printer. They are separate works too, each under its own
licence; they are listed one row each in
[`octoeverywhere/doc/ATTRIBUTIONS.md`](../../octoeverywhere/doc/ATTRIBUTIONS.md). None of them is
stored in this repository.
