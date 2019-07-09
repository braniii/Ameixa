#! /bin/bash

# get from todo
for SVG in todo/*.svg
do
  if [ -f "${SVG}" ]; then
    N=$(basename ${SVG} .svg)
    inkscape -f ${SVG} -w 48 -h 48 -e \
    	app/src/chromatic/res/drawable-mdpi/${N}.png
    inkscape -f ${SVG} -w 72 -h 72 -e \
    	app/src/chromatic/res/drawable-hdpi/${N}.png
    inkscape -f ${SVG} -w 96 -h 96 -e \
    	app/src/chromatic/res/drawable-xhdpi/${N}.png
    inkscape -f ${SVG} -w 144 -h 144 -e \
    	app/src/chromatic/res/drawable-xxhdpi/${N}.png
    inkscape -f ${SVG} -w 192 -h 192 -e \
    	app/src/chromatic/res/drawable-xxxhdpi/${N}.png

    cp ${SVG} ${SVG}.tmp
    scour --remove-descriptive-elements --enable-id-stripping --enable-viewboxing --enable-comment-stripping --nindent=4 -i ${SVG}.tmp -o ${SVG}
    rm ${SVG}.tmp

    mv ${SVG} icons/chromatic
  fi
done

# "xml" create corresponding "values/iconpack.xml" and "xml/drawable.xml"
SVGDIR="icons/chromatic/"
EXPORT="app/src/main/res"
ICPACK_PRE='        <item>'
ICPACK_SUF='</item>\n'
DRAWABLE_PRE='    <item drawable="'
DRAWABLE_SUF='" />\n'

printf '<?xml version="1.0" encoding="utf-8"?>\n<resources>\n    <string-array name="icon_pack" translatable="false">\n' > iconpack.xml
printf '<?xml version="1.0" encoding="utf-8"?>\n<resources>\n    <version>1</version>\n' > drawable.xml

for DIR in $(find ${SVGDIR} -name "*.svg" | sed "s/\.svg$//g" | sort)
do
  FILE=${DIR##*/}
  NAME=${FILE%.*}
  printf "${ICPACK_PRE}${NAME}${ICPACK_SUF}" >> iconpack.xml
  printf "${DRAWABLE_PRE}${NAME}${DRAWABLE_SUF}" >> drawable.xml
done

printf '    </string-array>\n</resources>\n' >> iconpack.xml
printf '</resources>\n' >> drawable.xml

mv -f iconpack.xml ${EXPORT}/values/
mv -f drawable.xml ${EXPORT}/xml/
