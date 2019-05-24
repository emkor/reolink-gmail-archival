#!/usr/bin/env bash

set -e

OUT_DIR=$1

echo "Starting gmail-dl..."
source ~/cam/reolink-gmail-archival/creds.sh
gmail-dl ${OUT_DIR} --days 2 --log ~/cam/log/gmail-dl.log --rm
echo "Done!"