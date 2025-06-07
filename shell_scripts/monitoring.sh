#!/bin/bash
set -e

all() {
    cd ../kubernetes

    kubectl apply -f ./monitoring
}

apply_cadvisor_pod_monitor() {
    cd ../kubernetes/monitoring

    kubectl apply -f 0-proxy-monitoring-namespace.yaml
    kubectl apply -f 3-cadvisor-podmonitor.yaml
}

apply_node_exporter_podmonitor() {
    cd ../kubernetes/monitoring

    kubectl apply -f 0-proxy-monitoring-namespace.yaml
    kubectl apply -f 4-node-exporter-podmonitor.yaml
}

case "$1" in
    cadvisor) 
        apply_cadvisor_pod_monitor
    ;;
	node)
		apply_node_exporter_podmonitor
	;;
    *)
        echo "Invalid option" >&2
        exit 1
    ;;
esac