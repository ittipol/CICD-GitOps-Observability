#!/bin/bash
set -e

install() {
	cd ../kubernetes/redis/standalone

    kubectl apply -f ./manifests
}

destroy() {	    
    cd ../kubernetes/redis/standalone

    kubectl delete -f ./manifests
}

start_port_forward() {
	kubectl port-forward svc/redis-service -n redis 6379:6379
}

case "$1" in
	install)
		install
	;;
	destroy)
		destroy
	;;
	-s)
		start_port_forward
	;;
    *)
		echo "Invalid option" >&2
		exit 1
	;;
esac