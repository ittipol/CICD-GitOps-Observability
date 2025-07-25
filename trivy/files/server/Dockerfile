# FROM debian:12
FROM debian:12.11-slim

USER root

RUN apt update

# Install necessary software or libraries within the Debian image
RUN apt install -y ca-certificates curl wget apt-transport-https gnupg lsb-release

# Add Docker's official GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc

# Add the Docker repository to APT sources
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index and install Docker Engine
RUN apt update
RUN apt install docker-ce docker-ce-cli containerd.io -y

RUN wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add -

RUN echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | tee -a /etc/apt/sources.list.d/trivy.list

RUN apt update
RUN apt install trivy

USER 1000

ENTRYPOINT ["tail"]
CMD ["-f", "/dev/null"]