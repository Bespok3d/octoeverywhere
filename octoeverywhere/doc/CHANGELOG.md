# Changelog

## 0.1.2

- Fixes the missing **Captured output** tab the README sends you to for the one-time OctoEverywhere
  link. The manifest now declares that this plugin's service writes output worth showing, so the store
  offers the tab and tails the link out of the service log.

## 0.1.1

- Promoted to the stable channel: verified on a physical printer.
- Launcher now mirrors upstream's embedded service exactly: runs from the app source root with it on
  PYTHONPATH (`cd` + `PYTHONPATH`, since start-stop-daemon cannot set env). If the app source did not
  deploy it now fails with an actionable message in the service log (surfaced in the Captured output /
  Install log tabs) instead of a cryptic "No module named moonraker_octoeverywhere". The version bump
  also refreshes any cached package from an earlier build.

## 0.1.0

- First release. Runs the OctoEverywhere Moonraker companion (app modules + arm64 wheels baked, pinned
  to 4.6.8) in a per-plugin venv, companion mode against the local Moonraker. First start logs a link
  URL to connect the printer to your OctoEverywhere account. Experimental.
