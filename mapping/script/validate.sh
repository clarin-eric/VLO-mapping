#!/bin/bash
MAPPING_FILE="$(cd $(dirname "$0")/.. && pwd)/facetConcepts.xml"

# check XML well-formedness

if ! xmllint "${MAPPING_FILE}"; then
	echo "XML parsing error in ${MAPPING_FILE}"
	exit 1
fi
