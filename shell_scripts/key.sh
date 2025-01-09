str=

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

randomString(){
    chars='abcdefghijklmnopqrstuvwxyz0123456789'
    n=20

    # str=
    for ((i = 0; i < n; ++i)); do
        str+=${chars:RANDOM%${#chars}:1}
        # alternatively, str=$str${chars:RANDOM%${#chars}:1} also possible
    done

    # echo "$RANDOM"
    # echo "${#chars}"
    # echo "using modulo ${RANDOM}%${#chars}"
}

hmacsha256() {
    randomString
    echo -n "$str" | openssl dgst -sha256 -hmac secret_key
}

while test $# -gt 0
do
    case "$1" in
    hmacsha256)
        hmacsha256
        exit 1
        ;;
    *)
        log_error "Invalid option: $1"
        exit 1
        ;;
    esac
done