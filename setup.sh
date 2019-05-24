#!/usr/bin/env bash

set -e


mkdir -p ~/cam/log && mkdir -p ~/cam/data && mkdir -p ~/cam/upload && cd ~/cam

git clone https://github.com/emkor/gmail-img-dl.git && cd ~/cam/gmail-img-dl
sudo pip install -e .
gmail-dl --help
