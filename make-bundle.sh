#!/usr/bin/env zsh
set -euo pipefail

(
echo "######## lib.sh ########"
cat lib.sh
echo
for filename in ./*.lib.sh; do
    echo "######## $filename ########"
    modname=$(basename "$filename" ".lib.sh")
    cat $filename
    echo "\nSHLIB_MODULE_LOADED_$modname=1\n"
done
) > lib.bundle.sh