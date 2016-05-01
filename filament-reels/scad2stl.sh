#!/bin/bash
# ln -s /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD ~/bin/openscad
# https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Using_OpenSCAD_in_a_command_line_environment

SCAD_FILE=$1
STL_FILE=$2

mkdir -p $(dirname $STL_FILE)
openscad -o $STL_FILE -D 'quality="production"' $SCAD_FILE
