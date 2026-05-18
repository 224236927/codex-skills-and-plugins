# Technique Card System

Use this reference when extracting reusable techniques from a visual reference.

## Core Model

A reference technique library is an execution library, not a note collection. Use **technique package** for a complete reusable mechanism. A package can contain three execution-card families:

- **Edit execution card**: how shots, camera moves, transitions, speed, and motion vectors are arranged.
- **VFX execution card**: how the visual effect is built with layers, masks, mattes, displacement, shaders, typography, particles, light, texture, or compositing.
- **Music execution card**: how music, SFX, source audio, beats, and loudness bind to the edit and VFX.

Do not replace VFX execution cards with edit grammar. If the reference has a visible effect, mask, texture, ripple, distortion, typography treatment, or transition surface, create a VFX execution card and prototype it with HyperFrames, Remotion, Canvas/WebGL, FFmpeg/OpenCV, or pre-rendered mattes.

Use one "big technique package" only when edit, VFX, and music are inseparable. Even then, include explicit `edit`, `vfx`, and `music` sections.

## Execution Card Types

### VFX Execution Card

For visible image processing or compositing: liquid masks, RGB splits, light leaks, glow, texture, film grain, glitch, displacement, energy ripples, ink reveals.

Required VFX fields:

```text
name:
type: VFX execution card
reference source:
reference evidence:
visual goal:
screen context:
layer stack:
mask/matte sources:
motion process:
implementation route: HyperFrames / Remotion / Canvas-WebGL / FFmpeg-OpenCV / pre-rendered matte / hybrid
parameter ranges:
source material requirements:
positive sample path:
attempt log path:
failure modes:
acceptance checks:
do not use when:
production status: disabled / experimental / positive-sample-passed / production-ready
```

Acceptance checks must prove the effect in motion and in dense frames. A prose-only card is not production-ready.

### Typography VFX Execution Card

For animated text, logos, captions, symbols, title cards, kinetic labels, scale bounces, tracking changes, wipe-on text, or word-as-impact.

Typography is still VFX. It needs sampled color, edge texture, motion curve, placement logic, and reference evidence. Default text overlays fail.

### Transition / Edit Execution Card

For A-shot to B-shot joins: black-frame cuts, white-flash hits, match cuts, wipe transitions, occlusion cuts, motion blur cuts, mask reveals, smash cuts.

### Camera / Movement Edit Execution Card

For perceived camera behavior: push-in pressure, pull-back reveal, whip pan, simulated handheld shake, parallax drift, orbit, snap zoom, speed ramp.

### Edit Grammar Execution Card

For multi-shot logic rather than image effects: same-direction action matching, posture progression, gaze chain, reaction chain, parallel montage, motif callback, setup-release.

### Music Execution Card

For local audio-visual relationships: drum-hit flash, source-audio stab, silence break, lyric/title lock, BGM duck-and-return, impact SFX placement.

Required music fields:

```text
name:
type: music execution card
reference source:
reference evidence:
phrase map:
beat / transient map:
peak owner:
source-audio / SFX plan:
ducking plan:
visual-hit bindings:
loudness targets:
rejection conditions:
positive sample path:
production status:
```

### Material-Selection Card

For shot choice rules: what source frames make the technique work, what shots cannot support it, and what visual states to search for.

## Technique Package Required Fields

Every formal technique package should include:

```text
name:
package type:
reference source:
reference evidence:
visual goal:
emotional/narrative function:
execution cards: edit / vfx / music
tool route:
prototype level: A/B/C
positive samples:
negative samples:
failure modes:
acceptance checks:
do not use when:
production notes:
```

If `execution cards` lacks `vfx` for a visible effect or `music` for a sound-picture mechanism, the package is incomplete.

## Example: Liquid Logo Dissolve Reveal

```text
name: Liquid logo dissolve reveal
type: visual effect card / motion card / transition card

visual goal:
Turn a static title/logo into a portal that opens the story world.

screen context:
Title or symbol is already meaningful to the viewer. Best for intro, chapter open, domain/realm change, magic/curse activation.

layer stack:
black base
logo or symbolic text
blue-white highlight layer
liquid/ink mask
pixel displacement or refraction
center anchor text kept readable
next footage revealed through the broken mask

motion/edit process:
1. Establish logo for recognition.
2. Add subtle glow or shimmer.
3. Liquid mask begins eating the logo edges.
4. Distortion increases and breaks letterforms.
5. Footage appears inside or behind the liquid holes.
6. Anchor text holds readability while the rest dissolves.
7. Cut or blend into the first live shot on a music change.

music trigger:
Atmosphere or low layer starts before the logo moves. The reveal lands on a beat, phrase change, or first strong source image.

implementation options:
Remotion/Canvas shader displacement
HyperFrames with CSS/SVG mask and GSAP timing
FFmpeg geq/displace plus glow/noise
pre-rendered alpha matte if live shader is too costly

failure modes:
the mask is random noise rather than liquid
the anchor text becomes unreadable
the reveal has no narrative reason
the effect runs too long and delays the edit
```

## Example: Same-Direction Action Blackout

```text
name: Same-direction action blackout
type: transition card / edit grammar card

visual goal:
Make two different subjects feel like one continuous action.

screen context:
A subject moves left-to-right, right-to-left, up, down, or toward camera, and the next shot has a matching motion vector.

motion/edit process:
A-shot: cut during the fastest part of the action.
Bridge: 1-3 frames black, dark occlusion, or impact frame.
B-shot: continue the same direction and speed class.

music trigger:
Bridge on a beat, short silence, or hit frame. B-shot begins on the next transient or rebound.

source material requirements:
matching direction, similar subject scale, compatible speed, readable action phase.

failure modes:
direction mismatch
bridge too long
B-shot action already finished
subject position jumps too far
```

## Example: Group Posture Progression

```text
name: Group posture progression
type: edit grammar card

visual goal:
Make several characters collectively perform one continuous action.

screen context:
Multiple subjects share a comparable motion: looking up, standing, turning, drawing a weapon, raising a hand, opening eyes.

motion/edit process:
Order clips by completion stage:
1. motion not started
2. slight lift
3. half motion
4. near completion
5. over-peak
6. completed face/pose

music trigger:
Early stages ride smaller subdivisions. Final completed pose lands on the strongest beat, lyric, phrase change, or source line.

failure modes:
stages are out of order
pose family is not actually similar
the final shot does not complete the promise
cuts are equal length and feel mechanical
```
