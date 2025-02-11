#!/bin/bash
set -e

install() {
    cd ../kubernetes/ingress-nginx/terraform

    terraform init
    terraform apply
}

destroy() {
    cd ../kubernetes/ingress-nginx/terraform

    terraform destroy
}

case "$1" in
	install)
		install
	;;
    destroy)
		destroy
	;;
    *)
        echo "Invalid option" >&2
        exit 1
    ;;
esac