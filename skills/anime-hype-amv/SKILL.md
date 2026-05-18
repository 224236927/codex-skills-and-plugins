---
name: anime-hype-amv
description: Use when making, revising, QAing, or reference-studying anime high-energy AMV/montage videos from local footage or approved still/image sequences with ffmpeg plus HyperFrames/Remotion, including BGM timing, beat-synced cuts, source subtitles, original dialogue, impact rendering, reference technique-library extraction, edit/VFX/music execution cards, prototype attempts, title/description drafting, publish exports, and cleanup of AMV project artifacts.
---

# Anime Hype AMV

Goal: produce publish-ready anime hype montage videos, not tech demos. The finished video should have a clear release theme, meaningful source dialogue/subtitles, music that lands on emotional and action beats, and verified output artifacts. When a reference video is involved, convert its feeling into reusable execution cards and production evidence, not loose verbal imitation.

Skill folders hold methods and templates only. Project outputs belong in the active workspace, for example `docs/amv-technique-library/` for durable technique libraries and `artifacts/analysis/...` for dense frames, prototypes, and attempt logs.

## Required Reading And Reference Loading

Before making, revising, QAing, or reference-studying any anime AMV / hype montage / mixed-cut video on this machine, check for and read the local execution note when it exists in the active project:

`references/混剪笔记.md`

This note is mandatory, not optional background. Use it as the style-selection and consistency entrypoint before writing a cut plan. If it is absent, say it is absent and continue with this skill's core workflow. In particular:

- Choose one primary style grammar for the cut and at most 1-2 auxiliary segment functions.
- Use the 烟季 / Century AMV ten-chapter style library in that note as a selection reference, not as a template to copy.
- Keep any accepted sample videos out of the main method note unless they add a new transferable rule.
- Translate subjective user language into observable evidence before making edit decisions.

This skill also has a reference technique-library module. Every agent using this skill must know that the library exists and must load the relevant reference file when the trigger condition appears:

- Read `references/technique-card-system.md` before creating, updating, selecting, or applying technique cards; before extracting reference transitions, edit grammar, camera moves, masks, texture treatments, typography, VFX, or motion techniques; and before comparing a new cut against a reference video's visual language.
- Read `references/music-control.md` before choosing or generating BGM, building a beat or phrase map, deciding source-audio/dialogue ducking, checking whether music helps the picture, or responding to feedback that the music "does not work".
- Read `references/prototype-loop.md` before attempting any technique that may not reproduce in one pass, including Remotion, HyperFrames, FFmpeg filter, shader, mask, distortion, ripple, shake, glow, typography, or transition samples; also read it when a generated sample looks wrong and needs retry criteria.

Do not treat these reference files as optional reading after the fact. Load them before making the decision they govern.

## Technique Library Contract

Do not let "technique card" collapse into a剪辑大纲. The project-level technique library is an execution library for making specific effects, edits, and sound-picture systems with tools such as HyperFrames, Remotion, Canvas/WebGL shaders, FFmpeg/OpenCV filters, masks, mattes, and audio tooling.

Use **technique package** for a complete reusable mechanism. A package may contain one or more execution cards:

- **Edit execution card**: shot order, action-vector matching, camera move, speed ramp, transition timing, cut-point rules, and dense-frame proof.
- **VFX execution card**: visual layers, masks/mattes, displacement, particles, texture, light-source logic, typography, implementation route, parameter ranges, and positive sample proof.
- **Music execution card**: phrase map, beat/hit map, peak owner, source-audio/SFX plan, ducking, loudness targets, and sound-picture bindings.

For a complex visual reference, prefer a technique package with separate edit/VFX/music execution cards instead of one vague "big card". Use a single big card only when the technique cannot be separated without losing its mechanism, and still include the edit, VFX, and music subsections explicitly.

Hard rule: a visual technique is not usable in production until its VFX execution card has a positive sample or an explicit "disabled/experimental" status. Written analysis, Gemini approval of prose, or a negative sample is not enough. If the VFX card has no accepted positive sample, do not smuggle the effect into a full cut.

## Reference Technique Library Workflow

