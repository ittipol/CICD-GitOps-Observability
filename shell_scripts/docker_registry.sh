#!/bin/bash
set -e

# sets colors for output logs
BLUE='\033[34m'
RED='\033[31m'
CLEAR='\033[0m'

# pre-configured log levels
INFO="(${BLUE}INFO${CLEAR})"
ERROR="(${RED}ERROR${CLEAR})"

base="docker exec -it jenkins"
docker_registry_username="docker"
docker_registry_password="1234"

run_command() {    
    local command=$1
    $base $command
}

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

list_images() {
    run_command "docker images"
}

get_repo() {
    run_command "curl -u $docker_registry_username:$docker_registry_password --cacert /docker_registry/cert/server.crt -X GET https://registry:5000/v2/_catalog?n=100"
}

get_tags() {
    local repo=$1
   run_command "curl -u $docker_registry_username:$docker_registry_password --cacert /docker_registry/cert/server.crt -X GET https://registry:5000/v2/$repo/tags/list" 
}

get_digest() {
    local repo=$1
    local tag=$2
    run_command "curl -u $docker_registry_username:$docker_registry_password --cacert /docker_registry/cert/server.crt -X GET https://registry:5000/v2/$repo/manifests/$tag"
}

create_htpasswd() {
    local username=$1
    local password=$2
    local output_path=$3
    docker run --rm --entrypoint htpasswd httpd:2 -Bbn $username $password > $output_path
}

while test $# -gt 0
do
    case "$1" in
    ls)
        list_images
        exit 1
        ;;
    repo)
        get_repo
        exit 1
        ;;
    tags)
        if [ "$#" -eq 2 ]; then
            get_tags $2
        else 
            log_error "Invalid option: $1"
        fi        
        exit 1
        ;;
    digest)        
        if [ "$#" -eq 3 ]; then
            get_digest $2 $3
        else 
            log_error "Invalid option: $1"
        fi
        exit 1
        ;;
    --create-htpasswd)
        if [ "$#" -eq 4 ]; then
            create_htpasswd $2 $3 $4
        else 
            log_error "Invalid option: $1"
        fi
        exit 1
        ;;
    *)
        log_error "Invalid option: $1"
        # shift
        exit 1
        ;;
    esac
done