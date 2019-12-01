#!/usr/bin/env bash

set -e

docker pull emkor/recogn-img:x86-cpu-aio

mkdir -p ~/dl_img
mkdir -p ~/result
mkdir -p ~/render