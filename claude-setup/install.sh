#!/bin/bash
# Installs my Claude Code setup: the global CLAUDE.md and my video skills.
# Usage: bash claude-setup/install.sh

SRC="$(cd "$(dirname "$0")" && pwd)"
DEST="$HOME/.claude"

mkdir -p "$DEST/skills"

# Back up an existing global CLAUDE.md before replacing it
if [ -f "$DEST/CLAUDE.md" ] && ! cmp -s "$SRC/CLAUDE.md" "$DEST/CLAUDE.md"; then
    cp "$DEST/CLAUDE.md" "$DEST/CLAUDE.md.bak"
    echo "Old CLAUDE.md saved as $DEST/CLAUDE.md.bak"
fi
cp "$SRC/CLAUDE.md" "$DEST/CLAUDE.md"
echo "CLAUDE.md -> $DEST/CLAUDE.md"

# Copy each skill folder
for skill in "$SRC"/skills/*/; do
    name="$(basename "$skill")"
    mkdir -p "$DEST/skills/$name"
    cp -r "$skill"* "$DEST/skills/$name/"
    echo "skill $name -> $DEST/skills/$name"
done

# Check the tools the video skills need
missing=()
command -v ffmpeg >/dev/null || missing+=(ffmpeg)
python3 -c "import PIL" 2>/dev/null || missing+=(python-pillow)
python3 -c "import numpy" 2>/dev/null || missing+=(python-numpy)
pacman -Q libraqm >/dev/null 2>&1 || missing+=(libraqm)
fc-list | grep -qi arab || missing+=(noto-fonts)

if [ ${#missing[@]} -gt 0 ]; then
    echo
    echo "For videos, install the missing packages:"
    echo "  sudo pacman -S --needed ${missing[*]}"
fi

echo "
+-----------------+
|      done       |
+-----------------+
"
