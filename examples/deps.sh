#!/usr/bin/env zsh
set -euo pipefail

source "$(dirname "$0")/../lib.sh"

shlib:module:load deps
shlib:deps:common

echo "Using fzf, ripgrep, fdfind, gum and jq via shlib:"
which fzf
which rg
which fd
which gum
which jq

