#!/bin/sh
mkdir -p $HOME/.local/
if [ $TRAVIS_OS_NAME == 'linux' ] ; then
  [ ! -e "$HOME/.local/bin/cmake" ] && curl -L https://cmake.org/files/v3.4/cmake-3.4.3-Linux-x86_64.sh | sh -s -- --prefix="$HOME/.local/" --skip-license
elif [ $TRAVIS_OS_NAME == 'osx' ]; then
  brew update
  brew upgrade cmake --cleanup
fi
