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
brew install grep
brew install wget

log "vim"
# vim
brew install vim
brew install ctags

log "development tools"
# development tools
brew install jq
brew install git

