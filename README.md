<p align="center">
  <a href="https://getklo.com"><img src="https://getklo.com/og.jpg?v=3" alt="klo, the native Mac video editor you talk to" width="720" /></a>
</p>

# klo-mcp: the video editing MCP server

[![npm](https://img.shields.io/npm/v/klo-mcp?color=a8c152)](https://www.npmjs.com/package/klo-mcp)
[![license](https://img.shields.io/badge/connector-MIT-a8c152)](./LICENSE)
![platform](https://img.shields.io/badge/platform-macOS%2013%2B-0a0a0a)
[![site](https://img.shields.io/badge/getklo.com-visit-f1ece5)](https://getklo.com)

Give your coding agent a real video editor.

[klo](https://getklo.com) is a native macOS video editor you talk to. This is
its MCP server: Claude Code, Codex, Cursor, Claude Desktop, or any MCP client
can drive the whole timeline, with 83 tools, while your footage never leaves
your Mac.

- **A real editor underneath.** Not an ffmpeg wrapper: ripple edits, word-gap
  cuts, karaoke captions, color grades, generated music, ProRes export. Every
  edit lands on a normal timeline a human can open and adjust.
- **Media stays local.** Piping video bytes through a text protocol fails
  (base64 versus context windows). klo holds the media on your machine and
  exposes semantic timeline operations instead. The agent sends intent and
  gets back compact results: timecodes, transcripts, real frames when it
  needs to look.
- **Local, token-gated, off by default.** The server listens on
  `127.0.0.1` only, requires a bearer token, and does nothing until you turn
  it on in klo's settings.

## Quickstart

1. [Get klo for Mac](https://getklo.com/api/download) (free tier included,
   macOS 13+).
2. In klo: **Settings → Connections**, turn the connection on, and copy the
   URL and token it shows.
3. Connect your client:

### Claude Desktop (one click)

Download [klo.mcpb](https://getklo.com/klo.mcpb) and open it. Done.

### Claude Code

```sh
claude mcp add --transport http klo http://127.0.0.1:41720/mcp \
  --header "Authorization: Bearer YOUR_TOKEN"
```

Use the exact URL shown in klo's settings (the port can differ if 41720 is
taken).

### Cursor, Codex, and other MCP clients

Either point the client at the HTTP endpoint above, or use this package as a
stdio server:

```json
{
  "mcpServers": {
    "klo": {
      "command": "npx",
      "args": ["-y", "klo-mcp"],
      "env": { "KLO_MCP_TOKEN": "YOUR_TOKEN" }
    }
  }
}
```

## What your agent can do

Ask in plain language, or call tools directly. A few real prompts:

- "Cut the boring parts and the filler words, then caption it word by word."
- "Watch this folder and turn every new recording into a captioned vertical
  clip."
- "Pick the best take of each line from the transcript and assemble the cut."
- "Grade everything to match this reference and export ProRes for the client."

## The 83 tools

| group | tools |
|---|---|
| library | get_project_state, get_media_library, import_media, import_from_url, relink_to_sources, list_files, new_project |
| timeline | add_media_to_timeline, assemble_cut, insert_at, move_clip, split_clip, split_audio, trim_clip, delete_clips, ripple_delete, close_gaps, separate_audio, unlink_clip, link_clips, replace_audio, add_marker, set_in_out, set_track_lock, seek, verify_timeline |
| project | set_canvas_ratio, set_frame_rate, set_brand_kit |
| cuts | add_transition, remove_transition, preview_cut, generate_transition, refine_transition |
| type | add_text, update_text, add_captions_from_transcript, list_text_styles, list_fonts, search_fonts, use_font |
| motion | list_motion_templates, create_motion_clip, update_motion_clip |
| color | set_clip_grade, add_clip_effect, update_clip_effect, remove_clip_effect, list_luts, import_lut, set_clip_opacity, set_clip_blend |
| frame | set_clip_transform, set_clip_speed |
| audio | set_clip_audio, set_volume_envelope, duck_audio, analyze_audio, quantize_cuts_to_beats, isolate_voice_on_clip, measure_audio, measure_mix |
| generate | generate_music, generate_sfx, generate_voiceover, clone_voice_from_clip, fix_spoken_line, generate_video |
| read | get_transcript, find_repeated_takes, capture_frame, survey_footage, measure_frame, measure_clip |
| remember | write_footage_notes, get_footage_notes, analyze_reference, save_style_profile, list_style_profiles, apply_style_profile |
| out | delegate_research, web_search, export_video |

## Pricing

Driving the timeline over MCP is free: your agent brings its own model. The
handful of tools that generate new media (music, voiceover, generated shots)
use your klo account's credits, and the agent is told the price before it
spends. New accounts get 10 free asks.

## Security notes

- Listens on `127.0.0.1` only. Nothing is exposed to the network.
- Bearer token auth with constant-time comparison. Rotate the token from
  klo's settings anytime.
- Off by default. If klo is running but the connection is off, the server
  tells your agent exactly that.
- Voice cloning tools are consent-gated in the app.

## Troubleshooting

**"klo is running but is not accepting connections"**: turn the bridge on in
klo → Settings → Connections, then copy the token into `KLO_MCP_TOKEN` (or
the Authorization header for HTTP).

**Port differs from 41720**: klo falls back to an ephemeral port if the
preferred one is taken. Always trust the URL shown in Settings.

## About

This package is the thin connector; the editor itself is
[klo](https://getklo.com). The connector mirrors the copy bundled inside the
app, and its major.minor version tracks the app release it shipped with.

## FAQ

**Can Claude Code edit videos?**
With klo installed, yes. Claude Code connects to this server and gains cutting,
captions, grading, generated music and voiceover, and ProRes export on a real
timeline. See [what agentic video editing is](https://getklo.com/blog/agentic-video-editing).

**Is this an ffmpeg wrapper?**
No. Tools operate on klo's timeline (ripple edits, word-gap cuts, undo), and
nothing is re-encoded between steps. [Why that design](https://getklo.com/blog/mcp).

**Does my footage get uploaded?**
No. Media stays on the Mac; the server exchanges timeline operations and
compact results. Details in klo's [privacy policy](https://getklo.com/privacy).

**What does it cost?**
Driving the timeline is free with your own model. Generation tools use klo
account credits. [Pricing](https://getklo.com/#plans).

## Related reading

- [Give your coding agent a real timeline](https://getklo.com/blog/mcp)
- [What is agentic video editing?](https://getklo.com/blog/agentic-video-editing)
- [klo changelog](https://getklo.com/changelog): the app ships several times a week
- [Download klo for Mac](https://getklo.com/api/download)

MIT (this connector). klo is a product of klorah inc.
[getklo.com](https://getklo.com)
