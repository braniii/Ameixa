#!/bin/bash

DEFINITION_FILE="app/src/main/res/xml/appfilter.xml"
SVG_BASE_FOLDER="icons"
TODO_FOLDER="todo"
ICON_TYPES="chromatic monochromatic"
ICON_SIZES="drawable-mdpi drawable-hdpi drawable-xhdpi drawable-xxhdpi drawable-xxxhdpi"

DEFAULT_ICON_TYPE=$(echo "${ICON_TYPES}" | cut -d" " -f1)

return_value=0

echo Checking "each icon definition has an existing svg icon file for each type"...
ICON_DEFINITIONS=$(sed 's/ /\n/g' ${DEFINITION_FILE} | grep "drawable" | cut -d"\"" -f2 | sort | uniq)
for ICON in ${ICON_DEFINITIONS}
do
    for TYPE in ${ICON_TYPES}
    do
        FILE="${SVG_BASE_FOLDER}/${TYPE}/${ICON}.svg"
        if [ ! -f "${FILE}" ]
        then
            FILETODO="${TODO_FOLDER}/${ICON}.svg"
            if [ ! -f "${FILETODO}" ]
            then
                echo "Icon requested in ${DEFINITION_FILE} but neither file found: ${FILE} nor ${FILETODO}"
                return_value=$((return_value + 1))
            fi
        fi
    done
done
echo "ok, done"

echo Checking "each svg icon file exists in each icon type"...
for TYPE1 in ${ICON_TYPES}
do
    for TYPE2 in ${ICON_TYPES}
    do
        if [ "${TYPE1}" != "${TYPE2}" ]
        then
            for SVG in ${SVG_BASE_FOLDER}/${TYPE1}/*.svg
            do
                FILE="${SVG_BASE_FOLDER}/${TYPE2}/$(basename ${SVG})"
                if [ ! -f "${FILE}" ]
                then
                    echo "File icon found in ${TYPE1} but missing in ${TYPE2}: ${FILE}"
                    return_value=$((return_value + 1))
                fi
            done
        fi
    done
done
echo "ok, done"

echo Checking "each svg icon file has at least one icon definition"...
for SVG in ${SVG_BASE_FOLDER}/${DEFAULT_ICON_TYPE}/*.svg
do
    ICON_NAME=$(basename ${SVG} .svg)
    SEARCH_STRING="drawable=\"${ICON_NAME}\""
    FOUND=$(grep ${SEARCH_STRING} ${DEFINITION_FILE} | wc -l | awk '{print $0}')
    if [ $FOUND -eq 0 ]
    then
        echo "File found but not referenced in ${DEFINITION_FILE}: ${ICON_NAME}"
        return_value=$((return_value + 1))
    fi
done
echo "ok, done"

echo Checking "each svg file has a png rendered file in each type/size"...
for SVG in ${SVG_BASE_FOLDER}/${DEFAULT_ICON_TYPE}/*.svg
do
    ICON_NAME=$(basename ${SVG} .svg)
    for TYPE in ${ICON_TYPES}
    do
        for SIZE in ${ICON_SIZES}
        do
            FILE="app/src/${TYPE}/res/${SIZE}/${ICON_NAME}.png"
            if [ ! -f "${FILE}" ]
            then
                echo "File icon found but generated file not found: ${FILE}"
                return_value=$((return_value + 1))
            fi
        done
    done
done
echo "ok, done"

echo ""
echo "ok, all checks done. found ${return_value} errors"

exit "${return_value}"
