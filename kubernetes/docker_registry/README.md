# Docker Registry

## Add CA cert for Docker daemon in Minikube cluster
``` bash
minikube ssh

cd /etc/docker/

mkdir -p certs.d/host.minikube.internal:5000

cd /etc/docker/certs.d/host.minikube.internal:5000

touch ca.crt

# Copy key from /docker/nginx/certs/ca.crt and paste to /etc/docker/certs.d/host.minikube.internal:5000/ca.crt file
vi ca.crt

# Save and quit
# 1. Pressing Esc if you are in insert mode
# 2. Enter :wq command

# Quit without save
# 1. Pressing Esc if you are in insert mode
# 2. Enter :q! command
```

## Test connection
``` bash
minikube ssh

# To test connectivity to a specific TCP service listening on your host
nc -vz host.minikube.internal 5000

# Use the curl command
curl -kv https://host.minikube.internal:5000
```

## Verify certificate
``` bash
minikube ssh

openssl s_client -connect host.minikube.internal:5000 -showcerts </dev/null
```

## Pull an image from private registry (Minikube)
``` bash
# Login
docker login -u docker -p 1234 host.minikube.internal:5000

# docker image pull {repo}:{tag} 
docker image pull host.minikube.internal:5000/go-app:1.0.0
```

## Mirror the Docker Hub library
- edit /etc/docker/daemon.json and add the registry-mirrors key and value, to make the change persistent
``` json
{
    "registry-mirrors": ["https://host.minikube.internal:5000"]
}
```

``` bash
docker login -u docker -p 1234 host.minikube.internal:5000

# docker image pull without URL prefix
docker image pull go-app:1.0.0
```