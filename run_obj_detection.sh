#!/usr/bin/env bash

set -e

IMG_DIR=$1
RESULTS_DIR=$2
RENDER_DIR=$3
MODEL_FILE=$4
CLASSES_FILE=$5

source ~/recogn-img/.venv/recogn-img/bin/activate

for d in $(find $IMG_DIR -type d | grep "20" | sort)
do
  RESULTS_FILE="$RESULTS_DIR/"$(basename $d)".json"
  FILTERED_RESULTS_FILE="$RESULTS_DIR/"$(basename $d)"_filter.json"
  RENDER_PATH="$RENDER_DIR/$(basename $d)"
  IMG_COUNT_BEFORE=$(find $d -type f -name "*.jpg" | wc -l)
  echo "Starting object detection job for $d ($IMG_COUNT_BEFORE images) with output path of $RENDER_PATH"
  mkdir -p $RENDER_PATH
  recogn-img $MODEL_FILE $CLASSES_FILE $d $RESULTS_FILE --box-threshold 0.4 --obj-threshold 0.5
  result-filter $RESULTS_FILE $FILTERED_RESULTS_FILE --whitelist car,truck,train,motorbike,bus,boat,aeroplane,bicycle,person,dog,cow,horse,cat,sheep,bear,elephant,zebra,bird,giraffe
  render-recogn --copy-exif $FILTERED_RESULTS_FILE $RENDER_PATH
  IMG_COUNT_AFTER=$(find $RENDER_PATH -type f -name "*.jpg" | wc -l)
  echo "Done job for $d, $IMG_COUNT_BEFORE -> $IMG_COUNT_AFTER"
done
py