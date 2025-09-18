#!/bin/bash

path=$(pwd)

echo "CURRENT_PATH=$path"

docker image build -t dotnetsdk8-builder:8.0 -f ../dockerfiles/Dockerfile.builder ../context