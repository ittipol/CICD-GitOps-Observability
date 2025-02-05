#!/bin/bash
set -e

go_application() {
    cd ../gitops/argocd

    kubectl apply -f go_application.yaml
}

mysql_application() {
    cd ../gitops/argocd

    kubectl apply -f mysql_application.yaml
}

case "$1" in
	go)
		go_application
	;;
    mysql)
		mysql_application
	;;
    *)
        echo "Invalid option" >&2
        exit 1
    ;;
esac