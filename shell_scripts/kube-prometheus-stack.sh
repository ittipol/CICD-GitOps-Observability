#!/bin/bash
set -e

install() {
    cd ../kubernetes/kube-prometheus-stack/terraform

    terraform init
    terraform apply
}

destroy() {
    cd ../kubernetes/kube-prometheus-stack/terraform

    terraform destroy
}

start_prometheus_port_forward() {
  kubectl port-forward svc/prometheus-operated -n monitoring 9090:9090
}

start_grafana_port_forward() {
  kubectl port-forward svc/prometheus-grafana -n monitoring 3000:80
}

case "$1" in
	install)
		install
	;;
	destroy)
		destroy
	;;
	prometheus) 
		start_prometheus_port_forward
    ;;
	grafana) 
		start_grafana_port_forward
    ;;
    *)
		echo "Invalid option" >&2
		exit 1
	;;
esac