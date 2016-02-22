#!/bin/sh
mkdir -p "$HOME/.local/"
if [ "$TRAVIS_OS_NAME" = 'linux' ] ; then
  if [ ! -e "$HOME/.local/bin/cmake" ]; then
    curl -O https://cmake.org/files/v3.4/cmake-3.4.3-Linux-x86_64.sh
    sh cmake-3.4.3-Linux-x86_64.sh --prefix="$HOME/.local/" --skip-license
  fi
elif [ "$TRAVIS_OS_NAME" = 'osx' ]; then
  brew update
  brew upgrade cmake --cleanup
fi
