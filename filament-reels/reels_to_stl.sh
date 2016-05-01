#!/bin/bash
# Convert all reels from SCAD to STL
STL_DIR=stl
for SCAD_FILE in reels_scad/*.scad; do
  STL_FILE=$STL_DIR/$(basename $SCAD_FILE .scad).stl
  CMD="./scad2stl.sh $SCAD_FILE $STL_FILE"
  echo $CMD
  time $($CMD)
done
