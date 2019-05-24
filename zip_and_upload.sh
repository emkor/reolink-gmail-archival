#!/usr/bin/env bash

set -e

IN_DIR=$1
TMP_DIR=$2

echo "Running cam data archival job..."
source ~/cam/reolink-gmail-archival/creds.sh
b2 authorize-account ${B2_KEY_ID} ${B2_APP_KEY}
TODAY=$(date --iso-8601 --utc)
TMP_ZIP="$TMP_DIR/$TODAY.zip"
TMP_ZIP_NAME=$(basename ${TMP_ZIP})
FILE_LIST=$(find ${IN_DIR} -name "*.jpg" | grep -v ${TODAY})
FILE_COUNT=$(echo "$FILE_LIST" | wc -l)
mkdir -p ${TMP_DIR}
echo "Archiving $FILE_COUNT files on $TODAY using $TMP_DIR ..."
for f in ${FILE_LIST}; do mv ${f} ${TMP_DIR}; done

echo "Zipping into $TMP_ZIP..."
zip -r -j -1 -q ${TMP_ZIP} ${TMP_DIR}

echo "Uploading $TMP_ZIP into $B2_BUCKET/$TMP_ZIP_NAME..."
b2 upload-file --noProgress ${B2_BUCKET} ${TMP_ZIP} ${TMP_ZIP_NAME}

echo "Removing $TMP_DIR and $TMP_ZIP ..."
rm -rf ${TMP_DIR}/*

echo "Done!"