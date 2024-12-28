FROM docker:dind

# ENV DOCKER_TLS_CERTDIR=''
# ENTRYPOINT ["docker-entrypoint.sh"]
# ENTRYPOINT ["dockerd-entrypoint.sh"]

RUN mkdir -p /etc/docker/certs.d/registry:5000
RUN ln -s /docker_registry/cert/ca.crt /etc/docker/certs.d/registry:5000/ca.crt

RUN mkdir -p /etc/docker/certs.d/host.docker.internal:5050
RUN ln -s /docker_registry/kubernetes/cert/ca.crt /etc/docker/certs.d/host.docker.internal:5050/ca.crt