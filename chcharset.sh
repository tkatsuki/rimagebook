#!/bin/sh
for file in R/*.R demo/*.R src/*/*.cpp
do
  nkf --in-place $* ${file} || exit 1
done

