#!/bin/bash

# 🌺 RII READER & BUILDER — spiral parser and bloom renderer
# Reads .riiF1L3, .rriiF1L3, .rriiiF1L3 and reconstructs the bloom story based on L-layer logic
# Usage: ./riiREADER.sh petals/<ID>/<file.riiF1L3>

FILE=$1

if [ ! -f "$FILE" ]; then
  echo "❌ File not found: $FILE"
  exit 1
fi

SIGIL=$(grep -E '(@sigil:|sigil:)' "$FILE" | head -1 | awk '{print $2}')
AXIS=$(grep -E '(@axis:|axis:)' "$FILE" | head -1 | awk '{print $2}')
QUOTE=$(grep -E '(@quote:|quote:)' "$FILE" | head -1 | cut -d':' -f2- | sed 's/^ *//')
PETAL=$(grep -E '(@petal:|petal:)' "$FILE" | head -1 | awk '{print $2}')
TYPE=$(grep -E '(@type:|type:)' "$FILE" | head -1 | awk '{print $2}')
# Convert Unicode superscript to digits
SUPERSCRIPT_MAP=("⁰" 0 "¹" 1 "²" 2 "³" 3 "⁴" 4 "⁵" 5 "⁶" 6 "⁷" 7 "⁸" 8 "⁹" 9)
AXIS_CLEAN=$(echo "$AXIS")
for ((i=0; i<${#SUPERSCRIPT_MAP[@]}; i+=2)); do
  AXIS_CLEAN=${AXIS_CLEAN//${SUPERSCRIPT_MAP[i]}/${SUPERSCRIPT_MAP[i+1]}}
done
LAYER=$(echo "$AXIS_CLEAN" | grep -oE '[0-9]+')




# Build story line by L-layer
function build_layer_echo() {
  case $LAYER in
    0) echo "🌑 Initiation: The beginning before the bloom.";;
    1) echo "🌱 Germination: The seed begins its recursion.";;
    2) echo "🌿 Expansion: Dual logic branches form.";;
    3) echo "🌼 Mirror Split: First reflection detected.";;
    6) echo "🪞 Inversion: Mirror inversion layer.";;
    13) echo "🌕 Bloom Phase: Memory spiral hits golden arc.";;
    15) echo "🌌 Recursive Fold: Identity returns to source.";;
    17) echo "🌀 RIIIMirror: Glyph recurses into observer state.";;
    *) echo "🔁 φ-fold Layer $LAYER: Standard harmonic recursion.";;
  esac
}

# Print report
echo "\n🌺 PETAL ${PETAL} :: ${TYPE^^}"
echo "🧿 Sigil: $SIGIL"
echo "📐 Axis: $AXIS  |  Layer: L$LAYER"
echo "📝 Quote: \"$QUOTE\""
echo "📖 Story: $(build_layer_echo)"

# Export as structured bloom file (optional)
mkdir -p export
cat <<EOF > export/${PETAL}_summary.bloom
{
  "petal": "$PETAL",
  "sigil": "$SIGIL",
  "axis": "$AXIS",
  "layer": "$LAYER",
  "quote": "$QUOTE",
  "type": "$TYPE",
  "summary": "$(build_layer_echo)"
}
EOF

echo "\n✅ Bloom summary exported to export/${PETAL}_summary.bloom"
