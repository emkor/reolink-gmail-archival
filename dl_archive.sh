#!/usr/bin/env bash

set -e

TMP_DIR=$1

source creds.sh
b2 authorize-account ${B2_KEY_ID} ${B2_APP_KEY}

mkdir -p ${TMP_DIR}
FILE_LIST=$(b2 ls ${B2_BUCKET})
FILE_COUNT=$(echo "$FILE_LIST" | wc -l)

echo "Attempting download of $FILE_COUNT files from $B2_BUCKET..."

for f in ${FILE_LIST}
do
    filename="${f%.*}"
    mkdir -p "$TMP_DIR/$filename"
    b2 download-file-by-name --noProgress ${B2_BUCKET} ${f} "$TMP_DIR/$filename/$f"
    unzip -q "$TMP_DIR/$filename/$f" -d "$TMP_DIR/$filename"
    rm -rf "$TMP_DIR/$filename/$f"
    photo_count=$(ls "$TMP_DIR/$filename" | wc -l)
    echo "Downloaded file $f containing $photo_count photos into $TMP_DIR/$filename"
done

echo "Done downloading $FILE_COUNT files from $B2_BUCKET!"