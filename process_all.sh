#!/bin/bash

./process1_wipsvg-xml_CHROMA.sh
./process2_monochroming.sh
./process3_wipsvg-xml_MONO.sh
./process4_optimize_png.sh
./check_icons.sh
