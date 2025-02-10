#!/bin/bash

set -e
# Stop when unbound variables found, use ${var:-}
# Unbound variable: shell variables that have not been assigned a value
set -u
set -o pipefail

which docker-compose > /dev/null 2>&1 || { echo "docker-compose is not installed"; exit 1; }
which minikube > /dev/null 2>&1 || { echo "minikube is not installed"; exit 1; }

# arg0=$(basename "$0" .sh)

# Replace dot with empty string
# blnk=$(echo "$arg0" | sed 's/./ /g')

flag=''
script=${0##*/} # run.sh

# sets colors for output logs
# ANSI escape code
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37
BLUE='\033[34m'
RED='\033[31m'
YELLOW='\033[33m'
GREEN='\033[32m'
CLEAR='\033[0m'

# pre-configured log levels
INFO="(${BLUE}INFO${CLEAR})"
ERROR="(${RED}ERROR${CLEAR})"

PRINT='print_message "${GREEN:-}${FUNCNAME[0]} ${BLUE:-}$*"'

exec 3>&1

usage_info()
{
    echo "Usage: start|stop|delete [{-a} all] \\"
    echo "       [{-d|docker} docker] [{-m|minikube} minikube] \\"
    echo "       [-h|--help]"
    echo ""
    echo "{-a|all} all                  -- Use Docker and Minikube"
    echo "{-d|docker} docker            -- Use Docker"
    echo "{-m|minikube} minikube        -- Use Minikube"
    echo ""
}

print_info() {
  # -e here enables the interpretation of backslash escapes
  # -e use with color code ex. \033[32m
  # echo -e "print \ntest \nmessage"
  echo -e "$script:$INFO $1"
}

print_warning() {
    printf "%b\n" "${YELLOW:-}Warning: $1${CLEAR:-}" >&3
}

print_error() {
    printf "%b\n" "${RED:-}Error: $1${CLEAR:-}" >&2
}

print_message() {
    printf "%b\n" "${CLEAR:-}${script}: $1${CLEAR:-}" >&3
}

docker_start() {
  eval $PRINT

  docker-compose up -d --build
}

docker_stop() {
  eval $PRINT

  docker-compose stop
}

docker_delete() {
  eval $PRINT

  docker-compose down
}

minikube_start() {
  eval $PRINT 

  local cpu=$1
  local memory="$2"

  minikube start --cpus $cpu --memory $memory
  # minikube start --cpus 2 --memory 4g --driver=hyperkit
  minikube status
  minikube ip
}

minikube_stop() {
  eval $PRINT
  
  minikube stop
}

minikube_delete() {
  eval $PRINT
  
  minikube delete
  # minikube delete --all --purge
}

case "$1" in
  -?|--?|-h|--help|-[Hh]elp)
    usage_info
    exit 1
    ;;
  start)
      flag='start'
    ;;
  stop)
      flag='stop'
    ;;
  delete)
      flag='delete'
    ;;
  "")   
      usage_info
      exit 1
   ;;
  *) print_error "Invalid option" ; usage_info ; exit 1 ;;
esac

if [ "$flag" = "start" ]; then 
  case "$2" in
    -h | --help)
      usage_info
      exit 1
      ;;
    -a | all)
      docker_start
      minikube_start 2 '4g'
      exit 1
      ;; 
    -d | docker) 
      docker_start
      exit 1
      ;;
    -m | minikube)
      minikube_start 2 '4g'
      exit 1
      ;;
    *)
      print_error "Invalid option: $1"
      # shift
      exit 1
      ;;
  esac
fi

if [ "$flag" = "stop" ]; then 
  case "$2" in
    -h | --help)
      usage_info
      exit 1
      ;;
    -a | all)
      docker_stop
      minikube_stop
      exit 1
      ;; 
    -d | docker) 
      docker_stop
      exit 1
      ;;
    -m | minikube)
      minikube_stop
      exit 1
      ;;
    *)
      print_error "Invalid option: $1"
      # shift
      exit 1
      ;;
  esac
fi

if [ "$flag" = "delete" ]; then 
  case "$2" in
    -h | --help)
      usage_info
      exit 1
      ;;
    -a | all)
      docker_delete
      minikube_delete
      exit 1
      ;; 
    -d | docker) 
      docker_delete
      exit 1
      ;;
    -m | minikube)
      minikube_delete
      exit 1
      ;;
    *)
      print_error "Invalid option: $1"
      exit 1
      ;;
  esac
fi