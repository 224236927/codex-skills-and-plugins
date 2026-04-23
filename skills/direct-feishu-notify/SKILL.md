---
name: direct-feishu-notify
description: Use when the user wants Codex to send a direct Feishu message from this Windows machine without routing through Hanako, especially for short notifications, DM pings, images, documents, videos, or audio bubbles.
---

# Direct Feishu Notify

## Overview

This skill sends a Feishu message directly through the Feishu Open Platform API.
It does not depend on the Hanako process being online.

By default it reads Feishu credentials and the default DM target from:

- `config/feishu-config.local.json`

The public repo should include only:

- `config/feishu-config.example.json`
- `config/.gitignore`

Do not commit real Feishu secrets.

The current implementation supports:

- text messages
- interactive cards with markdown body
- images
- generic files and documents
- videos as Feishu `media`
- audio bubbles as Feishu `audio`

If the audio source is not `.opus`, the wrapper converts it with `ffmpeg` before upload.

## When to Use

Use this skill when:

- the user asks for a Feishu notification or DM
- a long-running task reaches a milestone and the user wants a ping
- Codex should send a local file to the user's Feishu directly
- Hanako is closed, removed, or irrelevant to one-way outbound messaging

Do not use this skill when the user did not ask for external messaging.

## Workflow

1. Send a text notification:

```powershell
powershell -ExecutionPolicy Bypass -File "$CODEX_HOME\skills\direct-feishu-notify\scripts\invoke-direct-feishu.ps1" -Message "Task finished."
```

2. Send a markdown card:

```powershell
powershell -ExecutionPolicy Bypass -File "$CODEX_HOME\skills\direct-feishu-notify\scripts\invoke-direct-feishu.ps1" -AsCard -CardTitle "Codex Report" -CardMarkdown "## Summary`n- item 1`n- item 2"
```

3. Send a local file to the default Feishu DM target:

```powershell
powershell -ExecutionPolicy Bypass -File "$CODEX_HOME\skills\direct-feishu-notify\scripts\invoke-direct-feishu.ps1" -FilePath "F:\CodexWorkspace\example.pdf"
```

4. Send a card plus an attachment:

```powershell
powershell -ExecutionPolicy Bypass -File "$CODEX_HOME\skills\direct-feishu-notify\scripts\invoke-direct-feishu.ps1" -AsCard -CardTitle "Build Result" -CardMarkdown "**Status:** success" -FilePath "F:\CodexWorkspace\example.mp4"
```

5. Send an audio bubble:

```powershell
powershell -ExecutionPolicy Bypass -File "$CODEX_HOME\skills\direct-feishu-notify\scripts\invoke-direct-feishu.ps1" -FilePath "F:\CodexWorkspace\voice.mp3" -AsAudioBubble
```

6. Override the default target:

```powershell
powershell -ExecutionPolicy Bypass -File "$CODEX_HOME\skills\direct-feishu-notify\scripts\invoke-direct-feishu.ps1" -Target "ou_xxx"
```

## Return Shape

Return the JSON result from the wrapper and summarize the important fields:

- `target`
- `receive_id_type`
- each sent item with `msg_type`
- `title` for interactive cards
- `message_id`
- `chat_id`
- `converted_audio_path` when audio conversion happened

## Notes

- Default `receive_id_type` is `open_id`.
- This skill has its own config and no longer depends on Hanako files.
- Put real secrets in `config/feishu-config.local.json`, based on `config/feishu-config.example.json`.
- If you need a different app or target, update the local config or pass `-ConfigPath`.
- For readable status reports, prefer `-AsCard` with `-CardTitle` and `-CardMarkdown`.
- Prefer short, transactional notification text.
