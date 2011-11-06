#!/bin/sh

./chcharset.sh -w || exit 1
mv NAMESPACE NAMESPACE.bak
cp NAMESPACE.linux NAMESPACE
pushd ..; R CMD build RImageBook ; popd
mv NAMESPACE.bak NAMESPACE
./chcharset.sh -s || exit 1
pushd ..
echo "install.packages(\"RImageBook_1.0.tar.gz\")" | R --no-save
popd

