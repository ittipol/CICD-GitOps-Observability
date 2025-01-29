#!/bin/bash
set -e

install() {
  cd ../kubernetes/influxdb

  kubectl apply -f ./manifests
}

start_port_forward() {
  kubectl port-forward svc/influxdb -n influxdb 8086:8086
}

case "$1" in
  install)
		install
	;;
  -s) 
    start_port_forward
  ;;
  *)
    echo "Invalid option" >&2
    exit 1
  ;;
esac