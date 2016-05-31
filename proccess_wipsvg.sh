#!/bin/bash

# Thanks to t184256
# Requires Inkscape and Imagemagic


for SVG in svgs/wip/*.svg; do
	N=$(basename $SVG .svg)
	inkscape -f $SVG -w 48 -h 48 -e \
		app/src/main/res/drawable-mdpi/$N.png
	inkscape -f $SVG -w 72 -h 72 -e \
		app/src/main/res/drawable-hdpi/$N.png
	inkscape -f $SVG -w 96 -h 96 -e \
		app/src/main/res/drawable-xhdpi/$N.png
	inkscape -f $SVG -w 144 -h 144 -e \
		app/src/main/res/drawable-xxhdpi/$N.png
	inkscape -f $SVG -w 192 -h 192 -e \
		app/src/main/res/drawable-xxxhdpi/$N.png
	inkscape -f $SVG -w 384 -h 384 -e \
		app/src/main/res/drawable-nodpi/nodpi_$N.png
	mv $SVG svgs/depot/
done
