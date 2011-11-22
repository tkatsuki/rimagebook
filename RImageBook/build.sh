#!/bin/sh
case $OS in
Windows*)
  echo This script is for linux OS.
  ;;
*)
  echo "src/thirdparty/.*" > .Rbuildignore
  mv NAMESPACE NAMESPACE.bak || exit 1
  cp NAMESPACE.linux NAMESPACE || exit 1
  pushd ..
  if [ ! -e RImageBook_1.0.tar.gz ]; then
    R CMD build RImageBook || exit 1
  fi
  R CMD INSTALL RImageBook_1.0.tar.gz
  popd 
  mv NAMESPACE.bak NAMESPACE
  rm -f .Rbuildignore
esac

