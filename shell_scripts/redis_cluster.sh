#!/bin/bash
set -e

install() {
	cd ../kubernetes/redis/cluster

    kubectl apply -f ./manifests
}

destroy() {	    
    cd ../kubernetes/redis/cluster

    kubectl delete -f ./manifests
}

case "$1" in
	install)
		install
	;;
	destroy)
		destroy
	;;
    *)
		echo "Invalid option" >&2
		exit 1
	;;
esac