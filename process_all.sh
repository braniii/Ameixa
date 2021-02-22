#!/bin/bash

# Check dependencies
command -v inkscape >/dev/null 2>&1 || { echo >&2 "I require inkscape but it's not installed. Aborting."; exit 1; }
command -v scour >/dev/null 2>&1 || { echo >&2 "I require scour but it's not installed. Aborting."; exit 1; }
command -v optipng >/dev/null 2>&1 || { echo >&2 "I require optipng but it's not installed. Aborting."; exit 1; }

./process1_wipsvg-xml_CHROMA.sh
./process2_monochroming.sh
./process3_wipsvg-xml_MONO.sh
./process4_optimize_png.sh
./check_icons.sh
