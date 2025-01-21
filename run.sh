#!/bin/bash
# set -ex
set -e
# arg0=$(basename "$0" .sh)
# blnk=$(echo "$arg0" | sed 's/./ /g')

# sets colors for output logs
BLUE='\033[34m'
RED='\033[31m'
CLEAR='\033[0m'

# pre-configured log levels
INFO="(${BLUE}INFO${CLEAR})"
ERROR="(${RED}ERROR${CLEAR})"

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

find_home() {
  local script=$0
  [ -h "$script" ] && script="$(readlink "$script")"
  echo "$(cd -P "$(dirname "$script")" && pwd)"
}

log_info() {
  local message=$1
  echo -e "$script:$INFO $message"
}

log_error() {
  local message=$1
  echo -e "$script:$ERROR $message" >&2

  # >&2
  # > redirect standard output
  # & what comes next is a file descriptor, not a file (only for right hand side of >)
  # 2 stderr file descriptor number
  # Redirect stdout from echo command to stderr. (If you were to useecho "hey" >2 you would output hey to a file called 2)
  # File descriptor 1 is stdout and File descriptor 2 is stderr

  # echo -e "$script:$ERROR $1" >&2 > err.log
}

docker_start() {
  docker-compose up -d --build
}

docker_stop() {
  docker-compose stop
}

docker_delete() {
  docker-compose down
}

minikube_start() {
  minikube start --cpus 2 --memory 4000
  minikube status
  minikube ip
}

minikube_stop() {
  minikube stop
}

minikube_delete() {
  minikube delete
}

flag=''
script=${0##*/}
home=$(find_home)

case "$1" in
  -h | --help)
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
  *) log_error "Invalid option" ; usage_info ; exit 1 ;;
esac

if [ "$flag" = "start" ]; then 
  case "$2" in
    -h | --help)
      usage_info
      exit 1
      ;;
    -a | all)
      docker_start
      minikube_start
      exit 1
      ;; 
    -d | docker) 
      docker_start
      exit 1
      ;;
    -m | minikube)
      minikube_start
      exit 1
      ;;
    *)
      log_error "Invalid option: $1"
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
      log_error "Invalid option: $1"
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
      log_error "Invalid option: $1"
      # shift
      exit 1
      ;;
  esac
fi