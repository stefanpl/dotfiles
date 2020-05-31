#!/bin/bash
set -e

if [ -z "$BASH_SOURCE[0]" ]; then
  scriptDir=`dirname "$(readlink -f "$0")"`
else
  scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
fi

(
  cd ${scriptDir} &&
  git add list-of-ergodox-layout-ids.txt ergodox-ez-firmware.hex &&
  git commit -m "latest ergo layout"
)
