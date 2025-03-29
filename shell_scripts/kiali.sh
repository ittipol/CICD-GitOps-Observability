#!/bin/bash
set -e

install() {
	cd ../kubernetes/kiali/terraform

    terraform init
    terraform apply
}

destroy() {
	cd ../kubernetes/kiali/terraform

    terraform destroy
}

start_port_forward() {
    kubectl port-forward service/kiali -n istio-system 20001:20001
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