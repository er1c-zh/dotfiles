#!/bin/bash

# check is osx

function log()
{
    echo "[homebrew.sh]"$1
}

log "Checking os."
if [[ `uname` != "Darwin" ]]; then
    echo "It's not osx, exit."
    exit
fi

log "Checking CLT for XCode."
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

BREW=$HOME"/opt/homebrew"

log "Checking does brew already installed."
if [[ `command -v $BREW/opt/homebrew/bin/brew` ]]; then
    echo "Homebrew already installed at: "`command -v brew`"."
    exit
fi

BREW_CORE="$BREW/Library/Taps/homebrew/homebrew-core"

function clean_homebrew()
{
    echo "Clean homebrew."
    rm -r $BREW
}

if [[ -d $BREW ]]; then
    mv $BREW $BREW"."`date "+%Y-%m-%d_%H:%M:%S"`
fi

log "Fetch homebrew."
git clone https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git $BREW
if [[ ! 0 -eq $? ]]; then
    clean_homebrew
    exit 1
fi
log "Fetch homebrew-core."
git clone https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git $BREW_CORE
if [[ ! 0 -eq $? ]]; then
    clean_homebrew
    exit 1
fi

log "Tap homebrew-cask."
$BREW"/bin/brew" tap homebrew/cask https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask.git
$BREW"/bin/brew" tap homebrew/cask-fonts https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-fonts.git
$BREW"/bin/brew" tap homebrew/cask-drivers https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-drivers.git
$BREW"/bin/brew" tap homebrew/cask-versions https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-versions.git

log "Done"

