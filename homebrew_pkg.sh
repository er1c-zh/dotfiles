#!/bin/bash

function log()
{
    echo "[homebrew_pkg.sh]"$1
}

# check is brew install

if ! [[ `command -v brew` ]]; then
    echo "Homebrew has not been installed."
    exit 1
fi

log "brew update"
brew update

log "base package"
# base utils
brew install coreutils
brew install moreutils
brew install findutils
brew install gnu-sed
brew install openssh

log "base tools"
# base tools
brew install grep wget libevent utf8proc tmux

log "vim"
# vim
brew install lua berkeley-db perl libyaml ruby vim ctags

log "development tools"
# development tools
brew install jq git

