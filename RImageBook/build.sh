#!/bin/sh

BUILD_TARGET=RImageBook_0.7.1.tar.gz
case $OS in
Windows*)
  echo This script is for linux OS.
  ;;
*)
  if [ ! -e ../${BUILD_TARGET} ]; then
    echo "src/thirdparty/.*" > .Rbuildignore
    echo "inst/libs" >> .Rbuildignore
    cp NAMESPACE.linux NAMESPACE
    pushd ..
    echo Building ${BUILD_TARGET}
    R CMD build RImageBook
    popd
    cp NAMESPACE.win NAMESPACE
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

