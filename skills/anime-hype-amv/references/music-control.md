# Music Control Scheme

Use this reference when music timing, BGM choice, source audio, or sound-picture relation matters.

Music is the global timeline skeleton. It must be represented as a **music execution card** or equivalent project-local music plan, not as a small `music trigger` line inside an edit/VFX card.

## Music Execution Card

Use this structure when a cut depends on BGM, SFX, source audio, lyrics, silence, or ducking:

```text
name:
type: music execution card
BGM source / generation prompt:
phrase map:
beat / transient map:
energy curve:
peak owner:
source-audio / SFX plan:
ducking plan:
visual-hit bindings:
loudness targets:
ending resolution:
rejection log:
positive sample path:
production status:
```

If the music execution card is missing, the edit has no time skeleton. Do not compensate by adding more cuts, flashes, or text.

## Required Maps

### Phrase Map

Mark the broad structure:

```text
intro
first lift
tension bed
pre-drop
drop
peak
break
secondary rise
ending / tail
```

Do not infer structure from volume alone. Use instrumentation, rhythm density, silence, lyric entry, bass entry, and harmonic changes.

### Beat / Transient Map

Mark local edit anchors:

```text
kick
snare / clap
bass transient
silence gap
fill
vocal syllable
impact SFX
source line ending
```

### Energy Curve

Describe what the music asks the edit to do:

```text
pressure rising
hold tension
release
breath
accelerate
collapse
resolve
```

## Binding Visuals To Music

Place the strongest visual event on the strongest meaningful music event:

- attack release, not just attack preparation;
- expression shift, not the neutral face before it;
- source line ending, not mid-syllable;
- reveal frame, not the setup frame;
- result/reaction when the music resolves.

If visual impact arrives 0.5-2 seconds before the music peak, retime either the music or the shot. Do not let the climax peak early.

When a VFX execution card has an impact frame, the music execution card must name the exact beat/transient that owns it. "On the drop" is too vague unless the drop frame is mapped.

## Source Audio

Source audio is a separate layer, not an afterthought.

Use source audio when it adds:

- a meaningful line;
- breath/pain/impact;
- spell/activation/crowd reaction;
- silence contrast;
- recognizable scene texture.

Duck BGM under important source audio, then restore it on the next visual or musical node.

## Music Acceptance Checks

Before calling music usable, answer:

- What is the phrase map?
- Where is the strongest peak?
- Which visual event owns that peak?
- Where does BGM duck for source audio?
- Does the ending resolve inside the timeline?
- Does the track force repeated or unnatural cuts?
- Does high-frequency density bury subtitles, voices, or visual detail?

## When To Reject Or Regenerate BGM

Reject or regenerate when:

- the peak cannot land on the strongest visual event;
- the track has no usable phrase changes;
- it is too flat dynamically for tension/release;
- it fights important source audio;
- it makes the edit feel like a demo even when visual timing is correct;
- the user explicitly dislikes it.
