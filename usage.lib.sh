SHLIB_USAGE_MESSAGE="blorb"

function shlib:usage:set-message() {
    if [[ ! -t 0 ]]; then
        SHLIB_USAGE_MESSAGE=$(cat)
    else
        SHLIB_USAGE_MESSAGE="$@"
    fi
}

function shlib:usage() {
    shlib:module:is-loaded font && shlib:font:reset

    if [[ -n "$@" ]]; then
        shlib:module:is-loaded font && shlib:font:set fg-red bold
        echo -n "ERROR"
        shlib:module:is-loaded font && shlib:font:reset
        echo ": $@\n"
    fi

    printf "%s\n" "${SHLIB_USAGE_MESSAGE}"
    exit 1
}