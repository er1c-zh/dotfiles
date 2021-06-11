#!/bin/bash

# check is brew install

if ! [[ `command -v brew` ]]; then
    echo "Homebrew has not been installed."
    exit 1
fi

brew update

# base utils
brew install coreutils
brew install moreutils
brew install findutils
brew install gnu-sed
brew install openssh

# base tools
brew install grep
brew install wget

# vim
brew install vim

# development tools
brew install jq
brew install git

