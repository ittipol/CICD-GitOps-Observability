#!/bin/bash
set -e

start_port_forward() {
  kubectl port-forward svc/prometheus-grafana -n monitoring 3000:80
}

case "$1" in
		-s) 
			start_port_forward
      ;;
    *)
			echo "Invalid option" >&2
			exit 1
			;;
esac