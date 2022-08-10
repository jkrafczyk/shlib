SHLIB_ROOT="$(dirname "$0")"

if [[ ! "$SHLIB_ROOT" =~ ^/ ]]; then
    SHLIB_ROOT="$(pwd)/$SHLIB_ROOT/"
fi

SHLIB_ROOT="$(readlink --canonicalize-missing --no-newline "${SHLIB_ROOT}")"

function shlib:fail() {
    2>&1 echo "ERROR: $*"
    exit 1
}

function shlib:module:load() {
    local name varname
    for name in "$@"; do
        if ! shlib:module:is-loaded $name; then
            source "${SHLIB_ROOT}/${name}.lib.sh"
            varname=SHLIB_MODULE_LOADED_$name
            typeset -g $varname=1
        fi
    done
}

function shlib:module:is-loaded() {
    local name varname
    for name in "$@"; do
        varname="SHLIB_MODULE_LOADED_$name"
        if [[ "${(P)varname:-}" != "1" ]]; then
            return 1
        fi
    done
    return 0
}

SHLIB_MODULE_LOADED_core=1