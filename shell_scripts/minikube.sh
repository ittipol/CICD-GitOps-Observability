#!/bin/bash
set -e

# Add TLS cert to k8s cluster (minikube)
add_cert() {
    
    ssh -i ~/.minikube/machines/minikube/id_rsa docker@$(minikube ip) "sudo mkdir -p /etc/docker/certs.d/host.minikube.internal:5000 && sudo chmod 777 /etc/docker/certs.d/host.minikube.internal:5000"

    # First, you need to copy the file to a place where you have write access without sudo
    scp -i ~/.minikube/machines/minikube/id_rsa ../docker/nginx/certs/ca.crt docker@$(minikube ip):~/ca.crt

    # Then move the file using sudo
    ssh -i ~/.minikube/machines/minikube/id_rsa docker@$(minikube ip) "sudo mv ~/ca.crt /etc/docker/certs.d/host.minikube.internal:5000 && sudo chmod 644 /etc/docker/certs.d/host.minikube.internal:5000/ca.crt"
}

case "$1" in
	cert)
		add_cert
	;;
esac