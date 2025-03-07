#!/bin/bash
set -e

install() {
	cd ../kubernetes/vault/terraform

    terraform init
    terraform apply
}

destroy() {
	cd ../kubernetes/vault/terraform

    terraform destroy
}

start_port_forward() {
	kubectl port-forward svc/vault -n vault 8200:8200
}

start_ui() {
	kubectl port-forward svc/vault-ui -n vault 8400:8200
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
	ui) 
		start_ui
    ;;
    *)
		echo "Invalid option" >&2
		exit 1
	;;
esac