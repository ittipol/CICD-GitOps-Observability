#!/bin/bash
set -e

install() {
	cd ../kubernetes/minio

    kubectl apply -f ./manifests
}

destroy() {	
    cd ../kubernetes/minio

    kubectl delete -f ./manifests
}

start_port_forward() {
  kubectl port-forward --namespace minio service/minio 9001:9001
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