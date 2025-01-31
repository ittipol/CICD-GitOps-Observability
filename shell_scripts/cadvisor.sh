#!/bin/bash
set -e

NAMESPACE='cadvisor'

install() {
    # if no parameter is provided, use the default version
    local version="$1"
    if [ "$1" = "" ]; then
        version="v0.49.2"
    fi

    # Apply parameterized manifest files with -k
    kubectl apply -k https://github.com/google/cadvisor/deploy/kubernetes/base?ref="${version}"
}

apply_cadvisor_pod_monitor() {
    cd ../kubernetes/cadvisor

    kubectl apply -f cadvisor-pod-monitor.yaml
}

start_port_forward() {
		local pod=$(kubectl -n "${NAMESPACE}" get pod -l app=cadvisor -o jsonpath="{.items[0].metadata.name}")
		local port="$1"

    if [ "$1" = "" ]; then
        port="8083"
    fi
    
    kubectl -n "${NAMESPACE}" port-forward pod/"${pod}" ${port}:8080
}

get_pod_name() {
    echo $(kubectl -n "${NAMESPACE}" get pod -l app=cadvisor -o jsonpath="{.items[0].metadata.name}")
}

get_pod() {
    local pod=$(kubectl -n "${NAMESPACE}" get pod -l app=cadvisor -o jsonpath="{.items[0].metadata.name}")
    kubectl get pod "${pod}" -n "${NAMESPACE}" -o json
}

get_pod_describe() {
    local pod=$(kubectl -n "${NAMESPACE}" get pod -l app=cadvisor -o jsonpath="{.items[0].metadata.name}")
    kubectl describe pod "${pod}" -n "${NAMESPACE}"
}

case "$1" in
		install)
			if [ "$#" -lt 3 ]; then
					install "$2"
			else 
					echo "Invalid option" >&2 exit 1
			fi
			;;
    monitor) 
			apply_cadvisor_pod_monitor
      ;;
    -s) 
			if [ "$#" -lt 3 ]; then
					start_port_forward "$2"
			else 
					echo "Invalid option" >&2 exit 1
			fi
      ;;
    *)
			echo "Invalid option" >&2
			exit 1
			;;
esac