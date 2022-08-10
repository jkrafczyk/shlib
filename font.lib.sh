if [[ -t 1 ]]; then
    SHLIB_FONT_PRINTING_TO_TTY=1
else
    SHLIB_FONT_PRINTING_TO_TTY=0
fi

SHLIB_FONT_STYLE_BOLD=1
SHLIB_FONT_STYLE_DIM=2
SHLIB_FONT_STYLE_UNDERLINE=4
SHLIB_FONT_STYLE_UNDERLINED=4
SHLIB_FONT_STYLE_RESET=0

SHLIB_FONT_STYLE_FG_BLACK=30
SHLIB_FONT_STYLE_FG_RED=31
SHLIB_FONT_STYLE_FG_GREEN=32
SHLIB_FONT_STYLE_FG_YELLOW=33
SHLIB_FONT_STYLE_FG_BLUE=34
SHLIB_FONT_STYLE_FG_PINK=35
SHLIB_FONT_STYLE_FG_CYAN=36
SHLIB_FONT_STYLE_FG_GRAY=37

SHLIB_FONT_STYLE_BG_BLACK=40
SHLIB_FONT_STYLE_BG_RED=41
SHLIB_FONT_STYLE_BG_GREEN=42
SHLIB_FONT_STYLE_BG_YELLOW=43
SHLIB_FONT_STYLE_BG_BLUE=44
SHLIB_FONT_STYLE_BG_PINK=45
SHLIB_FONT_STYLE_BG_CYAN=46
SHLIB_FONT_STYLE_BG_GRAY=47

SHLIB_FONT_STYLE_FG_WHITE="38;5;231"

function shlib:font:disable() {
    SHLIB_FONT_PRINTING_TO_TTY=0
}

function shlib:font:enable() {
    SHLIB_FONT_PRINTING_TO_TTY=1
}

function shlib:font:set() {
    if [[ ${SHLIB_FONT_PRINTING_TO_TTY} -eq 0 ]]; then
        return
    fi
    
    local seq=""
    local arg 
    local varname
    local controlcode
    for arg in "$@"; do
        varname="SHLIB_FONT_STYLE_$(echo "$arg" | tr '[[:lower:]-: ]' '[[:upper:]___]' )"
        controlcode="${(P)varname:-}"
        if [[ -z "$controlcode" ]]; then
            shlib:fail "Invalid color/font name: $arg"
        fi
        if [[ -n "$seq" ]]; then
            seq="${seq};"
        fi
        seq="${seq}${controlcode}"
    done
    printf "\033[%sm" "$seq"
}

function shlib:font:reset() {
    shlib:font:set reset
}