#!/bin/bash
# Thanks to Pander

if [ -e icons/monochromatic ]; then
    rm -rf icons/monochromatic
fi

mkdir icons/monochromatic

# I want to see it painted, painted black
cp -r icons/chromatic/* icons/monochromatic

cd icons/monochromatic

# Black as night, black as coal
dark=232323

SVG_TAGS_TO_SEARCH="rect path g"
SVG_ATTR_TO_SEARCH="fill stroke"
# I want to see the sun, blotted out from the sky
COLORS_TO_CONVERT_TO_DARK="009688 00bcd4 03a9f4 2196f3 263238 3f51b5 4caf50 607d8b 673ab7 795548 8bc34a 9c27b0 9e9e9e cddc39 e91e63 f44336 ff5722 ff9800 ffc107 ffeb3b"

for tag in ${SVG_TAGS_TO_SEARCH}
do
    for attr in ${SVG_ATTR_TO_SEARCH}
    do
        echo Before '<'${tag}'.*" '${attr}'="#......"/>'
        grep '<'${tag}'.*" '${attr}'="#......"/>' *.svg|awk -F "${attr}" '{print $2}'|sort|uniq -c|sort -nr
    done
done

# I want to see it painted, painted, painted, painted black
for i in *svg
do
    echo Monochroming ${i}...
    for col in ${COLORS_TO_CONVERT_TO_DARK}
    do
        for tag in ${SVG_TAGS_TO_SEARCH}
        do
            for attr in ${SVG_ATTR_TO_SEARCH}
            do
                if [ `grep -hc '<'${tag}'.*" '${attr}'="#'${col} ${i}`'"/>' != 0 ]
                then
                    sed -i -e 's/\('${tag}' .*" '${attr}'="#\)'${col}'"/\1'${dark}'"/g' ${i}
                fi
            done
        done
    done
done

# hasta aqui funciona OK, revisar arriba los colores para arreglar fallo naranja
# up here works OK, check the colors above to fix orange failure
