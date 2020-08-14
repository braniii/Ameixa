#! /bin/bash

# Delete current icons to re-monochrome (yes, despite how long this takes, its a necessary evil)
rm -rf app/src/monochromatic/res/drawable-mdpi
rm -rf app/src/monochromatic/res/drawable-hdpi
rm -rf app/src/monochromatic/res/drawable-xhdpi
rm -rf app/src/monochromatic/res/drawable-xxhdpi
rm -rf app/src/monochromatic/res/drawable-xxxhdpi

# recreate the now empty folders
if [[ ! -e app/src/monochromatic/res/drawable-mdpi ]]; then
    mkdir -p app/src/monochromatic/res/drawable-mdpi
fi
if [[ ! -e app/src/monochromatic/res/drawable-hdpi ]]; then
    mkdir -p app/src/monochromatic/res/drawable-hdpi
fi
if [[ ! -e app/src/monochromatic/res/drawable-xhdpi ]]; then
    mkdir -p app/src/monochromatic/res/drawable-xhdpi
fi
if [[ ! -e app/src/monochromatic/res/drawable-xxhdpi ]]; then
    mkdir -p app/src/monochromatic/res/drawable-xxhdpi
fi
if [[ ! -e app/src/monochromatic/res/drawable-xxxhdpi ]]; then
    mkdir -p app/src/monochromatic/res/drawable-xxxhdpi
fi

# get from icons/monochromatic
for SVG in icons/monochromatic/*.svg
do
  if [[ -f "${SVG}" ]]; then
    N=$(basename ${SVG} .svg)
    inkscape -w 48 -h 48 -o \
        app/src/monochromatic/res/drawable-mdpi/${N}.png ${SVG}
    inkscape -w 72 -h 72 -o \
        app/src/monochromatic/res/drawable-hdpi/${N}.png ${SVG}
    inkscape -w 96 -h 96 -o \
        app/src/monochromatic/res/drawable-xhdpi/${N}.png ${SVG}
    inkscape -w 144 -h 144 -o \
        app/src/monochromatic/res/drawable-xxhdpi/${N}.png ${SVG}
    inkscape -w 192 -h 192 -o \
        app/src/monochromatic/res/drawable-xxxhdpi/${N}.png ${SVG}

    cp ${SVG} ${SVG}.tmp
    scour --remove-descriptive-elements --enable-id-stripping --enable-viewboxing --enable-comment-stripping --nindent=4 -i ${SVG}.tmp -o ${SVG}
    rm ${SVG}.tmp
  fi
done
