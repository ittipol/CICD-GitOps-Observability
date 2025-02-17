#!/bin/bash
set -e

install() {
    cd ../kubernetes/opentelemetry-collector/terraform

    terraform init
    terraform apply
}

destroy() {
    cd ../kubernetes/opentelemetry-collector/terraform

    terraform destroy
}

start_port_forward() {

    local type="$1"

    case "$1" in
        metric)
            kubectl port-forward svc/opentelemetry-collector -n otelcol 8888:8888
        ;;
        # otlp)
        #     kubectl port-forward svc/opentelemetry-collector -n otelcol 4318:4318
        # ;;
        *)
            echo "Invalid option" >&2
            exit 1
        ;;
    esac  
}

case "$1" in
	install)
		install
	;;
    destroy)
		destroy
	;;
    -s) 
        if [ "$#" -eq 2 ]; then
            start_port_forward $2
        else 
            echo "Invalid option: $1" >&2
        fi		
    ;;
    *)
        echo "Invalid option" >&2
        exit 1
    ;;
esac