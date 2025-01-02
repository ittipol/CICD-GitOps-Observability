arg0=$(basename "$0" .sh)
blnk=$(echo "$arg0" | sed 's/./ /g')

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

# sets colors for output logs
BLUE='\033[34m'
RED='\033[31m'
CLEAR='\033[0m'

# pre-configured log levels
INFO="(${BLUE}INFO${CLEAR})"
ERROR="(${RED}ERROR${CLEAR})"

flag=''

log_info() {
  local message=$1
  echo -e "$script:$INFO $message"
}

log_error() {
  local message=$1
  echo -e "$script:$ERROR $message"
  # echo -e "$script:$ERROR $1" >&2 > err.log
  exit 1
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
  *) log_error "Invalid option" exit 1 ;;
esac

if [ "$flag" = "start" ]; then 
    while test $# -gt 0
    do
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
    done
fi

if [ "$flag" = "stop" ]; then 
    while test $# -gt 0
    do
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
    done
fi

if [ "$flag" = "delete" ]; then 
    while test $# -gt 0
    do
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
    done
fi