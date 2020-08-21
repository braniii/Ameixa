#! /bin/bash
# create list of icons sorted as first appearing in appfilter.xml
IMPORT="app/src/main/res/xml"
EXPORT="website"
OUTPUT="${EXPORT}/drawable.xml"

printf '<?xml version="1.0" encoding="utf-8"?>\n<resources>\n<version>1</version>\n' > $OUTPUT

# head is needed to strip nova launcher specific values
awk '$1 ~ /^ *drawable=/ {print "<item " $1 " />";}' $IMPORT/appfilter.xml | head -n -10 | awk ' !x[$0]++' >> $OUTPUT

printf '</resources>\n' >> $OUTPUT
