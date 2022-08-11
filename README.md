# Commonly used shell boilerplate

A small library of things that are often required in shellscripts. Written for `zsh`, not `bash`!

## Usage

### Bundle

Start your script with: 
```
#!/usr/bin/env zsh
set -euo pipefail

if [[ ! -f ~/.cache/shlib/shlib-v0.1.0.sh ]]; then
    mkdir -p ~/.cache/shlib/
    curl --fail --silent -L https://github.com/jkrafczyk/shlib/releases/download/v0.1.0/lib.bundle.sh -o ~/.cache/shlib/shlib-v0.1.0.sh
fi
source ~/.cache/shlib/shlib-v0.1.0.sh
```

### Using the repository

* Clone this repository somewhere
* Source the `lib.sh` file in your script
* Load required components using `shlib:module:load`

Example script:
```zsh
source ~/lib/shlib/lib.sh
shlib:module:load font

echo "Hello, $(shlib:font:set bold fg-yellow)colorful$(shlib:font:reset) world!"
```

## Modules

### core
Functionality related to loading other modules.

#### shlib:module:load
#### shlib:module:is-loaded

### all
Meta-module - doesn't do anything itself, just loads all other supported modules

### font
Text color and font manipulation for terminal output (ANSI control sequences).

#### shlib:font:set
#### shlib:font:reset

### usage
Display "usage" messages and terminate the script.

#### shlib:usage:set-message
#### shlib:usage


### deps
Download external dependencies for use in a script.

#### shlib:deps:git
#### shlib:deps:http-tar
#### shlib:deps:http-file
#### shlib:deps:common:jq
#### shlib:deps:common:gum
#### shlib:deps:common:fzf
#### shlib:deps:common:rg
#### shlib:deps:common:fdfind
#### shlib:deps:common