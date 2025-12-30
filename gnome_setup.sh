#!/usr/bin/bash

# Install & enable extensions
set -euo pipefail
EXTENSIONS=(
  "rectangle@acristoffers.me"
  "just-perfection-desktop@just-perfection"
  "clipboard-indicator@tudmotu.com"
  "impatience@gfxmonk.net"
  "freon@UshakovVasilii_Github.yahoo.com"
  "tilingshell@ferrarodomenico.com"
)

for ext in "${EXTENSIONS[@]}"; do
  gnome-extensions install "$ext" || true
done

for ext in "${EXTENSIONS[@]}"; do
  gnome-extensions enable "$ext" || true
done

# don't remember & hide recent files
gsettings set org.gnome.desktop.privacy remember-recent-files false
