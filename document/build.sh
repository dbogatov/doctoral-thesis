#!/usr/bin/env bash

set -e

# Ensure that the CWD is set to script's location
cd "${0%/*}"
CWD=$(pwd)

COMPILER=pdflatex
INTERACTION=nonstopmode
OUTDIR=dist
JOBNAME=report
ITERATIONS=3
PREVIEW=""
OPEN=false

usage() { echo "Usage: $0 [-o]" 1>&2; exit 1; }

while getopts "o" o; do
	case "${o}" in
		o)
			ITERATIONS=1
			PREVIEW="\def\preview{true}"
			OPEN=true
			;;
		*)
			usage
			;;
	esac
done
shift $((OPTIND-1))

echo "Cleaning up workspace"

rm -rf ${OUTDIR}
mkdir -p ${OUTDIR}

for j in `seq 1 $ITERATIONS`;
do
	echo "Compiling for the $j time..."

	if [ "$j" == "2" ]
	then
		biber ${OUTDIR}/${JOBNAME}
	fi

	$COMPILER \
		--interaction=${INTERACTION} \
		-output-directory=${OUTDIR} \
		-jobname=${JOBNAME} \
		"\def\dummy{} ${PREVIEW} \input main.tex"
done

echo "Removing build files..."

rm -f ${OUTDIR}/*.{aux,log,out,xwm,toc,lof,lot,bib,bbl,bcf,blg,xml}

echo "Done."

if [ "$OPEN" == true ]
then
	open ${OUTDIR}/${JOBNAME}.pdf
fi
