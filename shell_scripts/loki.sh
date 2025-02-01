#!/bin/bash
set -e

install() {
    # cd ../kubernetes/loki-stack/terraform
    cd ../kubernetes/loki/terraform

    terraform init
    terraform apply
}

destroy() {
    # cd ../kubernetes/loki-stack/terraform
    cd ../kubernetes/loki/terraform

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