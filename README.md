# Jenkins
- Pipeline syntax https://www.jenkins.io/doc/book/pipeline/syntax/
- variables http://localhost:8080/env-vars.html
- http://localhost:8080/job/{job_name}/pipeline-syntax/
- http://localhost:8080/job/{job_name}/directive-generator/
- http://localhost:8080/job/{job_name}/pipeline-syntax/globals

## Start Jenkins
- Jenkins http://localhost:8080
- SonarQube http://localhost:9000
``` bash
./run.sh start docker
```

## Start Minikube
``` bash
./run.sh start minikube
```

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

# Command will depend on shells available in your image
docker exec -it mycontainer [bash|sh|zsh|ash|...]
```
``` bash
kubectl exec -it [POD_NAME] -- bash
kubectl exec -it [POD_NAME] -- sh
```

## Plugin
- Pipeline: Stage View
- Docker Pipeline
- Workspace Cleanup
- OWASP Dependency-Check
- SonarQube Scanner

## Add Credentials
- Navigate to Manage Jenkins > Credentials > System > Global credentials (unrestricted) > Add Credentials

## Jenkins API Token
### Get API Token
1. Navigate to {user} > Security
2. Navigate to API Token section
3. Click Add new Token
4. Input Name
5. Click Generate
6. Copy Token

### Add Jenkins API Token
1. Navigate to Manage Jenkins > Credentials > System > Global credentials (unrestricted) > Add Credentials
2. Select "Secret text"
3. Input Secret (Jenkins API Token)
4. Input ID
5. Input Description
6. Click Create

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

### Test connection and validate TLS
``` bash
# Use the curl command
curl https://registry:5000 -kv
```

### Create username and password for authentication
``` bash
# Use httpd:2 image for creating username and password
docker pull httpd:2

