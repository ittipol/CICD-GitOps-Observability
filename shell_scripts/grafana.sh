#!/bin/bash
set -e

start_port_forward() {
  kubectl port-forward svc/prometheus-grafana -n monitoring 3000:80
}

apply_dashboard() {
	cd ../grafana/dashboard

	kubectl apply -f cadvisor-k6-dashboard.yaml
}

case "$1" in
	-s) 
		start_port_forward
    ;;
	dashboard) 
		apply_dashboard
    ;;
    *)
		echo "Invalid option" >&2
		exit 1
	;;
esac