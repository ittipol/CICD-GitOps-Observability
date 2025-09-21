#!/bin/bash
set -e

install() {
	cd ../kubernetes/postgresql

    kubectl apply -f ./manifests
}

destroy() {	
    # kubectl delete all --all -n postgresql

    cd ../kubernetes/postgresql

    kubectl delete -f ./manifests
}

start_port_forward() {
	kubectl port-forward svc/postgresql -n postgresql 5432:5432
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