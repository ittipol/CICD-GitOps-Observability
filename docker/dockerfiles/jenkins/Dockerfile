# ARG BUILD_VERSION=2.494-jdk17
ARG BUILD_VERSION=2.528-jdk21

FROM jenkins/jenkins:${BUILD_VERSION}

USER root

RUN apt-get update && apt-get install -y wget apt-transport-https gnupg lsb-release libicu72 iputils-ping

# docker
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli

# trivy
# RUN wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add -
# RUN echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | tee -a /etc/apt/sources.list.d/trivy.list
# RUN apt-get update && apt-get install trivy

# vault
# RUN wget -O - https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
# RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
# RUN apt update && apt install vault

# dotnet
# RUN mkdir -p /dotnet/sdk
# RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
# RUN chmod +x ./dotnet-install.sh
# RUN ./dotnet-install.sh --version 8.0.204 --install-dir /dotnet/sdk
# ENV DOTNET_ROOT="/dotnet/sdk"
# ENV PATH="/dotnet/sdk:${PATH}"

# liquibase
RUN wget -O- https://repo.liquibase.com/liquibase.asc | gpg --dearmor > liquibase-keyring.gpg
RUN cat liquibase-keyring.gpg | tee /usr/share/keyrings/liquibase-keyring.gpg > /dev/null
RUN echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/liquibase-keyring.gpg] https://repo.liquibase.com stable main' | tee /etc/apt/sources.list.d/liquibase.list

RUN apt update
RUN apt install liquibase

USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow pipeline-stage-view dependency-check-jenkins-plugin ws-cleanup sonar kubernetes-cli"

# RUN jenkins-plugin-cli --plugins "blueocean docker-workflow pipeline-stage-view dependency-check-jenkins-plugin ws-cleanup sonar coverage junit kubernetes-cli"