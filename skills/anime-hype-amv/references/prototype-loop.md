# Prototype Loop

Use this reference for techniques that cannot be reproduced in one pass, especially VFX execution cards for masks, displacement, particles, ripple, liquid, typography, light, texture, shader, or transition surfaces.

## Non-Negotiable For VFX Cards

A VFX execution card is not production-ready until it has a positive sample. Do not integrate it into a full AMV merely because the prose card is clear, the reference analysis is convincing, or an earlier mixed sample was "not bad".

The positive sample must include:

- rendered clip;
- dense frames or frame strip;
- source/reference comparison when a reference exists;
- implementation route: HyperFrames, Remotion, Canvas/WebGL, FFmpeg/OpenCV, pre-rendered matte, or hybrid;
- layer stack and mask/matte source;
- attempt log;
- pass/fail decision.

## Attempt Stages

### v0: Mechanism Proof

Build the simplest 2-5 second test showing the core mechanism:

- mask moves;
- displacement exists;
- transition joins;
- text enters;
- camera move works;
- sound-picture hit lands.

For VFX, use throwaway or neutral footage first if needed. The point is to prove the mechanism before fighting production footage.

Do not polish yet.

### v1: Parameter Calibration

Tune:

- duration;
- motion curve;
- mask intensity;
- blur;
- glow;
- color;
- texture density;
- cut point;
- beat alignment.

### v2: Aesthetic Calibration

Compare dense frames and motion against the reference:

- similar mechanism;
- similar timing feel;
- no accidental cheapness;
- no unreadable subject;
- no over-decoration.

### v3: Production Material Test

Replace test footage with real target footage. Many effects fail only when applied to real faces, subtitles, dark scenes, or high-detail action.

Only v3 can justify use in a formal cut. v0-v2 can justify continued development, not production use.

## Attempt Log

Every B/C-level card should keep a concise attempt log:

```text
attempt:
tool:
input:
change:
result:
failure reason:
next adjustment:
evidence:
```

## Pass Criteria

A prototype can become a formal technique card only if:

- the reference mechanism is visible;
- it works in motion, not just one frame;
- it serves a screen context;
- it does not hide important faces, subtitles, hands, weapons, or impact frames;
- dense frames show intentional layers;
- model review says it is visually equivalent or useful as an adapted substitute.

## Retry Policy

If v0 fails, try a different implementation route.

If v1/v2 fails, adjust parameters and run again.

If v3 fails on production footage, either:

- narrow the material requirements;
- make a source-specific variant;
- downgrade to experimental.

After three serious failed attempts, do not force the technique into production. Record why it failed and choose a visual-equivalent fallback.

If the fallback is only edit grammar, mark the original VFX card as disabled or experimental. Do not pretend the edit grammar fulfills the VFX card.

## Implementation Route Hints

- Use Remotion for timeline-controlled React composition, typed props, reusable components, and frame-accurate still checks.
- Use HyperFrames for HTML/GSAP title cards, captions, overlays, beat-reactive graphics, and shader-like web compositions.
- Use FFmpeg for deterministic trims, filters, geq/displace-style experiments, source audio, subtitle burn-in, and final muxing.
- Use Canvas/WebGL/shaders when the effect is fundamentally displacement, liquid, particles, procedural texture, or per-pixel compositing.
