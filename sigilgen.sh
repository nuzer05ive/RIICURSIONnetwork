#!/bin/bash

# 🌺 sigilgen.sh — Render sigils from .riiF1L3 or .rriiF1L3
# Usage: ./sigilgen.sh petals/05R/rrii_05R.riiF1L3

input_file="$1"

if [ ! -f "$input_file" ]; then
  echo "❌ File not found: $input_file"
  exit 1
fi

# Extract sigil, axis, and quote (supports both '@field:' and 'field:' formats)
sigil=$(grep -E '(@sigil:|sigil:)' "$input_file" | head -n 1 | awk '{print $2}')
axis=$(grep -E '(@axis:|axis:)' "$input_file" | head -n 1 | awk '{print $2}')
quote=$(grep -E '(@quote:|quote:)' "$input_file" | head -n 1 | cut -d':' -f2- | sed 's/^ *//')

# Fallback if no quote found
if [ -z "$quote" ]; then
  quote="This sigil remembers what you forgot to say."
fi

# Output name
id=$(basename "$input_file" | cut -d'_' -f2 | cut -d'.' -f1)
outfile="assets/sigils/sigil_${id}.svg"

# Ensure output dir
mkdir -p assets/sigils

# Create SVG
cat <<EOF > "$outfile"
<svg width="600" height="600" viewBox="0 0 600 600" xmlns="http://www.w3.org/2000/svg">
  <style>
    .sigil-text { font-family: 'Courier New', monospace; fill: white; font-size: 36px; }
    .sigil-quote { font-family: 'Georgia'; fill: #ccc; font-size: 18px; text-anchor: middle; }
    .background { fill: black; }
  </style>
  <rect class="background" width="100%" height="100%"/>
  <circle cx="300" cy="300" r="240" stroke="white" stroke-width="3" fill="none"/>
  <text class="sigil-text" x="50%" y="260" dominant-baseline="middle" text-anchor="middle">$sigil</text>
  <text class="sigil-quote" x="300" y="340">$quote</text>
</svg>
EOF

echo "✅ Sigil generated: $outfile"
