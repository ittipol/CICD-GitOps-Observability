#!/bin/bash
set -e

install() {
	cd ../kubernetes/redis-cluster

    # kubectl apply -f ./manifests
    kubectl apply -f ./7000/manifests
    kubectl apply -f ./7001/manifests
    kubectl apply -f ./7002/manifests
    kubectl apply -f ./7003/manifests
    kubectl apply -f ./7004/manifests
    kubectl apply -f ./7005/manifests
}

destroy() {	    
    cd ../kubernetes/redis-cluster

    # kubectl delete -f ./manifests
    kubectl delete -f ./7000/manifests
    kubectl delete -f ./7001/manifests
    kubectl delete -f ./7002/manifests
    kubectl delete -f ./7003/manifests
    kubectl delete -f ./7004/manifests
    kubectl delete -f ./7005/manifests
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