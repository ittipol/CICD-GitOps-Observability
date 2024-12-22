# Jenkins
- Pipeline syntax https://www.jenkins.io/doc/book/pipeline/syntax/
- variables http://localhost:8080/env-vars.html

## Password
``` bash
docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
# or
docker exec -it jenkins /bin/cat /var/jenkins_home/secrets/initialAdminPassword

# ------------------------------
# Shell into container
docker exec -it jenkins bash

cat /var/jenkins_home/secrets/initialAdminPassword
```

## Shell into container
``` bash
docker exec -it jenkins bash
```

## Plugin
- Pipeline: Stage View
- Docker Pipeline
- Workspace Cleanup

## Jenkins Snippet Generator
1. Click "Pipeline Syntax" in job page
2. Click "Snippet Generator"
3. Select an options (ex. git: Git, tool: Use a tool from a predefined Tool Installation)
4. Input an option data
5. Click "Generate Pipeline Script"

## Docker
- https://www.jenkins.io/doc/book/installing/docker/

```
Jenkins (Docker client) --[tcp://docker:2376]--> dind (Docker daemon) --[registry:5000]--> registry (Docker registry)
```

## Jenkins (Docker client)
### Connect Jenkins (Docker client) to Docker daemon
### Solution 1: Mount host machine /var/run/docker.sock in your container
``` yaml
volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```

### Solution 2: Use docker-in-docker (DinD) image
``` bash
# Pull image
docker pull docker:dind
docker pull jenkins/jenkins:latest

# Run
docker run --name docker-dind --privileged -d docker:dind
docker run --name jenkins --link=docker-dind -d jenkins/jenkins:latest

# Test list Docker images
docker exec jenkins docker -H docker-dind images
```

### Setup docker-in-docker (DinD) hostname and certificates
``` yaml
environment:
    DOCKER_HOST: "tcp://{docker_daemon_hostname}:{docker_daemon_port}"
    DOCKER_CERT_PATH: "/certs/client"
    DOCKER_TLS_VERIFY: 1
volumes:
    - jenkins-docker-certs:/certs/client:ro
```

## Docker daemon
### Verify register server certificates
1. Generate Self Signed SSL Certificate
2. Add ca.crt to path /etc/docker/certs.d/{docker_registry_hostname}:{docker_registry_port}/
    - ca.crt: Certificate Authority trust certificate

## Docker registry
### Set Self Signed SSL Certificate
1. Generate Self Signed SSL Certificate
2. Add {filename}.crt and {filename}.pem
    - {filename}.crt: Server certificate signed by the CA
    - {filename}.pem: Privacy Enhanced Mail (PEM) Conversion of server.key (private key) into a base64 encoding format
``` yaml
environment:
    REGISTRY_HTTP_TLS_CERTIFICATE: "/tls/server.crt"
    REGISTRY_HTTP_TLS_KEY: "/tls/server.pem"
```

### Create user and password for authentication
``` bash
# Use httpd:2 image for creating username and password
# Create username = test, password = dockerpassword
docker run --rm --entrypoint htpasswd httpd:2 -Bbn test dockerpassword >> {output_path}
```

## Use Docker Agent in Jenkins
### Download plugin
1. Go to "Manage Jenkins" > "Plugins"
2. Search "Docker Pipeline"
3. Install Docker Pipeline plugin

### Add Docker as tool
1. Go to "Manage Jenkins" > "Tools"
2. Click "Add Docker"
3. Input *name
4. Click "Install automatically" checkbox
5. Click "Add Installer"
6. Select "Download from docker.com"
7. Input Docker version
8. Click Save

## Using Docker with Pipeline
``` groovy
tools {
    dockerTool '{*name}'
}
```

## SSH Credentials
- Go to Jenkins > Credentials > System > Global credentials (unrestricted) > Add Credentials

## Go Plugin
### Download plugin
1. Go to "Manage Jenkins" > "Plugins"
2. Search "Go"
3. Install Go plugin

### Add Go as tool
1. Go to "Manage Jenkins" > "Tools"
2. Click "Add Go"
3. Input *name
4. Input Go version
8. Click Save

## Using Go with Pipeline
``` groovy
tools {
    go '{*name}'
}
```

## Docker daemon
``` bash
curl --unix-socket /var/run/docker.sock http://localhost/version
```

``` bash
docker tag <SOME IMAGE ID FROM DOCKER PS> <IP ADDRESS>:5000/test:tag1
docker push <IP ADDRESS>:5000/test:tag1
```