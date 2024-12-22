# Jenkins
- Pipeline syntax https://www.jenkins.io/doc/book/pipeline/syntax/
- variables http://localhost:8080/env-vars.html
- http://localhost:8080/job/{job_name}/pipeline-syntax/
- http://localhost:8080/job/{job_name}/directive-generator/
- http://localhost:8080/job/{job_name}/pipeline-syntax/globals

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
- OWASP Dependency-Check
- SonarQube Scanner

## Add Credentials
- Go to Jenkins > Credentials > System > Global credentials (unrestricted) > Add Credentials

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

### Add Docker tool
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

## Go Plugin
### Download plugin
1. Go to "Manage Jenkins" > "Plugins"
2. Search "Go"
3. Install Go plugin

### Add Go tool
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

## SonarQube
### Download plugin
1. Go to "Manage Jenkins" > "Plugins"
2. Search "SonarQube Scanner"
3. Install SonarQube Scanner plugin

### Generate SonarQube Token
1. Go to Administration > Security > Users
2. In column Tokens, click "Update Token"
3. Input Token Name
4. Click Generate
5. Copy token

### Add Server authentication token
1. Go to Manage Jenkins Credentials > System > Global credentials (unrestricted) > Add Credentials
2. Select "Secret text"
3. Input Secret (SonarQube token) from [Generate SonarQube Token]
4. Input Description
5. Click Create

### Add SonarQube servers
1. Go to "Manage Jenkins" > "System"
2. Click "Add SonarQube"
3. Input *name
4. Input Server URL (http://sonarqube:9000)
5. Input Server authentication token from [Add Server authentication token]

### Add SonarQube tool
1. Go to "Manage Jenkins" > "Tools"
2. Click "Add SonarQube Scanner"
3. Input **name
4. Click "Install automatically"
5. Click "Add Installer"
6. Click "Install from Maven Central"
7. Select Version (ex. SonarQube Scanner 4.8.0.2856)
8. Click Save

## Using SonarQube with Pipeline
``` groovy
environment { 
    SCANNER_HOME = tool '{**name}';
}

stage('Sonarqube scan') {      
    steps {
        withSonarQubeEnv('{*name}') {
            sh '''
            $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=Go-App \
            -Dsonar.java.binary=. \
            -Dsonar.projectKey=Go-App
            '''
        }
    }
}
```


## OWASP Dependency-Check plugin
### Download plugin
1. Go to "Manage Jenkins" > "Plugins"
2. Search "OWASP Dependency-Check"
3. Install OWASP Dependency-Check plugin

### Add OWASP Dependency-Check tool
1. Go to "Manage Jenkins" > "Tools"
2. Click "Add Dependency-Check"
3. Input *name
4. Click "Install automatically"
5. Click "Add Installer"
6. Click "Install from github.com"
7. Select Version (ex. 8.0.1)
8. Click Save

## Using OWASP Dependency-Check with Pipeline
``` groovy
dependencyCheck additionalArguments: ''' 
            -o './'
            -s './'
            -f 'ALL' 
            --prettyPrint''', odcInstallation: '{*name}'

dependencyCheckPublisher pattern: 'dependency-check-report.xml'
```

## Docker daemon
``` bash
curl --unix-socket /var/run/docker.sock http://localhost/version
```

``` bash
docker tag <SOME IMAGE ID FROM DOCKER PS> <IP ADDRESS>:5000/test:tag1
docker push <IP ADDRESS>:5000/test:tag1
```