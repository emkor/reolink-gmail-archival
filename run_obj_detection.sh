#!/usr/bin/env bash

set -e

IMG_DIR=$1
RESULTS_DIR=$2
RENDER_DIR=$3

mkdir -p tmp_image
mkdir -p tmp_render
mkdir -p tmp_result

for d in $(find $IMG_DIR/* -type d | sort)
do
  RESULT_PATH="$RESULTS_DIR/"$(basename $d)
  FILTERED_RESULTS_FILE="$RESULTS_DIR/"$(basename $d)"_filter.json"
  RENDER_PATH="$RENDER_DIR/$(basename $d)"
  IMG_COUNT_BEFORE=$(find $d -type f -name "*.jpg" | wc -l)
  mv $d/* tmp_image
  mkdir -p $RENDER_PATH
  mkdir -p $RESULT_PATH
  echo "Starting object detection job for $d ($IMG_COUNT_BEFORE images) with output path of $RENDER_PATH"
  docker-compose up --no-color recogn
  docker-compose up --no-color filter
  docker-compose up --no-color render
  mv tmp_image/* $d
  mv tmp_result/* $RESULT_PATH
  for ri in $(find tmp_render -type f -name "*.jpg"); do mv $ri $RENDER_PATH/ ; done
  IMG_COUNT_AFTER=$(find $RENDER_PATH -type f -name "*.jpg" | wc -l)
  echo "Done job for $d, $IMG_COUNT_BEFORE -> $IMG_COUNT_AFTER"
done

docker-compose down

# nohup ./run_obj_detection.sh ./dl_img ./result ./render >> ./obj_detection.log 2>&1 &