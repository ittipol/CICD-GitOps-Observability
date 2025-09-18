#!/bin/bash

path=$(pwd)

echo "CURRENT_PATH=$path"

docker image build -t database-changelog:1.0 -f ../dockerfiles/Dockerfile.database-changelog ../context