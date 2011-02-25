#!/bin/bash

export IFS=$'\n'

SRC_FILE="countries2007_all.csv"
TMP_FILE="countries2007_liberty.csv.tmp"
FINAL_FILE="countries2007_liberty.csv"

#cut -d ',' -f 2,3 "${SRC_FILE}" | sed 's/\(^.*$\)/\1,/g' > "${TMP_FILE}"

for LINE in $(cat "${TMP_FILE}")
do
	COUNTRY_CODE=$(echo "$LINE" | cut -d ',' -f 2 | sed 's/"\(.*\)"/\1/g')
	LIBERTY_INDEX=$(curl "http://perspective.usherbrooke.ca/bilan/tend/${COUNTRY_CODE}/fr/PF.CIV.RIGH.POL.IN.html" 2>/dev/null | grep "2007\*\?</td><td class='tableauBarreDroite'>.*</td></tr>" | sed 's,<tr><td class=[^>]*>[^<]*</td><td class=[^>]*>\([^<]*\)</td></tr>,\1,g')
	echo $LINE$LIBERTY_INDEX
done >> ${FINAL_FILE}