# Create username = test, password = dockerpassword
# docker run --rm --entrypoint htpasswd httpd:2 -Bbn test dockerpassword > ./htpasswd
docker run --rm --entrypoint htpasswd httpd:2 -Bbn test dockerpassword > {output_path}
```

### Add Docker registry credential
1. Navigate to Manage Jenkins Credentials > System > Global credentials (unrestricted) > Add Credentials
2. Select "Username with password"
3. Input Username
4. Input Password
5. Input Description
6. Click Create

## Docker plugin
### Download plugin
1. Navigate to "Manage Jenkins" > "Plugins"
2. Search "Docker Pipeline"
3. Install Docker Pipeline plugin

### Add Docker tool
1. Navigate to "Manage Jenkins" > "Tools"
2. Click "Add Docker"
3. Input *name
4. Click "Install automatically" checkbox
5. Click "Add Installer"
6. Select "Download from docker.com"
7. Input Docker version
8. Click Save

### Using Docker in pipeline
``` groovy
tools {
    dockerTool '{*name}'
}
```

## Go Plugin
### Download plugin
1. Navigate to "Manage Jenkins" > "Plugins"
2. Search "Go"
3. Install Go plugin

### Add Navigate tool
1. Navigate to "Manage Jenkins" > "Tools"
2. Click "Add Go"
3. Input *name
4. Input Go version
8. Click Save

### Using Go in pipeline
``` groovy
tools {
    go '{*name}'
}
```

## SonarQube plugin
### Download plugin
1. Navigate to "Manage Jenkins" > "Plugins"
2. Search "SonarQube Scanner"
3. Install SonarQube Scanner plugin

### Generate SonarQube Token
1. Navigate to Administration > Security > Users
2. In column Tokens, click "Update Token"
3. Input Token Name
4. Click Generate
5. Copy token

### Add Server authentication token
1. Navigate to Manage Jenkins Credentials > System > Global credentials (unrestricted) > Add Credentials
2. Select "Secret text"
3. Input Secret (SonarQube token) from [Generate SonarQube Token]
4. Input Description
5. Click Create

### Add SonarQube servers
1. Navigate to "Manage Jenkins" > "System"
2. Click "Add SonarQube"
3. Input *name
4. Input Server URL (http://sonarqube:9000)
5. Input Server authentication token from [Add Server authentication token]

### Add SonarQube tool
1. Navigate to "Manage Jenkins" > "Tools"
2. Click "Add SonarQube Scanner"
3. Input **name
4. Click "Install automatically"
5. Click "Add Installer"
6. Click "Install from Maven Central"
7. Select Version (ex. SonarQube Scanner 4.8.0.2856)
8. Click Save

### Using SonarQube in pipeline
``` groovy
environment { 
    SCANNER_HOME = tool '{**name}'
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
1. Navigate to "Manage Jenkins" > "Plugins"
2. Search "OWASP Dependency-Check"
3. Install OWASP Dependency-Check plugin

### Add OWASP Dependency-Check tool
1. Navigate to "Manage Jenkins" > "Tools"
2. Click "Add Dependency-Check"
3. Input *name
4. Click "Install automatically"
5. Click "Add Installer"
6. Click "Install from github.com"
7. Select Version (ex. 8.0.1)
8. Click Save

### Using OWASP Dependency-Check in pipeline
- https://www.jenkins.io/doc/pipeline/steps/dependency-check-jenkins-plugin
- additionalArguments
    - **--project**	The name of the Jenkins job
    - **--scan**	The build workspace
    - **--format**	The output format to write to (HTML, XML, CSV, JSON, JUNIT, SARIF, JENKINS, GITLAB, ALL). Multiple formats can be specified by specifying the parameter multiple times. The default is HTML
    - **--out**     The folder to write reports to. This defaults to the current directory. If the format is not set to ALL one could specify a specific file name
    - **--prettyPrint** When specified the JSON and XML report formats will be pretty printed.
``` groovy
dependencyCheck additionalArguments: ''' 
            -o './'
            -s './'
            -f 'XML' 
            --prettyPrint''', odcInstallation: '{*name}'

dependencyCheckPublisher pattern: 'dependency-check-report.xml'
```

## SonarQube
- https://docs.sonarsource.com/sonarqube-server/latest/analyzing-source-code/analysis-parameters/

### Username & Password
- Username: admin
- Password: admin

### Language-specific properties
- Navigate to Administration > Configuration > General Settings > Languages > Go

## Quality Gate
### Configure SonarQube webhook for quality gate
- Set webhooks at the project level in
    - {projectName} > Project Settings > Webhooks > Create
- Set webhooks at the global level in
    - Administration > Configuration > Webhooks > Create

### Webhook secret
- Secret will be used as the key to generate the HMAC hex (lowercase) digest value in the 'X-Sonar-Webhook-HMAC-SHA256' header
### Create webhook secret
1. Generate HMAC with SHA-256
``` bash
echo -n "message" | openssl dgst -sha256 -hmac secret_key
```
2. Copy hashed message (*secret)

### Create webhook (SonarQube)
1. Navigate to {projectName} > Project Settings > Webhooks > Create
2. Input name
3. Input URL (ex. http://jenkins:8080/sonarqube-webhook/)
4. Input *secret
5. Click Create

### Add webhook secret credential (Jenkins)
1. Navigate to Manage Jenkins Credentials > System > Global credentials (unrestricted) > Add Credentials
2. Select "Secret text"
3. Input *secret
4. Input Description
5. Click Create

### Add webhook secret credential to SonarQube servers (Jenkins)
1. Navigate to "Manage Jenkins" > "System"
2. Navigate to SonarQube servers section
3. Click Advanced
4. Webhook Secret dropdown list
5. Select webhook secret credential
5. Click save

### Using Quality gate in pipeline
``` groovy
environment { 
    WEBHOOK_SECRET_ID= "6641b7ca-2507-4f23-bfce-f5fc86136b2f"
}

stage("Quality Gate") {
    steps {
        timeout(time: 1, unit: 'HOURS') {
            // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
            // true = set pipeline to UNSTABLE, false = don't
            waitForQualityGate abortPipeline: true, webhookSecretId: env.WEBHOOK_SECRET_ID
        }
    }
}
```

### Create Quality Gate
1. Click menu "Quality Gates"
2. Click Create
3. Input Name
4. Click Save

### Select Quality Gate will be used with project
1. Navigate to {projectName} > Project Settings > Quality Gate
2. Select "Always use a specific Quality Gate"
3. Select Quality Gate name
4. Click save

## Quality Profile
### Create Quality Profile
1. Click menu "Quality Profiles"
2. Click Create
3. Select "What type of profile do you want to create?" option
    - Option 1: Extend an existing quality profile
        1. Select Language
        2. Select Profile to extend
        3. Input Name
    - Option 2: Copy an existing quality profile
        1. Select Language
        2. Profile to copy
        3. Input Name
    - Option 3: Create a blank quality profile
        1. Select Language
        2. Input Name
6. Click Create

### Add a language to project
1. Navigate to {projectName} > Project Settings > Quality Profile
2. Click "Add language"
3. Choose a language
4. Choose a profile
5. Click save

### Select Quality Profile will be used with project
1. Navigate to {projectName} > Project Settings > Quality Profile
2. Click "Change profile"
3. Select "Always use a specific Quality Profile" option
4. Select quality profile name
5. Click save

## Rule
### View rules
1. Click menu "Rules"
2. Select a language

## Docker daemon
``` bash
curl --unix-socket /var/run/docker.sock http://localhost/version
```

## Push image
``` bash
docker tag [SOME IMAGE ID FROM DOCKER PS] [IP ADDRESS]:[PORT]/[IMAGE]:[TAG]
docker push [IP ADDRESS]:[PORT]/[IMAGE]:[TAG]
```