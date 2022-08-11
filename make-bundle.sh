#!/usr/bin/env bash
set -euo pipefail

(
echo "######## lib.sh ########"
cat lib.sh
echo
for filename in ./*.lib.sh; do
    echo "######## $filename ########"
    modname=$(basename "$filename" ".lib.sh")
    cat $filename
    printf "\nSHLIB_MODULE_LOADED_%s=1\n" "$modname"
done
) > lib.bundle.sh