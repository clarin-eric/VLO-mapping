#!/usr/bin/env bash
set -e

MAPPING_CREATOR_VERSION="1.0-RC3"
MAPPING_CREATOR_JAR_URL="https://github.com/clarin-eric/VLO-mapping-creator/releases/download/${MAPPING_CREATOR_VERSION}/vlo-mapping-creator.jar"
JAR_TARGET="$(mktemp -d)/vlo-mapping-creator.jar"

# get mapping binary
echo "Retrieving mapping creator from ${MAPPING_CREATOR_JAR_URL}..."
curl -L -s -o  "$JAR_TARGET" "$MAPPING_CREATOR_JAR_URL"

# define function to apply mapping
vlo_mapping() {
  OPTS=""
  while [[ "$#" -gt 1 ]]; do
  	OPTS="$OPTS $1"
  	shift
  done
  
  echo "Creating $1.xml"
  java -jar "$JAR_TARGET" $OPTS "$1.csv" > "dist/$1.xml"
}

# build maps
(
	cd $(dirname "$0")/..
	source "script/build-maps.inc.sh"
)

set +e
rm "$JAR_TARGET"
