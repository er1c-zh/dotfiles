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

# convert mov to gif
brew install libtiff webp jpeg-xl libvmaf aom dav1d freetype fontconfig frei0r m4 autoconf automake bdw-gc libffi libtool guile libtasn1 nettle p11-kit libnghttp2 unbound gnutls lame fribidi ninja meson glib util-macros xtrans libpthread-stubs xorgproto libxau libxdmcp libxcb libx11 libxext libxrender lzo pixman cairo bison gobject-introspection graphite2 icu4c harfbuzz libass libbluray cjson cmocka mbedtls librist libsoxr libvidstab libogg libvorbis libvpx opencore-amr little-cms2 openjpeg opus rav1e flac libsndfile libsamplerate rubberband sdl2 snappy speex srt leptonica libb2 lz4 zstd libarchive tesseract theora x264 x265 xvid libsodium zeromq zimg ffmpeg gifsicle

# vim
log "vim"
brew install lua berkeley-db perl libyaml ruby vim ctags

# development tools
log "development tools"
brew install jq git
brew install hugo
brew install stats htop
brew install MonitorControl

