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

openssl s_client -connect host.minikube.internal:5000 -servername host.minikube.internal -showcerts </dev/null

openssl s_client -showcerts -connect host.minikube.internal:5000 -servername host.minikube.internal </dev/null |  sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > certificate.pem
```

## View a certificate fingerprint as SHA-256, SHA-1 or MD5
``` bash
# SHA-256
openssl x509 -noout -fingerprint -sha256 -inform pem -in [path/to/certificate-file.crt]

# SHA-1
openssl x509 -noout -fingerprint -sha1 -inform pem -in [path/to/certificate-file.crt]

# MD5
openssl x509 -noout -fingerprint -md5 -inform pem -in [path/to/certificate-file.crt]

# openssl x509 -noout -fingerprint -sha256 -inform pem -in server.crt
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