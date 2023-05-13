#!/bin/bash
set -euo pipefail

# Shell Sync
# Keep a set of functions, alias' and variables synced across machines.
export SSHOME="$HOME/.ss"
function ss() {
    local action="$1";
    cd "$SSHOME"
    if [ "$action" = "sync" ]; then
        local message="${2:-Update Config}"
        git add README.md shellsync.sh sharedconfig.sh
        git commit -m "$message"
        git push
    elif [ "$action" = "pull" ]; then
        git pull
    elif [ "$action" = "open" ]; then
        code "$SSHOME" || vim "$SSHOME"
    elif [ "$action" = "list" ]; then
        # Implement this command by echoing the config in sharedconfig.sh
        _list
    else
        echo "ss sync 'optional sync message': sync setting changes"
        echo "ss pull: pull setting changes down (This happens on terminal open)"
        echo "ss open: open $SSHOME in an editor"
        echo "ss list: list shared commands"
    fi
    cd - 1> /dev/null
}

function _sspull() {
    ss pull 1> /dev/null
}
# Pretend its fast but run it async lol
# Your profile will be avaliable when you refresh your shell
echo "Shell Synced ⚡️"
(_sspull &)

set +euo pipefail
# shellcheck disable=SC1091
source "$SSHOME/sharedconfig.sh"