Use this module when the user says to reference, deeply learn, imitate the feeling of, build a technique library from, or compare against a video style. This is not ordinary Bilibili summarization. Acquisition tools may fetch the reference, but this skill owns the creative extraction.

Process:

1. Dense-view the reference in tiers:
   - whole video contact sheet for structure;
   - 6-12 fps strips for candidate transitions, typography, masks, camera moves, and high-energy segments;
   - frame-by-frame strips for complex effects or fast transitions;
   - waveform/beat/phrase map when music drives timing.
2. Build an event ledger before judging:
   - time range;
   - screen change;
   - emotional or narrative function;
   - technique category;
   - music/audio trigger;
   - evidence path;
   - confidence.
3. Convert reusable mechanisms into technique packages and execution cards. `references/technique-card-system.md` is required reading for package/card structure.
4. Keep music planning as an execution card, not as a footnote inside visual cards. `references/music-control.md` is required reading for BGM selection, phrase maps, source audio, ducking, and sound-picture binding.
5. Prototype hard techniques instead of only describing them. `references/prototype-loop.md` is required reading for v0-v3 attempts, retry policy, and pass/fail criteria. VFX-heavy packages must produce positive visual samples before full-cut use.
6. Store project outputs in the active project, not in this skill:
   - durable library: `docs/amv-technique-library/`;
   - reference cases: `docs/amv-technique-library/cases/`;
   - technique cards: `docs/amv-technique-library/techniques/`;
   - dense frames/prototypes/attempt logs: `artifacts/analysis/<reference-or-project>/`.

Reference study terminology:

- Use "build a reference technique-library case" for one reference video.
- Use "technique package" for one complete reusable mechanism that may combine edit, VFX, and music.
- Use "execution card" for one actionable slice of a package: edit, VFX, or music.
- Use "prototype attempt" for a short Remotion/HyperFrames/FFmpeg/shader sample that tests whether a B/C-level technique can be visually reproduced.

When a reference video is involved, create or update a project-local reference technique-library case before using its style in production. When a final cut borrows a nontrivial visual, motion, transition, edit, mask, texture, typography, camera, or music-picture device, bind that timeline choice to an accepted execution card or explain why it is a one-off exception. Do not treat a剪辑语法 card as proof that the visual effect itself exists.

## Non-Negotiables

- Start by watching the source material: build contact sheets, extract subtitles, and map candidate scenes before cutting.
- If a reference video is involved, the cut must be guided by a project-local technique-library case, not by memory or vague taste words alone.
- Choose a publishable title/theme before selecting final shots. The montage must prove that theme.
- BGM drives energy, but it must not bury important source dialogue or source subtitles.
- Preserve source subtitles for meaningful original dialogue. Retiming subtitles per clip is mandatory; never burn a full-episode subtitle file directly onto trimmed clips.
- Do not add random variety-show labels. Any text overlay must match the exact meaning of the shot and should be omitted unless it adds force.
- Do not cut in episode title cards, OP/ED cards, blank transitions, or source frames that only exist as navigation filler.
- Do not let the edit become a feature showcase. Rendering effects must serve impact, clarity, or rhythm. Conversely, do not hide weak VFX behind剪辑语言; if the user asked for a technique library, build real VFX/mask/motion samples.
- Treat a requested formal cut as a publish candidate, not a preview. Iterate privately until dense frame checks and motion checks look acceptable before showing it to the user.
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
   - If BGM choice, generated music, phrase structure, source audio, or music-picture binding affects the cut, read `references/music-control.md` before locking timing.
   - Identify intro, first lift, tension bed, pre-drop, drop, peak, break, and ending.
   - Place the strongest music peak on the strongest visual event, not before it.
   - Align music accents to generic visual triggers: a face changes expression, a character decides, a weapon/hand/energy appears, a body launches, an attack releases, impact lands, the crowd reacts, or the scene cuts to silence.
   - If a shot changes from despair to resolve, use the cut or the first resolved expression as the musical lift point.
   - If an action has preparation and release, keep music tension during preparation and let the drop or strongest layer arrive on release/impact.
   - If the current BGM cannot land on the best visual beat, retime the BGM, cut to another section of the track, or use a different BGM. Do not force the scene to accept an early climax.
