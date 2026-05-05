---
name: anime-hype-amv
description: Use when making, revising, or QAing anime high-energy AMV/montage videos from local episode footage with ffmpeg plus HyperFrames, including BGM selection or timing, beat-synced cuts, source subtitles, original dialogue, impact rendering, title/description drafting, publish exports, and cleanup of AMV project artifacts.
---

# Anime Hype AMV

Goal: produce publish-ready anime hype montage videos, not tech demos. The finished video should have a clear release theme, meaningful source dialogue/subtitles, music that lands on emotional and action beats, and verified output artifacts.

The companion project for this skill is `F:\CodexWorkspace\projects\anime-hype-amv`. Stable examples belong under `examples/`; runtime-heavy or disposable outputs belong under `F:\CodexWorkspace\artifacts\anime-hype-amv`.

## Non-Negotiables

- Start by watching the source material: build contact sheets, extract subtitles, and map candidate scenes before cutting.
- Choose a publishable title/theme before selecting final shots. The montage must prove that theme.
- BGM drives energy, but it must not bury important source dialogue or source subtitles.
- Preserve source subtitles for meaningful original dialogue. Retiming subtitles per clip is mandatory; never burn a full-episode subtitle file directly onto trimmed clips.
- Do not add random variety-show labels. Any text overlay must match the exact meaning of the shot and should be omitted unless it adds force.
- Do not cut in episode title cards, OP/ED cards, blank transitions, or source frames that only exist as navigation filler.
- Do not let the edit become a feature showcase. Rendering effects must serve impact, clarity, or rhythm.
- Before presenting a file, prove the exact output with path, duration, size, SHA256, format, contact sheet, and representative frame checks.
- If the user says not to embed samples in chat, never embed the video in the conversation.

## Rendering Tool Split

Use ffmpeg plus HyperFrames by default.

- Use ffmpeg for the source edit: trimming, speed changes, source audio, source subtitle retiming/burning, BGM retiming/ducking, loudness checks, final muxing, contact sheets, and deterministic publish exports.
- Use the Codex-installed HyperFrames plugin for the design layer: title cards, end cards, typography, motion graphics, glow/sweep accents, beat-reactive overlays, animated labels that match the shot, and complex visual packaging.
- Do not install a separate HyperFrames package/toolchain inside the AMV project unless the user explicitly asks for that. Prefer the existing Codex HyperFrames plugin skills and CLI.
- Keep the anime footage and source subtitles authoritative. HyperFrames overlays must not cover important dialogue subtitles or hide the meaning of the source shot.
- Do not replace a clean ffmpeg cut with HyperFrames just to show the tool. HyperFrames must add publish value: clearer theme, stronger rhythm, better ending, or a more deliberate climax.
- When combining both, render the ffmpeg source cut first, add HyperFrames packaging/overlay layers second, then run final ffmpeg QA and export.

## Core Workflow

1. Inspect the season or requested range:
   - Extract subtitle text and keyword hits.
   - Generate contact sheets over candidate episodes or ranges.
   - Mark high-value beats: fear, despair, decision, reveal, attack, impact, reversal, crowd reaction, aftermath.
   - Reject weak clips early: title cards, static exposition, unmatched dialogue, repeated footage, and shots that only look busy.
2. Choose the cut type:
   - Narrative hype: setup -> pressure -> refusal/despair -> decision -> action -> payoff.
   - Pure impact montage: escalating strong moments with minimal plot, held together by music and visual force.
   - Character tribute: one character's problem, choice, and payoff.
3. Write a cut plan:
   - Each clip must have a purpose: setup, proof, escalation, impact, release, or ending.
   - Keep source-time ranges non-overlapping unless reuse is deliberately justified.
   - Keep original dialogue long enough to complete the line, punchline, reveal, or emotional beat plus a short reaction tail.
   - Use shorter connective clips and longer clips only for irreplaceable dialogue, entrances, emotional turns, or climaxes.
