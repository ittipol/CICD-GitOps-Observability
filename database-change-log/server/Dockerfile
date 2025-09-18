FROM openjdk:26-jdk-slim
# FROM openjdk:26-jdk-bookworm
# FROM openjdk:26-jdk

USER root

RUN apt update

# Install necessary software or libraries within the Debian image
RUN apt install -y ca-certificates curl wget apt-transport-https gnupg lsb-release

RUN wget -O- https://repo.liquibase.com/liquibase.asc | gpg --dearmor > liquibase-keyring.gpg
RUN cat liquibase-keyring.gpg | tee /usr/share/keyrings/liquibase-keyring.gpg > /dev/null
RUN echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/liquibase-keyring.gpg] https://repo.liquibase.com stable main' | tee /etc/apt/sources.list.d/liquibase.list

RUN apt update
RUN apt install liquibase

# To install a specific version, Replace x.y.z with the version to install
# RUN apt install liquibase=x.y.z

# ENV LIQUIBASE_COMMAND_CHANGELOG_FILE=/files/liquibase.changelog.yml

# USER 1000

WORKDIR /db

ENTRYPOINT ["tail"]
CMD ["-f", "/dev/null"]