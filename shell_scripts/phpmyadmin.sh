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

start_port_forward() {
  kubectl port-forward svc/phpmyadmin-server -n phpmyadmin 3030:80
}

while test $# -gt 0
do
    case "$1" in
    -s) 
      start_port_forward
      exit 1 
      ;;
    *)
        log_error "Invalid option: $1"
        exit 1
        ;;
    esac
done