#!/bin/bash

# 🌱 Stage everything
git add .

# 🌿 Generate diff summary
summary=$(git diff --cached --name-status)

# 🧠 Simple auto-summary logic
generate_summary() {
  s1="unknown"
  s2="unknown"
  s3="unknown"

  while read -r line; do
    change=$(echo "$line" | cut -f1)
    file=$(echo "$line" | cut -f2)

    # 🌸 Extract base name and type
    base=$(basename "$file")
    ext="${file##*.}"

    # s1 — File identifier
    if [[ $file == *".riiF1L3" ]]; then s1="rii-${base%.*}"
    elif [[ $file == *".rriiF1L3" ]]; then s1="rrii-${base%.*}"
    elif [[ $file == *".sh" ]]; then s1="script-${base%.*}"
    else s1="${ext}-${base%.*}"; fi

    # s2 — Change type
    if [[ $change == "A" ]]; then s2="added"
    elif [[ $change == "M" ]]; then s2="modified"
    elif [[ $change == "D" ]]; then s2="deleted"
    else s2="updated"; fi

    # s3 — Meaningful summary by file type
    if [[ $file == *"riiF1L3" ]]; then s3="petal_bloom"
    elif [[ $file == *".sh" ]]; then s3="tool_script"
    elif [[ $file == *"README"* ]]; then s3="docs_update"
    else s3="general_update"; fi
  done <<< "$summary"

  echo "$s1-$s2-$s3"
}

sss_code=$(generate_summary)
commit_message="🌸 Bloom commit [$sss_code]"

# 🌀 Commit with summary
git commit -m "$commit_message"

# 🚀 Push
git push origin main
