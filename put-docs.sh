#!/usr/bin/env bash

set -e

# Ensure that the CWD is set to script's location
cd "${0%/*}"
CWD=$(pwd)

PROJECT_ID="$1" # lookup in repo settings
FILE="$2"
DESTINATION="$3"
JOB="artifacts" # change if necessary
BRANCH="$4"
PAGES=10

echo "Downloading artifacts into temporary directory"
cd `mktemp -d`

for page in $(seq 1 $PAGES)
do

	JOB_ID=$( \
		curl --globoff -Ls --header "PRIVATE-TOKEN: $PAT" \
		"https://$CI_SERVER_HOST/api/v4/projects/$PROJECT_ID/jobs?scope[]=success&per_page=100&page=$page" \
		| jq 'map(select( .ref == '\"$BRANCH\"' and .name == '\"$JOB\"' )) | sort_by( .finished_at ) | reverse | if length > 0 then .[0] | .id else -1 end' \
	)

	if [ "$JOB_ID" -eq "-1" ]
	then
		echo "\"$FILE\" not found in page $page of project $PROJECT_ID"
		continue
	else
		break
	fi

done

if [ "$JOB_ID" -eq "-1" ]
then
	echo "\"$FILE\" not found in project $PROJECT_ID artifacts ($PAGES pages)"
	exit 1
fi

echo "Will download artifact for job $JOB_ID in project $PROJECT_ID"

curl \
	--globoff -Ls --header "PRIVATE-TOKEN: $PAT" \
	"https://$CI_SERVER_HOST/api/v4/projects/$PROJECT_ID/jobs/$JOB_ID/artifacts/$FILE.pdf" \
> file.pdf

echo "Moving file"
mv file.pdf $OLDPWD/document/graphics/$DESTINATION.pdf

echo "Done"
