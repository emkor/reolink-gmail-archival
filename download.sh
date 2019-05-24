#!/usr/bin/env bash

set -e

OUT_DIR=$1
LOG_FILE=$2

echo "Starting gmail-dl..."
source ./creds.sh
gmail-dl ${OUT_DIR} --days 2 --log ${LOG_FILE}
echo "Done!"