#!/bin/bash

set -e

script_dir=$(dirname "$0")
source "$script_dir/../ci_includes.generated.sh"

export GIT_HASH=$(git rev-parse --short HEAD)
export PKG_VERSION="$VERSION"

echo xxx
echo $VERSION

cd ./build

PAGER="cat" sudo checkinstall -y --type=debian --fstrans=no --nodoc \
	--backup=no --deldoc=yes --install=no \
	--pkgname="$PLUGIN_NAME" --pkgversion="$PKG_VERSION" \
	--pkglicense="GPLv2.0" --maintainer="$LINUX_MAINTAINER_EMAIL" \
	--pkggroup="video" \
	--requires="obs-studio \(\>= 25.0.7\), libqt5core5a, libqt5widgets5, qt5-image-formats-plugins" \
	--pakdir="../package"

sudo chmod ao+r ../package/*
