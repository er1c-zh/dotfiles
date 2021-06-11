#!/bin/bash

# check is osx

if [[ `uname` != "Darwin" ]]; then
    echo "It's not osx, exit."
    exit
fi

if ! xcode-select -p 1>/dev/null; then
    echo "Install CLT for XCode."
    xcode-select --install
    if [[ $? ]]; then
        echo "Install CLT for XCode fail."
        exit 1
    fi
else
    echo "CLT for XCode already installed."
fi

if [[ `command -v brew` ]]; then
    echo "Homebrew already installed at: "`command -v brew`"."
    exit
fi

BREW=$HOME"/opt/homebrew"
BREW_CORE="$BREW/Library/Taps/homebrew/homebrew-core"

function clean_homebrew()
{
    echo "Clean homebrew."
    rm -r $BREW
}

if [[ -d $BREW_INSTALL ]]; then
    mv $BREW_INSTALL $BREW_INSTALL"."`date "+%Y-%m-%d_%H:%M:%S"`
fi

git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git $BREW
echo "==="$?
if [[ ! 0 -eq $? ]]; then
    clean_homebrew
    exit 1
fi
git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git $BREW_CORE
if [[ ! 0 -eq $? ]]; then
    clean_homebrew
    exit 1
fi
#BREW_TYPE="homebrew"
#HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
#HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/${BREW_TYPE}-core.git"

#brew tap https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git
brew tap https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask.git
brew tap https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-fonts.git
brew tap https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-drivers.git
brew tap https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-versions.git

#git -C "$(brew --repo)" \
#        remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git
#git -C "$(brew --repo homebrew/core)" \
#        remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git
#git -C "$(brew --repo homebrew/cask)" \
#        remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask.git
#git -C "$(brew --repo homebrew/cask-fonts)" \
#        remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-fonts.git
#git -C "$(brew --repo homebrew/cask-drivers)" \
#        remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-drivers.git
#git -C "$(brew --repo homebrew/cask-versions)" \
#        remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-versions.git


#TMP=$HOME"/tmp"
#BREW_INSTALL=$TMP"/brew-install"
#BREW_TYPE="homebrew"
#HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
#HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/${BREW_TYPE}-core.git"
#HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/${BREW_TYPE}-bottles"

#git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git $BREW_INSTALL
#. $BREW_INSTALL"/install.sh"

