#!/bin/bash

# check is osx

if [[ `uname` != "Darwin" ]]; then
    echo "It's not osx, exit."
    exit
fi

if [[ `command -v brew` ]]; then
    echo "Homebrew already installed at: "`command -v brew`"."
    exit
fi

HOMEBREW_BASE=$HOME"/opt/homebrew"

mkdir -p $HOMEBREW_BASE && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C $HOMEBREW_BASE

