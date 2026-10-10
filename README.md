<div align="center">
  <img alt="gray-imagegen" src="assets/icon.svg" width="120" height="120" />
  <h1>gray-imagegen</h1>
  <p><strong>Image generation across OpenRouter, OpenAI, xAI, FAL and DeepInfra.</strong></p>
  <p>
    <a href="https://gray.alignment.id">Website</a> ·
    <a href="https://gray.alignment.id/plugins/gray-imagegen">Store</a> ·
    <a href="https://github.com/vstaln/gray-imagegen">Source</a> ·
    <a href="https://github.com/vstaln/gray">gray</a>
  </p>
  <p>
    <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-1c1c20?style=flat-square&labelColor=0a0a0b" /></a>
    <a href="https://www.rust-lang.org"><img alt="Built with Rust" src="https://img.shields.io/badge/built%20with-rust-1c1c20?style=flat-square&labelColor=0a0a0b&logo=rust&logoColor=d4a373" /></a>
    <a href="https://gray.alignment.id/plugins/gray-imagegen"><img alt="gray plugin" src="https://img.shields.io/badge/gray-plugin-1c1c20?style=flat-square&labelColor=0a0a0b&color=7aa2f7" /></a>
  </p>
</div>

<br/>

```bash
gray plugin install gray-imagegen
```

Image generation across OpenRouter / OpenAI / xAI / FAL / DeepInfra, via an
env-keyed provider probe.

A sidecar plugin for [gray](https://github.com/vstaln/gray).

## What it does

- `image_gen` tool: `{prompt, provider?:"auto", model?, size?:"1024x1024", out?:"./image-<ts>.png"}`
- With `provider:"auto"` the first configured backend is tried, in this order:
  | provider | env key | endpoint | default model |
  |---|---|---|---|
  | openrouter | `OPENROUTER_API_KEY` | `openrouter.ai/api/v1/images/generations` | `google/gemini-3.1-flash-image` |
  | openai | `OPENAI_API_KEY` | `api.openai.com/v1/images/generations` | `gpt-image-1` |
  | xai | `XAI_API_KEY` | `api.x.ai/v1/images/generations` | `grok-imagine-image` |
  | fal | `FAL_KEY` | `queue.fal.run` (submit → poll → fetch) | `fal-ai/flux-2/klein/9b` |
  | deepinfra | `DEEPINFRA_API_KEY` | `api.deepinfra.com/v1/openai/images/generations` | `black-forest-labs/FLUX-1-schnell` |
- Per-provider model env override: `<PROVIDER>_IMAGE_MODEL` (e.g. `FAL_IMAGE_MODEL`).
- The reply includes `images` media (base64) so the model sees the image;
  files over 8 MiB are saved but not inlined.
- `/imagegen` shows which providers are configured.

## Wire methods

`plugin/manifest`, `plugin/tools`, `tool/call`, `command/run`, `plugin/shutdown`
— protocol 1.3 (media replies). HTTP via `curl`; no crates beyond `serde_json`.

## Install

```sh
gray plugin install imagegen
```

## Develop

```sh
cargo test
gray account check      # entry point + manifest handshake
gray account publish    # check → build → release → publish to the gray registry
```

## Tags

`gray` `plugin` `imagegen` `rust`

---

Part of the [gray](https://github.com/vstaln/gray) plugin ecosystem —
the open-source AI agent harness. <https://gray.alignment.id>
