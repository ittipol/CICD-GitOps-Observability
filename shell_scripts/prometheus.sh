#!/bin/bash
set -e

install() {
	cd ../kubernetes/prometheus/terraform

    terraform init
    terraform apply
}

destroy() {
	cd ../kubernetes/prometheus/terraform

    terraform destroy
}

start_port_forward() {
	kubectl port-forward svc/prometheus-server -n prometheus 9090:80
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