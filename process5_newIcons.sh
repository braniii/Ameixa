#! /bin/bash
# create list of latest 8 icon additions
NUMBER=8
IMPORT="app/src/main/res/xml"
EXPORT="website"
# head is needed to strip nova launcher specific values
awk '$1 ~ /^ *drawable=/ {print "<item " $1 " />";}' $IMPORT/appfilter.xml | head -n -10 | tail -n $NUMBER > $EXPORT/newdrawable.xml
