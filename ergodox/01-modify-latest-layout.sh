#!/bin/bash
set -e

layoutId=`cat list-of-ergodox-layout-ids.txt \
| tail -n 1 \
| perl -p -e 's/[^_]+_([a-zA-Z0-9]+)_.*/$1/'`

if [ -z "${layoutId}" ]; then
  logError Could not determine layout id. Please investigate.
  exit 1
fi

baseUrl=https://configure.ergodox-ez.com/ergodox-ez/layouts

google-chrome "${baseUrl}/${layoutId}"
