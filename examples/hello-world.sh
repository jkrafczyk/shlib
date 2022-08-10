#!/usr/bin/env zsh
set -euo pipefail

source "$(dirname "$0")/../lib.sh"

shlib:module:load font

echo "Hello, $(shlib:font:set bold fg-yellow)colorful$(shlib:font:reset) world!"