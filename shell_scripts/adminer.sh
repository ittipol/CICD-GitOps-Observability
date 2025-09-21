#!/bin/bash
set -e

install() {
	cd ../kubernetes/adminer

    kubectl apply -f ./manifests
}

destroy() {	    
    cd ../kubernetes/adminer

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