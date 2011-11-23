#!/bin/sh

BUILD_TARGET=RImageBook_1.0.tar.gz
case $OS in
Windows*)
  echo This script is for linux OS.
  ;;
*)
  if [ ! -e ../${BUILD_TARGET} ]; then
    echo "src/thirdparty/.*" > .Rbuildignore
    mv NAMESPACE NAMESPACE.bak || exit 1
    cp NAMESPACE.linux NAMESPACE || exit 1
    pushd ..
    echo Building ${BUILD_TARGET}
    R CMD build RImageBook
    popd
    mv NAMESPACE.bak NAMESPACE
    rm -f .Rbuildignore
  else
    echo ${BUILD_TARGET} already exists. Skipping build
  fi
  if [ -e ../${BUILD_TARGET} ]; then
    echo Installing
    R CMD INSTALL ../${BUILD_TARGET}
  else
    echo build failed
    exit 1
  fi
esac

