#!/usr/bin/env bash
set -euo pipefail

modules=(
    font
    usage
    deps
    all
)

(
echo "######## lib.sh ########"
cat lib.sh
echo
for module in ${modules[@]}; do
    echo "######## ${module}.lib.sh ########"
    cat ${module}.lib.sh
    printf "\nSHLIB_MODULE_LOADED_%s=1\n" "$module"
done
) > lib.bundle.sh