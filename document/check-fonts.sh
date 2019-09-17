#!/usr/bin/env bash

set -e

# Ensure that the CWD is set to script's location
cd "${0%/*}"
CWD=$(pwd)

list=$(pdffonts ./dist/*.pdf)
i=0

while read -r line; do
	if [ $i -ge 2 ];
	then
		res=$(echo $line | cut -d" " -f 5)
		[ $res == "yes" ];
	fi
	i=$((i+1))
done <<< "$list"

echo "Check passed!"
