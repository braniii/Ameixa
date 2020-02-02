#!/bin/bash

ICON_TYPES="chromatic monochromatic"
ICON_SIZES="drawable-mdpi drawable-hdpi drawable-xhdpi drawable-xxhdpi drawable-xxxhdpi"

OPTIPNG_OPTIONS="-preserve -quiet -o7"

# Check optipng dependency
command -v optipng >/dev/null 2>&1 || { echo >&2 "I require optipng but it's not installed. Aborting."; exit 1; }

for TYPE in ${ICON_TYPES}
do
    echo "Type: ${TYPE}"
    for SIZE in ${ICON_SIZES}
    do
        echo "Size: ${SIZE}"
        for FILE in app/src/${TYPE}/res/${SIZE}/*.png
        do
            echo "File: ${FILE}"
            optipng ${OPTIONS} ${FILE}
        done
    done
done
