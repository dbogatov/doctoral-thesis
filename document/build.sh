#!/usr/bin/env bash

set -e

# Ensure that the CWD is set to script's location
cd "${0%/*}"
CWD=$(pwd)

INTERACTION=nonstopmode
OUTDIR=dist
JOBNAME=report
PREVIEW=""
OPEN=false
SYNCTEX=1

usage() { echo "Usage: $0 [-o]" 1>&2; exit 1; }

while getopts "o" o; do
	case "${o}" in
		o)
			PREVIEW="\def\preview{true}"
			OPEN=true
			;;
		*)
			usage
			;;
	esac
done
shift $((OPTIND-1))

rm -rf ${OUTDIR}/*
mkdir -p ${OUTDIR}

if [ -n "$CI_BUILD_REF" ];
then
	printf "\providecommand{\\\version}{%s}" $(echo $CI_BUILD_REF | cut -c1-8) > version.tex
fi

latexmk -cd -dvi- -f -pdf -ps- -time \
	-jobname=$JOBNAME \
	-outdir=$OUTDIR \
	--synctex=${SYNCTEX} \
	--interaction=${INTERACTION} \
	-pdflatex='pdflatex %O "\def\dummy{} '${PREVIEW}' \input %S "' \
	main

rm -f ${OUTDIR}/*.{aux,log,out,xwm,toc,lof,lot,bib,bbl,bcf,blg,xml,fls,fdb_latexmk}

echo "Done."

if [ "$OPEN" == true ]
then
	open ${OUTDIR}/${JOBNAME}.pdf
fi
