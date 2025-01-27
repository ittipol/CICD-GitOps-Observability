#!/bin/bash
set -e

# sets colors for output logs
BLUE='\033[34m'
RED='\033[31m'
CLEAR='\033[0m'

# pre-configured log levels
INFO="(${BLUE}INFO${CLEAR})"
ERROR="(${RED}ERROR${CLEAR})"

log_info() {
  local message=$1
  echo -e "$script:$INFO $message"
}

log_error() {
  local message=$1
  echo -e "$script:$ERROR $message" >&2
  # echo -e "$script:$ERROR $1" >&2 > err.log
  exit 1
}

push() {
    local repo=$1
    local tag=$2
    local path=$3

    docker build -t $repo:$tag -f $path .
    docker tag $repo:$tag registry:5000/$repo:$tag
    docker login -u docker -p 1234 https://registry:5000
    docker push registry:5000/$repo:$tag
}

case "$1" in
    push)
        # ./docker.sh push ansible 1.0 ansible/Dockerfile
        if [ "$#" -eq 4 ]; then
            push $2 $3 $4
        else 
            log_error "Invalid option: $1"
        fi
    ;;
    *)
        log_error "Invalid option: $1"
        exit 1
    ;;
esac
