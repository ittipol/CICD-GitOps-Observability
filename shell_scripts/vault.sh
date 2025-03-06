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

# start_port_forward() {
# 	kubectl port-forward pod/vault-0 -n vault 8200:8200
# }

case "$1" in
	install)
		install
	;;
	destroy)
		destroy
	;;
	# -s) 
	# 	start_port_forward
    # ;;
    *)
		echo "Invalid option" >&2
		exit 1
	;;
esac