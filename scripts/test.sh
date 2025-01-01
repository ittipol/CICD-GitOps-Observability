# docker-compose up -d --build

# if [ "$#" -eq 0 ]; then
#     echo "Usage: $0 <username> <age> <fullname>"
#     exit 1
# fi

# if [ $var -eq 12 ]; then 
#     echo "This is a numeric comparison if example"
# fi

# if [ "$var" = "12" ]; then
#     echo "This is a string if comparison example"
# fi

# if [[ "$var" = *12* ]]; then
#     echo "This is a string regular expression if comparison example"
# fi

# if [ "$1" = "docker" ]; then

#     if [ "$#" -eq 1 ]; then
#         echo "docker-compose up -d --build"
#         exit 1
#     fi
    
#     if [ "$2" = "start" ]; then
#         echo "docker-compose up -d --build"
#         exit 1
#     fi

#     if [ "$2" = "stop" ]; then
#         echo "docker-compose stop"
#         exit 1
#     fi
    
#     exit 1
# fi

# if [ "$1" = "minikube" ]; then

#     if [ "$#" -eq 1 ]; then
#         echo "minikube start"
#         exit 1
#     fi
    
#     if [ "$2" = "start" ]; then
#         echo "minikube start"
#         exit 1
#     fi

#     if [ "$2" = "stop" ]; then
#         minikube stop
#     fi

#     exit 1
# fi

arg0=$(basename "$0" .sh)
blnk=$(echo "$arg0" | sed 's/./ /g')

usage_info()
{
    echo "Usage: $arg0 [{-s|--source} source] [{-d|--destination} destination] \\"
    echo "       $blnk [{-c|--credentials} credentials] [{-b|--bandwidth} bandwidth] \\"
    echo "       $blnk [{-t|--timeout} timeout] [{-p|--port} port] \\"
    echo "       $blnk [-h|--help] [{-l|--compression-level} level]"
}

# echo "Usage: $arg0 | $1"
usage_info

# sets colors for output logs
BLUE='\033[34m'
RED='\033[31m'
CLEAR='\033[0m'

# pre-configured log levels
INFO="(${BLUE}INFO${CLEAR})"
ERROR="(${RED}ERROR${CLEAR})"

docker_flag=''
minikube_flag=''
files=''
verbose='false'

log_info() {
  echo -e "$script:$INFO $1"
}

log_error() {
  echo -e "$script:$ERROR $1" >&
  exit 1
}

docker_start() {
  echo "docker-compose up -d --build"
}

docker_stop() {
  echo "docker-compose up -d --build"
}

minikube_start() {
  echo "docker-compose up -d --build"
}

minikube_stop() {
  printf "docker-compose down"
}

while getopts 'd:m:f:v' flag; do
  case "${flag}" in
    d | --docker) docker_flag="${OPTARG}" ;;
    m | --minikube) minikube_flag="${OPTARG}" ;;
    f) files="${OPTARG}" ;;
    v) verbose='true' ;;
    *) log_error "Invalid option" 
        exit 1 ;;
  esac
done

case "${docker_flag}" in
  start)
    docker_start
    exit 1
    ;;
  stop)
    log_info "ABCD.."
    exit 1
    ;;
  *)
    log_error "Invalid -d option"
    ;;
esac

# if [ "$docker_flag" = "start" ]; then
#     log_info "ABCD.."
#     exit 1
# fi

# while getopts "r:" opt; do
#   case $opt in
#     r | --run)
#       echo "-r was triggered, Parameter: $OPTARG"
#       if [ "$OPTARG" = "docker" ]; then
#           echo "xxxx"
#       fi
#       exit 1
#       ;;
#     \?)
#       echo "Invalid option: -$OPTARG"
#       exit 1
#       ;;
#     :)
#       echo "Option -$OPTARG requires an argument."
#       if [ "$OPTARG" = "a" ]; then
#           echo "This is a string if comparison example"
#       fi
#       exit 1
#       ;;
#     *) print_usage
#        exit 1 ;;
      
#   esac
# done

# while getopts "d:m:" opt; do
#   case $opt in
#     d | --docker)
#       echo "docker-compose up -d --build"
#       # exit 1
#       ;;
#     m | --minikube)
#       # echo "minikube start"
#       sh minikube_start.sh
#       # minikube start
#       # minikube status
#       # minikube ip
#       # exit 1
#       ;;
    # \?)
    #   echo "Invalid option: -$OPTARG" >&2
    #   exit 1
    #   ;;
    # :)
    #   echo "Option -$OPTARG requires an argument." >&2
    #   if [ "$OPTARG" = "a" ]; then
    #       echo "This is a string if comparison example"
    #   fi
    #   exit 1
#       ;;
#   esac
# done