#!/bin/bash

DEFINITION_FILE="app/src/main/res/xml/appfilter.xml"
DRAWABLE_FILE="app/src/main/res/xml/drawable.xml"
ICONPACK_FILE="app/src/main/res/values/iconpack.xml"
SVG_BASE_FOLDER="icons"
TODO_FOLDER="todo"
ICON_TYPES="chromatic monochromatic"
ICON_SIZES="drawable-mdpi drawable-hdpi drawable-xhdpi drawable-xxhdpi drawable-xxxhdpi"

DEFAULT_ICON_TYPE=$(echo "${ICON_TYPES}" | cut -d" " -f1)

CHECK_COUNT="12"
return_value=0

echo "(1/${CHECK_COUNT}) Checking \"each application component name is unique in ${DEFINITION_FILE}\"..."
DUPLICATES=$(grep "component=" ${DEFINITION_FILE} | sort | uniq --count --repeated)
DUPLICATES_COUNT=$(echo "${DUPLICATES}" | sed '/^$/d' | wc -l | awk '{print $0}')
if [[ $DUPLICATES_COUNT -ne 0 ]]
then
    echo "Found duplicates in ${DEFINITION_FILE}"
    echo -e "${DUPLICATES}"
    return_value=$((return_value + ${DUPLICATES_COUNT}))
fi
echo "ok, done"

echo "(2/${CHECK_COUNT}) Checking \"consistant formatting ${DEFINITION_FILE}\"..."

WRONGINDENT_ITEM=$(grep -nE "<item" ${DEFINITION_FILE} | grep -vE "^*:    <item$")
WRONGINDENT_COMPONENT=$(grep -nE "component=" ${DEFINITION_FILE} | grep -vE "^*:        component=\"ComponentInfo\{.*\}\"$" | grep -vE "component=\":")
WRONGINDENT_DRAWABLE=$(grep -nE "drawable=" ${DEFINITION_FILE} | grep -vE "^*:        drawable=\".*\" />$")
WRONGINDENT_ITEM_COUNT=$(echo "${WRONGINDENT_ITEM}" | sed '/^$/d' | wc -l)
WRONGINDENT_COMPONENT_COUNT=$(echo "${WRONGINDENT_COMPONENT}" | sed '/^$/d' | wc -l)
WRONGINDENT_DRAWABLE_COUNT=$(echo "${WRONGINDENT_DRAWABLE}" | sed '/^$/d' | wc -l)
WRONGINDENT_COUNT=$((WRONGINDENT_ITEM_COUNT + WRONGINDENT_COMPONENT_COUNT + WRONGINDENT_DRAWABLE_COUNT))
if [[ $WRONGINDENT_COUNT -ne 0 ]]
then
    echo "Found wrong indent in ${DEFINITION_FILE}"
    echo -e "${WRONGINDENT_ITEM}\n${WRONGINDENT_COMPONENT}\n${WRONGINDENT_DRAWABLE}"
    return_value=$((return_value + ${WRONGINDENT_COUNT}))
fi
echo "ok, done"

echo "(3/${CHECK_COUNT}) Checking \"each icon definition in ${DEFINITION_FILE} has an existing svg icon file for each type\"..."
ICON_DEFINITIONS=$(sed 's/ /\n/g' ${DEFINITION_FILE} | grep "drawable" | cut -d"\"" -f2 | sort | uniq)
for ICON in ${ICON_DEFINITIONS}
do
    for TYPE in ${ICON_TYPES}
    do
        FILE="${SVG_BASE_FOLDER}/${TYPE}/${ICON}.svg"
        if [[ ! -f "${FILE}" ]]
        then
            FILETODO="${TODO_FOLDER}/${ICON}.svg"
            if [[ ! -f "${FILETODO}" ]]
            then
                echo "Icon requested in ${DEFINITION_FILE} but neither file found: ${FILE} nor ${FILETODO}"
                return_value=$((return_value + 1))
            fi
        fi
    done
done
echo "ok, done"

echo "(4/${CHECK_COUNT}) Checking \"each icon definition in ${DRAWABLE_FILE} has an existing svg icon file for each type\"..."
ICON_DRAWABLE=$(sed 's/ /\n/g' ${DRAWABLE_FILE} | grep "drawable" | cut -d"\"" -f2 | sort | uniq)
for ICON in ${ICON_DRAWABLE}
do
    for TYPE in ${ICON_TYPES}
    do
        FILE="${SVG_BASE_FOLDER}/${TYPE}/${ICON}.svg"
        if [[ ! -f "${FILE}" ]]
        then
            FILETODO="${TODO_FOLDER}/${ICON}.svg"
            if [[ ! -f "${FILETODO}" ]]
            then
                echo "Icon requested in ${DRAWABLE_FILE} but neither file found: ${FILE} nor ${FILETODO}"
                return_value=$((return_value + 1))
            fi
        fi
    done
done
echo "ok, done"

echo "(5/${CHECK_COUNT}) Checking \"each icon definition in ${ICONPACK_FILE} has an existing svg icon file for each type\"..."
ICON_ICONPACK=$(sed 's/ /\n/g' ${ICONPACK_FILE} | grep "item" | cut -d">" -f2 | cut -d"<" -f1 | sort | uniq)
for ICON in ${ICON_ICONPACK}
do
    for TYPE in ${ICON_TYPES}
    do
        FILE="${SVG_BASE_FOLDER}/${TYPE}/${ICON}.svg"
        if [[ ! -f "${FILE}" ]]
        then
            FILETODO="${TODO_FOLDER}/${ICON}.svg"
            if [[ ! -f "${FILETODO}" ]]
            then
                echo "Icon requested in ${ICONPACK_FILE} but neither file found: ${FILE} nor ${FILETODO}"
                return_value=$((return_value + 1))
            fi
        fi
    done
