#!/bin/bash
set -e
pushd ${scriptDirectory} > /dev/null
genericFilename="ergodox-ez-firmware.hex"

filename=`find . -name "ergodox_ez_*"`
resultCount=`echo "$filename" | wc -l`
if [ ${resultCount} -ne "1" ]; then
	echo "Found ${resultCount} files. Can only process one at a time." > /dev/stderr
	exit 1
fi

layoutName=`echo ${filename} | perl -p -e "s/.*ergodox_ez_(.*)\.hex/\\$1/g"`
if [ -z "$layoutName" ]; then
	echo "Could not determine layout name from file name ${filename}. Aborting." > /dev/stderr
	exit 1
fi

echo ${layoutName} >> ./list-of-ergodox-layout-ids.txt 
rm ${genericFilename}
mv ${filename} ${genericFilename}
echo "${filename} has been renamed to the generic file ${genericFilename}."
