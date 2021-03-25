#!/bin/bash
# Thanks to Pander

if [[ -e icons/monochromatic ]]; then
    rm -rf icons/monochromatic
fi

mkdir icons/monochromatic

# I want to see it painted, painted black
echo "Overwrite old monochromatic icons with chromatic ones..."
cp -r icons/chromatic/* icons/monochromatic

cd icons/monochromatic

# Black as night, black as coal
DARK_COLOR="#232323"

SVG_TAGS_TO_SEARCH="rect path g"
SVG_ATTR_TO_SEARCH="fill stroke"
# I want to see the sun, blotted out from the sky
COLORS_TO_CONVERT_TO_DARK="
    #009688
    #00bcd4
    #03a9f4
    #1a237e
    #2196f3
    #263238
    #3f51b5
    #4caf50
    #607d8b
    #673ab7
    #795548
    #8bc34a
    #9c27b0
    #9e9e9e
    #bf360c
    #cddc39
    #e91e63
    #f44336
    #ff5722
    #ff9800
    #ffc107
    #ffeb3b
"

echo "List colors to convert to ${DARK_COLOR}:"
for TAG in ${SVG_TAGS_TO_SEARCH}
do
    for ATTR in ${SVG_ATTR_TO_SEARCH}
    do
        for COLOR in ${COLORS_TO_CONVERT_TO_DARK}
        do
            COUNT=$(grep -iE "<${TAG} .*${ATTR}=\"${COLOR}\"" *.svg | wc -l | awk '{print $1}')
            if [[ "${COUNT}" -ne "0" ]]
            then
                echo "<${TAG} ${ATTR}=\"${COLOR}\" -> ${COUNT}"
            fi
        done
    done
done

# I want to see it painted, painted, painted, painted black
echo "Converting icons..."
for ICON_NAME in *svg
do
    echo Monochroming ${ICON_NAME}...
    for COLOR in ${COLORS_TO_CONVERT_TO_DARK}
    do
        for TAG in ${SVG_TAGS_TO_SEARCH}
        do
            for ATTR in ${SVG_ATTR_TO_SEARCH}
            do
                if [[ $(grep -iEhc "<${TAG} .*${ATTR}=\"${COLOR}\"" ${ICON_NAME}) != 0 ]]
                then
                    sed -i -e 's/\('${TAG}' .*'${ATTR}'="\)'${COLOR}'"/\1'${DARK_COLOR}'"/gi' ${ICON_NAME}
                fi
            done
        done
    done
done

# hasta aqui funciona OK, revisar arriba los colores para arreglar fallo naranja
# up here works OK, check the colors above to fix orange failure
