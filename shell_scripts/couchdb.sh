#!/bin/bash
set -e

install() {
	cd ../kubernetes/couchdb/terraform

    terraform init
    terraform apply
}

destroy() {
	cd ../kubernetes/couchdb/terraform

    terraform destroy
}

credentials() {
    # echo $(kubectl get secret couchdb-couchdb -n couchdb -o go-template='{{ .data.adminUsername }}' | base64 --decode)
    # kubectl get secret couchdb-couchdb -n couchdb -o go-template='{{ .data.adminPassword }}' | base64 --decode
    # echo $(kubectl get secret couchdb-couchdb -n couchdb -o go-template='{{ .data.cookieAuthSecret }}' | base64 --decode)
    # echo $(kubectl get secret couchdb-couchdb -n couchdb -o go-template='{{ .data.erlangCookie }}' | base64 --decode)

    echo $(kubectl get secret couchdb-couchdb -n couchdb -o go-template='{{ .data.adminPassword }}' | base64 --decode)
}

start_port_forward() {
	kubectl port-forward svc/couchdb-svc-couchdb -n couchdb 5984:5984
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
    *)
		echo "Invalid option" >&2
		exit 1
	;;
esac