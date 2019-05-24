#!/usr/bin/env bash

echo "Starting gmail-dl in separate process..."
source ./creds.sh
nohup gmail-dl ~/cam/data --days 2 --log ~/cam/gmail-dl.log --rm &
echo "Done!"