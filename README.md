# gray-imagegen

Image generation across OpenRouter / OpenAI / xAI / FAL / DeepInfra via env-keyed provider probe. Port of hermes' image_gen plugins.

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
