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
        >&2 curl --fail  -L --silent "$url" -o "$target_file"
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
        >&2 curl --fail -L --silent "$url" -o "$target_file"
        chmod +x "$target_file"
    fi

    echo "$download_dir"
}

function shlib:deps:github-release-url() {
    local user="$1"
    local repo="$2"
    local release="$3"
    local file="$4"
    echo -n "https://github.com/$user/$repo/releases/download/$release/$file"
}

function shlib:deps:common:gum() {
    local version=0.4.0
    local processor=$(uname -p)
    local os=$(uname -s | tr '[[:upper:]]' '[[:lower:]]')
    local url="$(shlib:deps:github-release-url charmbracelet gum v${version} gum_${version}_${os}_${processor}.tar.gz)"
    local gumdir="$(shlib:deps:http-tar \
    gum \
    v${version} \
    ${url} \
    gum
    )"

    PATH="$gumdir:$PATH"
}

function shlib:deps:common:fzf() {
    local version=0.32.1
    # TODO: The architecture naming scheme for fzf differs from that reported by uname. :(
    local processor=amd64
    local os=$(uname -s | tr '[[:upper:]]' '[[:lower:]]')
    local url="$(shlib:deps:github-release-url junegunn fzf ${version} fzf-${version}-${os}-${processor}.tar.gz)"
    local fzfdir="$(shlib:deps:http-tar \
    fzf \
    ${version} \
    ${url} \
    fzf
    )"

    PATH="$fzfdir:$PATH"
}

function shlib:deps:common:ripgrep() {
    local version=13.0.0
    local processor=$(uname -p)
    local os=$(uname -s | tr '[[:upper:]]' '[[:lower:]]')
    #TODO: Naming scheme involves reference to the used libc. 
    local url="$(shlib:deps:github-release-url BurntSushi ripgrep ${version} ripgrep-${version}-${processor}-unknown-${os}-musl.tar.gz)"
    local rgdir="$(shlib:deps:http-tar \
    ripgrep \
    ${version} \
    ${url} \
    ripgrep-${version}-${processor}-unknown-${os}-musl/rg
    )"

    rgdir="$rgdir/ripgrep-${version}-${processor}-unknown-${os}-musl"
    PATH="$rgdir:$PATH"
}

function shlib:deps:common:fdfind() {
    local version=8.4.0
    local processor=$(uname -p)
    local os=$(uname -s | tr '[[:upper:]]' '[[:lower:]]')
    #TODO: Naming scheme involves reference to the used libc. 
    local url="$(shlib:deps:github-release-url shakdp fd v${version} fd-v${version}-${processor}-unknown-${os}-gnu.tar.gz)"
    local fddir="$(shlib:deps:http-tar \
    fdfind \
    v${version} \
    ${url} \
    fd-v${version}-${processor}-unknown-${os}-gnu/fd
    )"

    fddir="$fddir/fd-v${version}-${processor}-unknown-${os}-gnu"

    PATH="$fddir:$PATH"
}

function shlib:deps:common:jq() {
    local version=1.6
    #TODO: Best way to find this?
    local bits=64
    local os=$(uname -s | tr '[[:upper:]]' '[[:lower:]]')
    local url=$(shlib:deps:github-release-url stedolan jq jq-${version} jq-${os}${bits})
    local jqdir="$(
        shlib:deps:http-file \
        jq \
        jq-1.6 \
        ${url}
    )"
    PATH="$jqdir:$PATH"
}

function shlib:deps:common() {
    shlib:deps:common:gum
    shlib:deps:common:fzf
    shlib:deps:common:ripgrep
    shlib:deps:common:fdfind
    shlib:deps:common:jq
}