# OctoEverywhere

Free, secure remote access to your printer from anywhere, with AI print-failure detection and remote
notifications, through the [OctoEverywhere](https://octoeverywhere.com) cloud. This runs the official
OctoEverywhere **Moonraker companion** agent on your printer.

## Setup (connect your printer)

1. Install the plugin. The agent starts automatically as a service in its own isolated Python
   environment.
2. Open the **[Captured output](b3d://bespok3d/octoeverywhere#captured)** tab. A few seconds after the
   agent starts it logs a **one-time setup link**, which appears there automatically. You do not have
   to be watching: the link is **saved and kept** for you, so it is always there when you come back.
3. Find the link ending in `octoeverywhere.com/getstarted?printerid=...` and click **Open in browser**
   next to it (or **Copy** it onto another device).
4. Sign in or create a free OctoEverywhere account in the browser to finish linking the printer. The
   account is free; a paid plan is optional.

That is all. No SSH, no log digging: the setup link is captured and shown for you.

> The Captured output tab **remembers every link** the agent logs, so you never miss it, even days
> later. The setup link itself is one-time and usually stops working after you use it to connect, but
> the captured entry stays for your reference. If nothing appears yet, give the agent a few more
> seconds and reopen the tab, or check the **Install log** tab for errors.

## How it is packaged

The companion app source (pinned to a known release) and all of its Python dependencies (as arm64
wheels) are baked into the package in CI. On the printer the daemon creates a per-plugin virtual
environment and installs them offline; the printer never runs `pip` or `git` (ADR-0036). It runs in
companion mode, talking to the local Moonraker on `localhost:7125`.

## Status

Device-verified on the Snapmaker U1: the agent connects and the setup link is captured in-app.

## License

OctoEverywhere is AGPL-3.0; its source is vendored at the pinned tag with its `LICENSE` included.
