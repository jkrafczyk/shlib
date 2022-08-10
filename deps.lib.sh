function shlib:deps:git() {
    local name="$1"
    local repo="$2"
    local ref="$3"

    local target="$HOME/.cache/shlib/git/$name/$ref"

    if [[ -d "$target" ]]; then
        echo "$target"
        return 0
    fi

    mkdir -p "$target"
    >&2 echo "Cached data for $name $ref not found. Cloning."
    >&2 git clone --quiet --branch "$ref" --depth 1 "$repo" "$target"
    echo "$target"
}

function shlib:deps:http-tar() {
    local name="$1"
    local version="$2"
    local url="$3"
    shift 3
    local basename="$(basename "$url")"
    
    local download_dir="$HOME/.cache/shlib/http-tar/$name"
    local extract_dir="$HOME/.cache/shlib/http-tar/$name/$version"
    local target_file="$download_dir/$name-$version-$basename"

    if [[ ! -s "$target_file" ]]; then
        mkdir -p "$download_dir"
        >&2 curl -L --silent "$url" -o "$target_file"
    fi

    if [[ ! -d "$extract_dir" ]]; then
        mkdir -p "$extract_dir"
    fi

    if [[ ! -f "$extract_dir/.shlib_extract_done" ]]; then
        >&2 tar xaf "$target_file" -C "$extract_dir" $@ 
        touch "$extract_dir/.shlib_extract_done"
    fi

    echo "$extract_dir"
}

function shlib:deps:http-file() {
    local name="$1"
    local version="$2"
    local url="$3"

    local download_dir="$HOME/.cache/shlib/http-file/$name/$version"
    local target_file="$download_dir/$name"
    if [[ ! -x "$target_file" ]]; then
        mkdir -p "$download_dir"
        >&2 curl -L --silent "$url" -o "$target_file"
        chmod +x "$target_file"
    fi

    echo "$download_dir"
}

function shlib:deps:standard() {
    #TODO: Make the urls a bit more dynamic (e.g. build url and fix subdirs based on version and architecture)

    local gumdir="$(shlib:deps:http-tar \
    gum \
    v0.4.0 \
    https://github.com/charmbracelet/gum/releases/download/v0.4.0/gum_0.4.0_linux_x86_64.tar.gz \
    gum
    )"

    local fzfdir="$(shlib:deps:http-tar \
    fzf \
    0.32.1 \
    https://github.com/junegunn/fzf/releases/download/0.32.1/fzf-0.32.1-linux_amd64.tar.gz \
    fzf
    )"

    local rgdir="$(shlib:deps:http-tar \
    ripgrep \
    13.0.0 \
    https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz \
    ripgrep-13.0.0-x86_64-unknown-linux-musl/rg )"
    rgdir="$rgdir/ripgrep-13.0.0-x86_64-unknown-linux-musl"

    local fddir="$(
        shlib:deps:http-tar \
        fdfind \
        v8.4.0 \
        https://github.com/sharkdp/fd/releases/download/v8.4.0/fd-v8.4.0-x86_64-unknown-linux-gnu.tar.gz \
        fd-v8.4.0-x86_64-unknown-linux-gnu/fd
    )"
    fddir="$fddir/fd-v8.4.0-x86_64-unknown-linux-gnu"

    local jqdir="$(
        shlib:deps:http-file \
        jq \
        jq-1.6 \
        https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
    )"

    PATH="$gumdir:$fzfdir:$rgdir:$fddir:$jqdir:$PATH"
}