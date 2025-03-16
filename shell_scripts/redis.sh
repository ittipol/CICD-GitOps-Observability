#!/bin/bash
set -e

install() {
	cd ../kubernetes/redis

    kubectl apply -f ./manifests
}

destroy() {	    
    cd ../kubernetes/redis

    kubectl delete -f ./manifests
}

# start_port_forward() {
  
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