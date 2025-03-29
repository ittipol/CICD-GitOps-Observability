#!/bin/bash
set -e

install() {
	cd ../kubernetes/jaeger/terraform

    terraform init
    terraform apply
}

destroy() {
	cd ../kubernetes/jaeger/terraform

    terraform destroy
}

start_port_forward() {
    kubectl port-forward service/jaeger -n jaeger 16686:16686
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