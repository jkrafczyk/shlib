#!/usr/bin/env zsh
set -euo pipefail

if [[ ! -f ~/.cache/shlib/shlib-v0.1.0.sh ]]; then
    mkdir -p ~/.cache/shlib/
    curl --fail --silent -L https://github.com/jkrafczyk/shlib/releases/download/v0.1.0/lib.bundle.sh -o ~/.cache/shlib/shlib-v0.1.0.sh
fi
source ~/.cache/shlib/shlib-v0.1.0.sh

cat <<EOF
$(shlib:font:set fg-yellow underline)And now, a message from our sponsors$(shlib:font:reset)
EOF