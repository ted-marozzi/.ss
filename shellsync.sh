#!/bin/bash
set -euo pipefail

# Shell Sync
# Keep a set of functions, alias' and variables synced across machines.
export SSHOME="$HOME/.ss"
function ss() {
    local action="$1";
    cd "$SSHOME"
    if [ "$action" = "pull" ]; then
        git pull
    elif [ "$action" = "push" ]; then
        # Default to push
        local message="${2:-Update Config}"
        git add README.md shellsync.sh sharedconfig.sh
        git commit -m "$message"
        git push
    else
        echo "Please specify an action for Shell Sync to run: pull or push"
    fi
    cd - 1> /dev/null
}

function openss() {
    code "$SSHOME" || vim "$SSHOME"
}

function sspull() {
    ss pull 1> /dev/null
}
# Pretend its fast but run it async lol
# Your profile will be avaliable when you refresh your shell
echo "Shell Synced ⚡️"
(sspull &)

set +euo pipefail
# shellcheck disable=SC1091
source "$SSHOME/sharedconfig.sh"

