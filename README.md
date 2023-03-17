## Shell Sync

# Instructions

## Getting started

1. Fork this repo to your public repo
2. Clone the fork into your home directory
3. Add `source "$HOME/.ss/shellsync.sh"` to your shell profile (e.g ~/.zsh, ~/.zprofile, ~/.bashrc) to each machine you want to sync
4. Replace the contents of `./sharedconfig.sh` with the config you wish to share
5. Open a new terminal and run `ss push` to push your config to the remote

## To add additional config

1. `ss open`
2. Edit `./sharedconfig.sh`
3. Run `ss push`
4. Open a new terminal to get a refreshed config
5. On a different machines open a new terminal to sync config
6. Refresh your terminal to get the new config
