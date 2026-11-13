#!/usr/bin/env bash
# unused-report.sh — list theme files that are not referenced anywhere else in the theme.
# Run from the anitya-theme root: bash scripts/unused-report.sh

set -euo pipefail
cd "$(dirname "$0")/.."

echo "# Unused File Report — $(date +%Y-%m-%d)"
echo ""

found=0

for dir in sections snippets assets templates; do
  [ -d "$dir" ] || continue
  for file in "$dir"/*; do
    [ -f "$file" ] || continue
    base="$(basename "$file")"
    # Skip the file itself and common non-referenceable files
    case "$base" in
      *.json) stem="${base%.json}" ;;
      *.liquid) stem="${base%.liquid}" ;;
      *.css) stem="${base%.css}" ;;
      *.js) stem="${base%.js}" ;;
      *) stem="$base" ;;
    esac

    # Search for references to the filename (with or without extension) across all theme files
    refs=$(grep -rl --include='*.liquid' --include='*.json' --include='*.css' --include='*.js' "$base" . 2>/dev/null | grep -v "^\./$file$" | head -1 || true)
    if [ -z "$refs" ]; then
      # Also try the stem (e.g. "anitya-home" without .liquid)
      refs=$(grep -rl --include='*.liquid' --include='*.json' --include='*.css' --include='*.js' "$stem" . 2>/dev/null | grep -v "^\./$file$" | head -1 || true)
    fi

    if [ -z "$refs" ]; then
      echo "- $file"
      found=$((found + 1))
    fi
  done
done

echo ""
echo "Total unreferenced files: $found"
