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
    -s)
		start_port_forward
	;;
    destroy)
		destroy
	;;
    *)
        echo "Invalid option" >&2
        exit 1
    ;;
esac