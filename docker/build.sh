#!/bin/bash
set -e

cp /app/configs/default.json /app/src/run_config.json

# Build Solid
echo "=========================== SOLID EXPORT"
sed -i 's/"ENGINE": "cadquery",/"ENGINE": "solid",/' /app/src/run_config.json
conda run -n dactyl-manuform python3 -i src/dactyl_manuform.py

# Convert plate to SVG
echo "=========================== SVG PLATE FILES"
for plate_file in /app/things/*_PLATE.scad
do
    plate_output_file=${plate_file%.scad}.svg
    openscad -o ${plate_output_file} ${plate_file}
done

# Build Cadquery
echo "=========================== CADQUERY EXPORT"
sed -i 's/"ENGINE": "solid",/"ENGINE": "cadquery",/' /app/src/run_config.json
conda run -n dactyl-manuform python3 -i src/dactyl_manuform.py

rm /app/src/run_config.json
