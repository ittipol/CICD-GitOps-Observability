#!/bin/bash
set -e

install() {
    # cd ../kubernetes/kube-prometheus-stack/terraform
	cd ../kubernetes/prometheus/terraform

    terraform init
    terraform apply
}

destroy() {
    # cd ../kubernetes/kube-prometheus-stack/terraform
	cd ../kubernetes/prometheus/terraform

    terraform destroy
}

start_port_forward() {
#   kubectl port-forward svc/prometheus-operated -n monitoring 9090:9090
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