#!/bin/sh
for file in R/*.R
do
  (mv ${file} ${file}.tmp && nkf $* ${file}.tmp > ${file}) || exit 1
  if [ -e ${file}.tmp ]; then
    rm ${file}.tmp
  fi
done

