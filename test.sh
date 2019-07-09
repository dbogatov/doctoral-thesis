#!/usr/bin/env bash

shopt -s globstar

# Ensure that the CWD is set to script's location
cd "${0%/*}"
CWD=$(pwd)

#######

echo ">>> Testing CHKTEX..."

chktex -eall -n22 -n46 -n30 -n3 -e16 -I0 -v2 -o chktex.out document/**/*.tex document/*.tex &> /dev/null
cat chktex.out
if [ -s chktex.out ];
then
	rm -f chktex.*
	echo ">>> FAIL"
	exit 1
else
	rm -f chktex.*
fi

echo ">>> Testing special characters..."

! grep " ̈" document/**/*.tex document/*.tex

if [[ $? != 0 ]];
then
	echo ">>> FAIL"
	exit 1
fi

echo ">>> Testing CSPELL..."

docker run -it -v $(pwd):/code --entrypoint /bin/bash dbogatov/docker-images:cspell-latest -c "cd /code && cspell -c .vscode/cSpell.json document/**/*.tex document/*.tex"

if [[ $? != 0 ]];
then
	echo ">>> FAIL"
	exit 1
fi

echo ">>> pass"
exit 0
