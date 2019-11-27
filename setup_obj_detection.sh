#!/usr/bin/env bash

set -e

sudo apt update && sudo apt install -y libsm6 libxext6 libxrender1

mkdir -p ~/img_input
mkdir -p ~/result
mkdir -p ~/render

git clone https://github.com/emkor/recogn-img.git
cd recogn-img && make config dl_model && make all && cd ~
