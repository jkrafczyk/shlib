#!/usr/bin/env zsh
set -euo pipefail

source "$(dirname "$0")/../lib.sh"

shlib:module:load font usage


shlib:usage:set-message <<EOF
Usage: $0

This is an $(shlib:font:set fg-blue bold underlined)example script$(shlib:font:reset) to demonstrate how a usage message could look like.
Invoke it at your own risk.
EOF

shlib:usage "This script is not meant to be actually used"