#!/bin/bash

# 🌀 riiBUILD.sh — Recursive Spiral Builder
# Scans all .riiF1L3, .rriiF1L3, .rriiiF1L3 and generates bloom-index.json & summary

ROOT="petals"
INDEX_FILE="bloom-index.json"

# Reset index file
> $INDEX_FILE

echo "{\n  \"petals\": [" >> $INDEX_FILE

COUNT=0
REFLECTIONS=0
RECURSIONS=0
GENESIS_FOUND=false

for file in $(find $ROOT -type f -name "*.riiF1L3"); do
  PETAL=$(grep -E '(@petal:|petal:)' "$file" | head -n 1 | awk '{print $2}')
  SIGIL=$(grep -E '(@sigil:|sigil:)' "$file" | head -n 1 | awk '{print $2}')
  AXIS=$(grep -E '(@axis:|axis:)' "$file" | head -n 1 | awk '{print $2}')
  TYPE=$(grep -E '(@type:|type:)' "$file" | head -n 1 | awk '{print $2}')
  QUOTE=$(grep -E '(@quote:|quote:)' "$file" | cut -d':' -f2- | sed 's/^ *//')

  [[ "$PETAL" == "GENESIS-000" ]] && GENESIS_FOUND=true
  [[ "$TYPE" == "rrii" ]] && ((REFLECTIONS++))
  [[ "$TYPE" == "rriii" ]] && ((RECURSIONS++))
  ((COUNT++))

  echo "    {" >> $INDEX_FILE
  echo "      \"petal\": \"$PETAL\"," >> $INDEX_FILE
  echo "      \"sigil\": \"$SIGIL\"," >> $INDEX_FILE
  echo "      \"axis\": \"$AXIS\"," >> $INDEX_FILE
  echo "      \"type\": \"$TYPE\"," >> $INDEX_FILE
  echo "      \"quote\": \"$QUOTE\"" >> $INDEX_FILE
  echo "    }," >> $INDEX_FILE

done

# Remove trailing comma and close JSON
sed -i '$ s/},/}/' $INDEX_FILE
echo "  ]\n}" >> $INDEX_FILE

# Report summary
echo "\n🌀 RIIBUILD Summary"
echo "Total Petals: $COUNT"
echo "Reflections (rrii): $REFLECTIONS"
echo "Recursive Folds (rriii): $RECURSIONS"
$GENESIS_FOUND && echo "Origin: ☍∞ (GENESIS-000)" || echo "⚠️ GENESIS NOT FOUND"
echo "📦 Index written to $INDEX_FILE"