4. Build a music beat map before final timing:
   - Identify intro, first lift, tension bed, pre-drop, drop, peak, break, and ending.
   - Place the strongest music peak on the strongest visual event, not before it.
   - Align music accents to generic visual triggers: a face changes expression, a character decides, a weapon/hand/energy appears, a body launches, an attack releases, impact lands, the crowd reacts, or the scene cuts to silence.
   - If a shot changes from despair to resolve, use the cut or the first resolved expression as the musical lift point.
   - If an action has preparation and release, keep music tension during preparation and let the drop or strongest layer arrive on release/impact.
   - If the current BGM cannot land on the best visual beat, retime the BGM, cut to another section of the track, or use a different BGM. Do not force the scene to accept an early climax.
5. Render for impact:
   - Build the base source timeline with ffmpeg first.
   - Add HyperFrames only for deliberate packaging or complex beat-synced visual layers.
   - Use mild zoom, contrast/saturation, sharpen, flash, shake, speed ramps, or glow only where they support a beat.
   - Shake belongs on impacts, explosions, releases, or panic. It should not run continuously.
   - Flash belongs on hard cuts, reveals, attacks, and impact frames. Keep it short.
   - Keep subtitles readable after crop, zoom, and effects.
   - Force standard platform geometry such as 1280x720 or 1920x1080 with SAR 1:1 and DAR 16:9 unless the user asks otherwise.
6. Finish the ending:
   - Do not hard stop after the last exciting shot.
   - Use a final payoff image, reaction, title echo, or short aftermath shot.
   - Fade or resolve audio inside the actual timeline, not after the video ends.

## BGM Timing Rules

- Think in beats, not just volume. A louder BGM is not automatically more燃.
- Put music changes on meaning changes: fear -> resolve, waiting -> action, attack windup -> release, defeat -> comeback, silence -> crowd eruption.
- A climax that arrives 0.5-2 seconds early usually feels wrong. Move the BGM peak later or move the visual impact earlier.
- A climax that arrives after the visual impact feels weak. Keep pre-drop tension before the action and trigger the peak on the cut/release/impact.
- Under important original dialogue, duck BGM enough that the line is clear; after the line, let BGM recover on the next visual beat.
- When using generated BGM, generate for the chosen theme. Temporary tracks are acceptable only for demos, not for final publishing.

## Source Subtitle Rules

- For each trimmed clip, retime ASS/SRT events so that clip-local time starts at zero.
- Burn only the clip-local subtitle events that belong to that source range.
- Check at least one frame from every original dialogue section after render.
- If subtitles are out of sync, stop and fix retiming before editing rhythm.

## Publish QA

Before calling an AMV ready:

- Contact sheet shows the intended story/energy arc and no title cards.
- Representative frame checks include early setup, first tension beat, pre-climax, climax, ending, and any subtitle-heavy dialogue.
- Final file is unique and unambiguous; do not hand off `latest.mp4`.
- Record exact path, duration, size, SHA256, video format, audio format, and contact sheet path.
- Run at least one full-file loudness check and one climax-range loudness check.
- Confirm the ending fade is visible/audible before the final frame.
- Draft a platform title and description that sell the theme, not the production process.

## Platform Copy

For Bilibili-style release copy:

- Title should be concrete, emotional, and built around the strongest theme or action. Do not mention version numbers, tests, or workflow.
- Avoid vague hype words alone. Pair them with the specific conflict, choice, or payoff.
- Description should be short: one hook sentence, one context sentence if needed, and optional source/work note.
- Do not overpromise if the footage is more emotional than combat-heavy. Match the title to the actual edit.

## Failure Handling

- Feels like a demo: remove decorative effects and rebuild around theme, music beats, and source meaning.
- BGM not踩点: build a beat map, then retime music sections so lifts/drops land on visual meaning changes.
- BGM peak arrives early: delay the peak to the action release or impact frame.
- Source audio/subtitles missing: restore them for important dialogue or choose a shot that works without dialogue.
- Subtitles out of sync: fix clip-local retiming; do not hide the problem with effects.
- Not enough impact: replace weak source shots first, then add rendering effects.
- Ending feels abrupt: add aftermath/reaction/payoff and fade audio/video inside the timeline.
- Too much reused footage: compare source ranges and replace repeated ranges with fresh evidence.
