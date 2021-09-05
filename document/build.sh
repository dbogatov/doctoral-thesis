#!/usr/bin/env bash

set -e

# Ensure that the CWD is set to script's location
cd "${0%/*}"
CWD=$(pwd)

: ${INTERACTION:=errorstopmode}
: ${OUTDIR:=dist}
: ${JOBNAME:=report}
DRAFT=""
FAST=false
SYNCTEX=1

usage() { echo "Usage: $0 [-f -d]" 1>&2; exit 1; }

while getopts "df" o
do
	case "${o}" in
		f)
			FAST=true
			;;
		d)
			DRAFT="\def\draft{true}"
			JOBNAME="$JOBNAME-draft"
			;;
		*)
			usage
			;;
	esac
done
shift $((OPTIND-1))

if [ $FAST == false ]
then
	mkdir -p ${OUTDIR}/tmp
	cp ${OUTDIR}/*.pdf ${OUTDIR}/tmp || true
	rm -f ${OUTDIR}/*.*
	cp ${OUTDIR}/tmp/*.pdf ${OUTDIR} || true
	rm -rf ${OUTDIR}/tmp
	mkdir -p ${OUTDIR}/figures
fi

if [ -n "$CI_BUILD_REF" ];
then
	printf "\providecommand{\\\version}{%s}" $(echo $CI_BUILD_REF | cut -c1-8) > version.tex
fi

latexmk -cd -dvi- -f -pdf -ps- -time -shell-escape \
	-jobname=${JOBNAME} \
	-outdir=${OUTDIR} \
	--synctex=${SYNCTEX} \
	--interaction=${INTERACTION} \
	-pdflatex='pdflatex %O "\def\dummy{} '${REVIEW}' '${DRAFT}' \input %S "' \
	main

if [ $FAST == false ]
then
	rm -f ${OUTDIR}/*.{aux,log,out,xwm,toc,lof,lot,bib,bbl,bcf,blg,xml,fls,fdb_latexmk}
fi

echo "Done."
