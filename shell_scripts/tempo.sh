#!/bin/bash
set -e

install() {
    cd ../kubernetes/tempo/terraform

    terraform init
    terraform apply
}

destroy() {
    cd ../kubernetes/tempo/terraform

    terraform destroy
}

start_port_forward() {
  kubectl port-forward svc/tempo -n tempo 4318:4318
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