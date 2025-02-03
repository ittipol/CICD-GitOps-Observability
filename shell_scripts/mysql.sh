#!/bin/bash
set -e

install() {
    cd ../gitops/argocd

    kubectl apply -f mysql_application.yaml
}

start_port_forward() {
  kubectl port-forward svc/mysql -n mysql 3306:3306
}

case "$1" in
	install)
		install
	;;
    -s)
		start_port_forward
	;;
    *)
        echo "Invalid option" >&2
        exit 1
    ;;
esac