# OctoEverywhere

Free, secure remote access to your printer from anywhere, with AI print-failure detection and remote
notifications, through the [OctoEverywhere](https://octoeverywhere.com) cloud. This runs the official
OctoEverywhere **Moonraker companion** agent on your printer.

## Setup

1. Install the plugin. The agent starts as a service in its own isolated Python environment.
2. On first start it logs a **one-time link URL**. Find it in the service log and open it to connect
   the printer to your OctoEverywhere account (a free account works).

OctoEverywhere is an external cloud service; this plugin only runs the agent that connects to it.

## How it is packaged

The companion app modules (pinned to a known release) and all of its Python dependencies (as arm64
wheels) are baked into the package in CI. On the printer the daemon creates a per-plugin virtual
environment and installs them offline; the printer never runs `pip` or `git` (ADR-0036). It runs in
companion mode, talking to the local Moonraker on `localhost:7125`.

## Status

**Experimental**, not yet verified on a physical printer.

## License

OctoEverywhere is AGPL-3.0; its source is vendored at the pinned tag with its `LICENSE` included.
