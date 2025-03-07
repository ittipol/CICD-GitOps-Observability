FROM debian
USER root
RUN apt-get update && apt-get install -y wget gnupg lsb-release
RUN wget -O - https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
RUN apt update && apt install vault

# COPY ./config /etc/vault

RUN mkdir -p /opt/vault/data
RUN chown -R vault:vault /opt/vault/data
RUN chmod -R 770 /opt/vault/data

USER vault
ENTRYPOINT ["vault"]
CMD ["server", "-config", "/etc/vault/config.hcl"]