FROM jenkins/jenkins:latest
USER root
RUN mkdir /var/log/jenkins
RUN mkdir /var/cache/jenkins
# RUN chown -R jenkins:jenkins /var/log/jenkins
# RUN chown -R jenkins:jenkins /var/cache/jenkins
RUN apt-get update && apt-get install -y docker.io
# USER jenkins
ENV JAVA_OPTS="-Xmx8192m"