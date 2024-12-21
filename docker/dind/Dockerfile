FROM docker:dind
# ENV DOCKER_TLS_CERTDIR=''
# ENTRYPOINT ["docker-entrypoint.sh"]
# ENTRYPOINT ["dockerd-entrypoint.sh"]
COPY ./tls/ca.crt /etc/docker/certs.d/registry:5000/ca.crt