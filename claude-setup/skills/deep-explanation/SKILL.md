---
name: "deep-explanation"
description: "Use when BlackDream asks for \"الشرح العميق\" (deep explanation): a vertical video explaining ONE core concept in depth, exam-ready (university-level), one idea per shot."
---

# الشرح العميق (Deep Explanation)

Goal: the learner truly understands ONE central idea well enough to answer exam questions on it. Depth over breadth, no distraction. Output is a VIDEO. These are study explanations, not YouTube clips.

## Content rules
1. **One idea only.** State the central idea in one sentence first ("الفكرة الأساسية"). Everything serves it; side topics are dropped or get one line.
2. **Start from the problem:** why the concept exists, then what it is.
3. **Build in layers:** each shot adds one detail on top of the previous one, in order.
4. **One analogy**, kept consistent.
5. **Animate the mechanism** (data moving, hit/miss, steps), not just text.
6. **Real numbers / worked example** when possible.
7. **Exam corner:** the formula/definition examiners ask about + common mistakes (✗ wrong → ✓ right).
8. **End with a check question.** If he answers, only say correct/incorrect and fix errors (no unprompted hints).

## Shot order
Title → الفكرة الأساسية → المشكلة → التشبيه → details layer by layer (one shot each) → مثال بالأرقام → أخطاء شائعة → سؤال تحقق.
**No closing** (no "صلوا على النبي" / "السلام عليكم") — that is only for YouTube-style videos.

## Visual rules
- Vertical 1080x1920, 30 fps, ~90–120 s for a full topic (test new ideas with 20–30 s clips first).
- Dark background, neon cyan/amber/green, faint circuit traces and very dim code text.
- **ONE idea on screen at a time**, centered: small amber title with underline, main visual in the middle, 1–2 takeaway lines below. No stacked panels top and bottom.
- **Moving background shapes** (outline circles, triangles, squares, hexagons, + signs, dots) drifting and rotating slowly across the whole height. Their clarity depends on distance from the vertical center: sharp and visible near the top/bottom edges, blurred and nearly invisible in the central band (~±230 px). Implement: draw shapes full-res, make a blurred copy (downscale ÷4, blur, upscale), composite sharp/blurred by a vertical mask m = clip((|y−H/2|−230)/520,0,1)^1.3, and multiply alpha by 0.06+0.94·m. Shapes use global time so motion is continuous across shots.
- Arabic explanations; English terms in monospace. Wrap Latin/number runs inside Arabic lines in Unicode isolates (U+2066…U+2069) so order renders correctly.
- Text lines appear one at a time with a short fade/slide.

## Sound (never silent, never music)
- **No music, no drone, no repeating beat.**
- **No sound for text appearing** — no typing clicks, no per-line "tin".
- **Transition between shots/points:** soft airy swoosh = band-passed noise sweeping ~700→3200 Hz over ~0.55 s, smooth rise and fall, no low end, starting ~0.4 s before the cut; plus a very faint high chime (~1318 + 1975 Hz, fast decay) just after the cut. Must never sound like a thud or be startling.
- **Data movement:** shorter, quieter airy swish (~0.35 s).
- **HIT:** soft high two-tone chime. **MISS:** soft low descending tone.
- Mix with fixed gain (no normalization to the loudest event); transitions peak around −18 dB.

## Build notes
Render each shot as its own mp4 (PIL frames piped to ffmpeg, libx264 veryfast, crf 20), fade content in/out inside each shot over the shared background, log sound events with their global times while rendering, synthesize the audio with numpy from that log, concat with -c copy and mux the audio last. Check stills of the busiest moments before the full render.