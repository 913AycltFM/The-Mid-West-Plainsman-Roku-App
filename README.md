# The Mid West Plainsman TV — Roku App

A Roku SceneGraph starter app for **The Mid West Plainsman TV**.

## Current features

- Home screen with Live TV, Latest Videos, Local News, and About Us.
- Live TV attempts HLS playback from the configured stream URL.
- Latest Videos and Local News currently display setup placeholders; they need a public feed or playlist before they can show real items.

## Live stream URL

The current code uses:

`https://tv.913aycltfm.com/memfs/b502bd6f-86eb-4ca0-91c0-f09fb6a8f76e.m3u8`

This URL must remain publicly reachable and return a Roku-compatible HLS stream. If it changes or expires, update it in `components/MainScene.brs`.

## Project structure

- `manifest` — Roku channel metadata
- `source/main.brs` — app entry point
- `components/MainScene.xml` — home screen layout
- `components/MainScene.brs` — menu and video playback behavior

## Test on your Roku

1. Open the Roku device's Developer Application Installer page from a browser on the same network.
2. Sign in with the developer username/password shown by the Roku device.
3. Zip the **contents** of this repository so that `manifest`, `source/`, and `components/` are at the ZIP root. Do not zip the outer repository folder.
4. In the installer, choose **Upload** and select the ZIP file.
5. Choose **Install** to sideload the app to your Roku.

If Roku reports a packaging or compile error, copy the full error message so the source can be corrected.

## Before publishing

- Verify the live stream URL on the Roku device.
- Add real video and local-news feeds to replace the placeholders.
- Add channel artwork and screenshots.
- Test playback, focus behavior, and Back navigation on the target Roku model.
- Package and sign the channel using Roku's developer tools before distribution.
