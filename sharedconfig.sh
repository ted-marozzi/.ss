#!/bin/bash
# Replace this files with your own config
set -euo pipefail


function _list() {
    echo "gc"
    echo "gcp"
    echo "ghc"
    echo "ghct"
    echo "gm"
    echo "touchSh"
    echo "rmf"
    echo "openzsh"
    echo "openhome"
    echo "replaceSymlink"
}

function gc() {
    local message="${1:-updates}"
    git add -A
    git commit -m "$message"
}

function gcp() {
    local flags="$3"
    gc "$1"
    if [ -z "$flags" ]; then
        git push
    else
        git push "$flags"
    fi
}

function ghc() {
    local owner="$1"
    local name="$2"
    local flags="$3"
    if [ -z "$owner" ]; then
        echo "Enter the owner of the repo to clone."
        read -r owner
    fi
    if [ -z "$name" ]; then
        echo "Enter the name of the repo to clone."
        read -r name
    fi
    if [ -z "$flags" ]; then
        git clone --recurse-submodules "git@github.com:$owner/$repo.git"
    else
        git clone --recurse-submodules "$flags" "git@github.com:/$owner/$repo.git"
    fi
}

function ghct() {
    local repo="$1"
    local flags="$2"

    ghc "ted-marozzi" "$repo" "$flags"
}

alias gm="git stash && git checkout main || git checkout master || git checkout develop && git pull"

function touchsh() {
    local filename="$1"
    if [ -z "$filename" ]; then
        echo "Enter the filename to create (without an extension)."
        read -r filename
    fi
    # Strip .sh if the user entered it
    filename=${filename%".sh"}

    printf '#!/bin/bash\nset -euo pipefail\n' > "$filename.sh";
    chmod +x "./$filename.sh"
}



function kp() {
    npx kill-port "$1"
}

alias openzsh="code ~/.zshrc";
alias openhome="code ~"

function replaceSymlink() {
    sourcefile=$(readlink "$1");
    rm "$1" && cp -a "$sourcefile" "$1";
}

function replaceAllSymlinks() {
    find ./ -type l -exec sh -c 'for i in "$@"; do replaceSymlink $1; done' sh {} +
}

# start: vim config
set -o vi

function zle-keymap-select () {

case $KEYMAP in

vicmd) echo -ne '\e[1 q';; # block

viins|main) echo -ne '\e[5 q';; # beam

esac

}

zle -N zle-keymap-select

zle-line-init() {

zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)

echo -ne "\e[5 q"

}

zle -N zle-line-init

echo -ne '\e[5 q' # Use beam shape cursor on startup.

preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# end: vim config

set +euo pipefail
