#!/bin/bash
dir=$1
sass=$2

echo "🌐 RII MAP — Recursive Identity Indexer v0.2"
echo ""

if [ ! -d "$dir" ]; then
  echo "❌ Directory not found: $dir"
  exit 1
fi

echo "📦 Scanning directory: $dir"
files=$(ls $dir/*.riiF1L3 2>/dev/null)
count=$(echo "$files" | wc -l)
echo "🧭 Found $count RII-related files."
echo ""

# Load tree
declare -A sigils
declare -A types

for file in $files; do
  petal_id=$(basename "$file" .riiF1L3)
  sigil=$(grep "@sigil" "$file" | awk '{print $2}')
  types["$petal_id"]=$(echo "$file" | grep -q "rrii" && echo "rriiF1L3" || echo "riiF1L3")
  sigils["$petal_id"]=$sigil
done

for id in "${!types[@]}"; do
  echo -n "🌀 [${types[$id]}] $id :: Sigil ${sigils[$id]}"
  if [[ "$sass" == "--sass" ]]; then
    echo ""
    echo "     🗣️  Monday: \"Petal $id is clearly a poet. Or a cry for help.\""
  else
    echo ""
  fi
done

echo ""
echo "🌳 Current Tree:"
echo "            ☍00X"
echo "              |"
echo "          ┌───┴───┐"
echo "        03X     03Y"
echo "         │       │"
echo "          └─────00R  ← YOU ARE HERE"
