#!/bin/bash

# check is brew install

if ! [[ `command -v brew` ]]; then
    echo "Homebrew has not been installed."
    exit 1
fi

HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

brew update

# free application
brew install --cask iterm2
brew install --cask iglance
brew install --cask visual-studio-code
brew install --cask lightproxy
brew install --cask microsoft-edge
brew install --cask squirrel # 鼠须管

# business application
brew install --cask jetbrains-toolbox
brew install --cask eudic
brew install --cask docker

# powerline fonts
brew install --cask font-hack-nerd-font

# karabiner-elements
brew install --cask karabiner-elements

brew install --cask hiddenbar

