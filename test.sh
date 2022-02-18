#!/usr/bin/env bash

shopt -s globstar

# Ensure that the CWD is set to script's location
cd "${0%/*}"
CWD=$(pwd)

#######

echo ">>> Testing CHKTEX..."

chktex -eall -n22 -n2 -n46 -n30 -n3 -e16 -I0 -v2 -o chktex.out document/**/*.tex document/*.tex &> /dev/null
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

for character in " ̈" "„" "“" "–" "’"
do
	echo ">>>> Checking $character "
	! grep -n $character document/**/*.tex document/*.tex document/*.bib

	if [[ $? != 0 ]];
	then
		echo ">>> FAIL"
		exit 1
	fi
done

echo ">>> Testing CSPELL..."

if cspell -V; then
	cspell -c .vscode/cSpell.json document/**/*.tex document/*.tex
else
	echo "Will use Docker. Or install with: npm install -g cspell"
	docker run -it -v "$(pwd)":/code --entrypoint /bin/bash dbogatov/docker-images:cspell-latest-multi-arch -c "cd /code && cspell -c .vscode/cSpell.json document/**/*.tex document/*.tex"
fi

if [[ $? != 0 ]];
then
	echo ">>> FAIL"
	exit 1
fi

echo ">>> pass"
exit 0
