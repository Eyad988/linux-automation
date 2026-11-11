---
name: tech-explainer
description: Use when BlackDream asks for "الصيغة التقنية" or "الشرح التقني" (also the older names "صيغة لينيكس" / "لينيكس"), a short vertical explainer video on any tech topic in his neon-circuit style.
---

# الصيغة التقنية (Tech Explainer)

A short, punchy vertical explainer video on a tech topic (Linux, commands, tools, programming ideas). It works like a YouTube Short, so it ends with a closing.

## Content
- About 25 to 30 seconds. Shots: title, what it is, how it works or a real example (a command and its output in a terminal), one takeaway line, closing.
- Prefer real examples: an actual command, file or code snippet. If he names a file in the current folder, read it and explain THAT file.
- Arabic explanations; commands, code and English terms in monospace.
- Wrap Latin and number runs inside Arabic lines in Unicode isolates (U+2066 to U+2069) so the order renders correctly.
- **Closing at the end:** "صلوا على النبي ﷺ" then "السلام عليكم".

## Look
- Vertical 1080x1920, 30 fps.
- Dark background with neon circuit traces in amber and cyan, pulses travelling along them.
- Green terminal windows where commands type out.
- Very dim scrolling code text in the background.
- Text and terminals appear with a short fade or slide.

## Sound
- **No music, no background drone, no repeating beat.**
- Typing sounds only while a terminal types, and kept **very quiet and soft** (he finds loud clicks annoying).
- Soft airy swoosh between shots (band-passed noise, about 0.5 s, no low end). Never a thud.
- Mix with fixed gain; never normalize up to the loudest event.

## Build
- Python: draw frames with Pillow, pipe them to ffmpeg (libx264, preset veryfast, crf 20, yuv420p). One mp4 per shot, join with the concat demuxer and `-c copy`, add the audio last with `-c:v copy`.
- Synthesize audio with numpy from a log of sound events and their times.
- Before the full render, save stills of the busiest moments and check them (Arabic shaping, text inside the frame).
- Arabic text needs Pillow with libraqm (`ImageFont.Layout.RAQM`) and an Arabic font such as Noto Sans Arabic. Find fonts with `fc-list | grep -i arab`.
- Work in a temp folder; save the final video where he asks (default `~/Videos/`) and print its path.
