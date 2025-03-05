#!/bin/bash
set -e

install() {
    cd ../kubernetes/argocd/terraform

    terraform init
    terraform apply
}

password() {
  echo "$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)"  
}

start_port_forward() {
  local port="$1"

  if [ "$1" = "" ]; then
      port="8084"
  fi

  kubectl port-forward svc/argocd-server -n argocd $port:80
}

# while getopts 'ips:' flag; do
#   case "${flag}" in
#     i) install exit 1 ;;
#     p) password exit 1 ;;
#     s) 
#       start_port_forward "$OPTARG"
#       exit 1 
#       ;;
#     *) echo "Invalid option" exit 1 ;;
#   esac
# done

case "$1" in
	install)
		install
	;;
	destroy)
		destroy
	;;
	-s) 
    if [ "$#" -lt 3 ]; then
      start_port_forward "$2"
    else 
      echo "Invalid option" >&2 exit 1
    fi
  ;;
	password) 
		password
    ;;
  *)
		echo "Invalid option" >&2
		exit 1
	;;
esac