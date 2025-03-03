#!/bin/bash
set -e

install() {
    cd ../kubernetes/grafana/terraform

    terraform init
    terraform apply
}

destroy() {
    cd ../kubernetes/grafana/terraform

    terraform destroy
}

start_port_forward() {
  kubectl port-forward svc/grafana -n grafana 3000:80
}

apply_dashboard() {
	cd ../grafana/dashboard

	kubectl apply -f ./k8s
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
	dashboard) 
		apply_dashboard
    ;;
    *)
		echo "Invalid option" >&2
		exit 1
	;;
esac