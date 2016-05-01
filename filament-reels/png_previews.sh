PNG_DIR=png
mkdir -p $PNG_DIR
for SCAD_FILE in reels_scad/*.scad; do
  PNG_FILE=$PNG_DIR/$(basename $SCAD_FILE .scad).png
  openscad -o $PNG_FILE $SCAD_FILE --camera=0,0,220,0,0,0
done
