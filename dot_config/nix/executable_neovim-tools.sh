#!/usr/bin/env bash
set -euo pipefail

PROFILE="$HOME/.config/nix/neovim-tools"

packages=(
  lua-language-server
  tailwindcss-language-server
  vtsls
  svelte-language-server
  vscode-langservers-extracted
  emmet-language-server
  oxfmt
  stylua
  tinymist
  typstyle
)

nix profile install \
  --profile "$PROFILE" \
  "${packages[@]/#/nixpkgs#}"
