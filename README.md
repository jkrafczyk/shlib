# Commonly used shell boilerplate

A small library of things that are often required in shellscripts. Written for `zsh`, not `bash`!

## Usage

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
#### shlib:deps:standard