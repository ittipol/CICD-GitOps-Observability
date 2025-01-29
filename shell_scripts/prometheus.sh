#!/bin/bash
set -e

install() {
    cd ../kubernetes/prometheus/terraform

    terraform init
    terraform apply
}

apply_cadvisor_pod_monitor() {
    cd ../kubernetes/prometheus

    kubectl apply -f cadvisor-pod-monitor.yaml
}

start_port_forward() {
  kubectl port-forward svc/prometheus-operated -n monitoring 9090:9090
}

case "$1" in
		install)
			install
			;;
    cadvisor) 
			apply_cadvisor_pod_monitor
      ;;
		-s) 
			start_port_forward
      ;;
    *)
			echo "Invalid option" >&2
			exit 1
			;;
esac