#!/bin/bash

# 🔁 Sync new files from Windows Downloads to your working folder

WIN_DOWNLOADS="/mnt/c/Users/roodu/Downloads"
WSL_DEST="$HOME/RIICURSION/RIICURSIONnetwork/new_from_windows"

mkdir -p "$WSL_DEST"

echo "🔍 Scanning Windows Downloads..."
find "$WIN_DOWNLOADS" -maxdepth 1 -type f -newerct "$(date -d '5 minutes ago')" -print0 | while IFS= read -r -d '' file; do
  cp "$file" "$WSL_DEST"
  echo "📥 Copied: $(basename "$file")"
done

echo "✅ Sync complete. Files moved to: $WSL_DEST"
