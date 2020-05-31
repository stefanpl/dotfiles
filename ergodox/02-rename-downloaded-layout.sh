#!/bin/zsh
set -e

if [ -z "$BASH_SOURCE[0]" ]; then
	scriptDir=`dirname "$(readlink -f "$0")"`
else
	scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
fi

genericFilename="ergodox-ez-firmware.hex"

filename=`find . -name "ergodox_ez_*"`
resultCount=`echo "$filename" | wc -l`
if [ ${resultCount} -ne "1" ]; then
	logError "Found ${resultCount} files. Can only process one at a time." > /dev/stderr
	exit 1
fi

layoutName=`echo ${filename} | perl -p -e "s/.*ergodox_ez_(.*)\.hex/\\$1/g"`
if [ -z "$layoutName" ]; then
	logError "Did not find the downloaded file. Please do not change the name of the download."
	exit 1
fi

echo ${layoutName} >> ./list-of-ergodox-layout-ids.txt 
rm ${genericFilename}
mv ${filename} ${genericFilename}
logSuccess "${filename} has been renamed to the generic file ${genericFilename}."
