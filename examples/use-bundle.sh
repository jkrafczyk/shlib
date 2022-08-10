#!/usr/bin/env zsh
set -euo pipefail

source "$(dirname "$0")/../lib.bundle.sh"

for modname in core font deps usage all; do
    shlib:module:is-loaded $modname && echo "module '$modname' loaded"
done
