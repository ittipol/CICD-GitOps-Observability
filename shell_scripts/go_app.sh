#!/bin/bash
set -e

apply_service_monitor() {
    cd ../kubernetes/app/go_app/manifests

    kubectl apply -f service-monitor.yaml
}

case "$1" in
    monitor) 
        apply_service_monitor
    ;;
    *)
        echo "Invalid option" >&2
        exit 1
	;;
esac