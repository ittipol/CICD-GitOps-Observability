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

start_port_forward() {
  kubectl port-forward svc/go-app-server -n go-app 3000:80
}

test_connection() {
    curl -v http://localhost:3000/health
}

generate_post_data_create_user() {
    local email="$1"
    local password="$2"
    local name="$3"

    cat <<EOF
{
    "email": "$email",
    "password": "$password",
    "name": "$name"
}
EOF
}

create_user() {
    local email="$1"
    local password="$2"
    local name="$3"

#     curl "http://localhost:3000/register" \
#     -H "Accept: application/json" \
#     -H "Content-Type:application/json" \
#     --data @<(cat <<EOF
# {
#     "email": "$email",
#     "password": "$password",
#     "name": "$name"
# }
# EOF
#     )

    curl -v "http://localhost:3000/register" \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --data "$(generate_post_data_create_user $email $password $name)"
}

generate_post_data_login() {
    local email="$1"
    local password="$2"

    cat <<EOF
{
    "email": "$email",
    "password": "$password"
}
EOF
}

login() {
    local email="$1"
    local password="$2"

    curl -v "http://localhost:3000/login" \
    -H "Accept: application/json" \
    -H "Content-Type:application/json" \
    --data "$(generate_post_data_login $email $password)"
}

case "$1" in
    -s) 
      start_port_forward
      exit 1 
      ;;
    status) 
      test_connection
      exit 1 
      ;;
    create)
        if [ "$#" -eq 4 ]; then
            create_user $2 $3 $4
        else 
            log_error "Invalid option: $1"
        fi
        exit 1
        ;;
    login)
        if [ "$#" -eq 3 ]; then
            login $2 $3
        else 
            log_error "Invalid option: $1"
        fi
        exit 1
        ;;
    *)
        log_error "Invalid option: $1"
        exit 1
        ;;
    esac