5. Render for impact:
   - If the render uses nontrivial transitions, camera moves, masks, typography, texture treatment, VFX, or edit grammar, read `references/technique-card-system.md` before choosing the technique.
   - If an effect or transition does not clearly work on the first pass, read `references/prototype-loop.md`, make short samples, and retry against visual pass/fail criteria before committing it to the final cut.
   - Build the base source timeline with ffmpeg first unless the requested technique is itself a HyperFrames/Remotion/Canvas visual composition.
   - Use HyperFrames, Remotion, Canvas/WebGL, FFmpeg/OpenCV, or pre-rendered mattes deliberately for VFX execution cards. Record which route was used and why.
   - For masks, displacement, typography, particles, ripple, liquid, light, or texture effects, make a short positive sample before integrating into a full cut.
   - Use mild zoom, contrast/saturation, sharpen, flash, shake, speed ramps, or glow only where they support a beat.
   - Shake belongs on impacts, explosions, releases, or panic. It should not run continuously.
   - Flash belongs on hard cuts, reveals, attacks, and impact frames. Keep it short.
   - Vary camera motion and transitions by shot meaning. Do not loop the same two or three moves across the whole film unless the repetition is an intentional motif.
   - For still-image or motion-comic montages, inspect each image for real or implied light sources before adding glows, lantern flicker, lightning, rim light, or bloom. Do not let the effect make the character glow unless that is the shot's actual meaning.
   - For rain, snow, smoke, sparks, or similar particles, match direction, speed, density, depth, and duration to the shot. Do not leave weather running across dialogue or closeups where it distracts from the face.
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
- For effect-heavy cuts, generate dense frame sheets from the final muxed video, plus short motion strips for risky effects such as rain, lightning, glow, shake, speed ramps, or wipes. If the stills cannot reveal the problem, extract adjacent frames or short strips until the motion is visible.
- Check lighting and particles against the actual image content: light source placement, face edges, occlusion, weather direction, and whether effects appear only where the shot needs them.
- Final file is unique and unambiguous; do not hand off `latest.mp4`.
- Record exact path, duration, size, SHA256, video format, audio format, and contact sheet path.
- Run at least one full-file loudness check and one climax-range loudness check.
- Confirm the ending fade is visible/audible before the final frame.
- Draft a platform title and description that sell the theme, not the production process.

## Platform Copy

For Bilibili-style release copy:

- Title should be concrete, emotional, and built around the strongest theme or action. Do not mention version numbers, tests, or workflow.
- Avoid vague hype words alone. Pair them with the specific conflict, choice, or payoff.
- Description should sound like a viewer-facing post, not a production note. Keep it short: one atmospheric hook, one emotional/context sentence if needed, and optional source/BGM notes.
- Do not explain fixes, render choices, QA, or internal criticism in the public description.
- Do not overpromise if the footage is more emotional than combat-heavy. Match the title to the actual edit.

## Failure Handling

- Feels like a demo: remove decorative effects and rebuild around theme, music beats, and source meaning.
- BGM not踩点: build a beat map, then retime music sections so lifts/drops land on visual meaning changes.
- BGM peak arrives early: delay the peak to the action release or impact frame.
- Weather looks fake: reduce it, localize it, or rebuild it with coherent direction and depth; do not keep a weak full-screen particle layer just because the theme includes weather.
- Lighting is off target: make a per-shot light-source pass and remove effects from shots where the source is unclear or the face becomes visibly self-luminous.
- Motion or transitions feel shallow: rewatch the shot sequence and assign movement by purpose, such as reveal, pursuit, pressure, impact, breath, or aftermath, instead of cycling presets.
- Source audio/subtitles missing: restore them for important dialogue or choose a shot that works without dialogue.
- Subtitles out of sync: fix clip-local retiming; do not hide the problem with effects.
- Not enough impact: replace weak source shots first, then add rendering effects.
- Ending feels abrupt: add aftermath/reaction/payoff and fade audio/video inside the timeline.
- Too much reused footage: compare source ranges and replace repeated ranges with fresh evidence.