done
echo "ok, done"

echo "(6/${CHECK_COUNT}) Checking \"each svg icon file exists in each icon type\"..."
for TYPE1 in ${ICON_TYPES}
do
    for TYPE2 in ${ICON_TYPES}
    do
        if [[ "${TYPE1}" != "${TYPE2}" ]]
        then
            for SVG in ${SVG_BASE_FOLDER}/${TYPE1}/*.svg
            do
                FILE="${SVG_BASE_FOLDER}/${TYPE2}/$(basename ${SVG})"
                if [[ ! -f "${FILE}" ]]
                then
                    echo "File icon found in ${TYPE1} but missing in ${TYPE2}: ${FILE}"
                    return_value=$((return_value + 1))
                fi
            done
        fi
    done
done
echo "ok, done"

echo "(7/${CHECK_COUNT}) Checking \"each svg icon file has at least one icon definition in ${DEFINITION_FILE}\"..."
for SVG in ${SVG_BASE_FOLDER}/${DEFAULT_ICON_TYPE}/*.svg
do
    ICON_NAME=$(basename ${SVG} .svg)
    SEARCH_STRING="drawable=\"${ICON_NAME}\""
    FOUND=$(grep ${SEARCH_STRING} ${DEFINITION_FILE} | wc -l | awk '{print $0}')
    if [[ $FOUND -eq 0 ]]
    then
        echo "File found but not referenced in ${DEFINITION_FILE}: ${ICON_NAME}"
        return_value=$((return_value + 1))
    fi
done
echo "ok, done"

echo "(8/${CHECK_COUNT}) Checking \"each svg icon file has at least one icon definition in ${DRAWABLE_FILE}\"..."
for SVG in ${SVG_BASE_FOLDER}/${DEFAULT_ICON_TYPE}/*.svg
do
    ICON_NAME=$(basename ${SVG} .svg)
    SEARCH_STRING="drawable=\"${ICON_NAME}\""
    FOUND=$(grep ${SEARCH_STRING} ${DRAWABLE_FILE} | wc -l | awk '{print $0}')
    if [[ $FOUND -eq 0 ]]
    then
        echo "File found but not referenced in ${DRAWABLE_FILE}: ${ICON_NAME}"
        return_value=$((return_value + 1))
    fi
done
echo "ok, done"

echo "(9/${CHECK_COUNT}) Checking \"each svg icon file has at least one icon definition in ${ICONPACK_FILE}\"..."
for SVG in ${SVG_BASE_FOLDER}/${DEFAULT_ICON_TYPE}/*.svg
do
    ICON_NAME=$(basename ${SVG} .svg)
    SEARCH_STRING="<item>${ICON_NAME}</item>"
    FOUND=$(grep ${SEARCH_STRING} ${ICONPACK_FILE} | wc -l | awk '{print $0}')
    if [[ $FOUND -eq 0 ]]
    then
        echo "File found but not referenced in ${ICONPACK_FILE}: ${ICON_NAME}"
        return_value=$((return_value + 1))
    fi
done
echo "ok, done"

echo "(10/${CHECK_COUNT}) Checking \"each svg file has a png rendered file in each type/size\"..."
for SVG in ${SVG_BASE_FOLDER}/${DEFAULT_ICON_TYPE}/*.svg
do
    ICON_NAME=$(basename ${SVG} .svg)
    for TYPE in ${ICON_TYPES}
    do
        for SIZE in ${ICON_SIZES}
        do
            FILE="app/src/${TYPE}/res/${SIZE}/${ICON_NAME}.png"
            if [[ ! -f "${FILE}" ]]
            then
                echo "File icon found but generated file not found: ${FILE}"
                return_value=$((return_value + 1))
            fi
        done
    done
done
echo "ok, done"

echo "(11/${CHECK_COUNT}) Checking \"each generated png icon file is referenced in ${DEFINITION_FILE}\"..."
for TYPE in ${ICON_TYPES}
do
    for SIZE in ${ICON_SIZES}
    do
        for PNG in app/src/${TYPE}/res/${SIZE}/*.png
        do
            ICON_NAME=$(basename ${PNG} .png)
            SEARCH_STRING="drawable=\"${ICON_NAME}\""
            FOUND=$(grep ${SEARCH_STRING} ${DEFINITION_FILE} | wc -l | awk '{print $0}')
            if [[ $FOUND -eq 0 ]]
            then
                echo "File found but not referenced in ${DEFINITION_FILE}: ${PNG}"
                return_value=$((return_value + 1))
            fi
        done
    done
done
echo "ok, done"

echo "(12/${CHECK_COUNT}) Checking \"each monochrome png file is really monochrome\"..."
PNG_MONOCHROMATIC_BASE_FOLDER="app/src/monochromatic/res/drawable-xxxhdpi"
for PNG in ${PNG_MONOCHROMATIC_BASE_FOLDER}/*.png
do
    # compare image with its grayscaled clone
    MISMATCH_VALUE="$(convert "${PNG}" \( +clone -colorspace Gray \) -metric AE -compare -format %[distortion] info: | awk '{print $1}')"

    if [[ "${MISMATCH_VALUE}" != "0" ]]; then
        echo "File icon seems not properly monochromed: ${PNG} // ${MISMATCH_VALUE}"
        return_value=$((return_value + 1))
    fi
done
echo "ok, done"

echo ""
echo "ok, all checks done. found ${return_value} errors"

exit "${return_value}"
