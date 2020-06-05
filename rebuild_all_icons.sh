#!/bin/bash

# Move all existing chromatic icons to "todo" folder
mv icons/chromatic/*.svg todo

# Process all icons
./process_all.sh
