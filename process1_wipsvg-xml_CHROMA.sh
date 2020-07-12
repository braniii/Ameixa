#! /bin/bash

# get from todo
for SVG in todo/*.svg
do
  if [[ -f "${SVG}" ]]; then
    N=$(basename ${SVG} .svg)
    inkscape -w 48 -h 48 -o \
    	app/src/chromatic/res/drawable-mdpi/${N}.png ${SVG}
    inkscape -w 72 -h 72 -o \
    	app/src/chromatic/res/drawable-hdpi/${N}.png ${SVG}
    inkscape -w 96 -h 96 -o \
    	app/src/chromatic/res/drawable-xhdpi/${N}.png ${SVG}
    inkscape -w 144 -h 144 -o \
    	app/src/chromatic/res/drawable-xxhdpi/${N}.png ${SVG}
    inkscape -w 192 -h 192 -o \
    	app/src/chromatic/res/drawable-xxxhdpi/${N}.png ${SVG}

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
