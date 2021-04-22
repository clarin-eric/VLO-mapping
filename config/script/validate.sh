#!/bin/bash
CONFIG_FILE="$(cd $(dirname "$0")/.. && pwd)/facetsConfiguration.xml"

SCHEMA_URL="https://raw.githubusercontent.com/clarin-eric/VLO/master/vlo-commons/src/main/resources/facetsConfiguration.xsd"

# check XML well-formedness

if ! xmllint "${CONFIG_FILE}"; then
	echo "XML parsing error in ${CONFIG_FILE}"
	exit 1
fi

# check schema validity

echo "Validating ${CONFIG_FILE} against ${SCHEMA_URL}"

SCHEMA_TMP_FILE="$(mktemp -d)/facetsConfiguration.xsd"
curl -o "${SCHEMA_TMP_FILE}" "${SCHEMA_URL}" 
if ! xmllint --schema "${SCHEMA_TMP_FILE}" "${CONFIG_FILE}"; then
	echo "XML validation file in ${CONFIG_FILE}"
	exit 1
fi
