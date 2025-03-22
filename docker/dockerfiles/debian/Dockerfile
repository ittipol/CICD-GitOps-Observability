FROM debian:12.10

USER root

RUN apt-get update && \ 
    apt-get install -y wget openssl python3 python3-pip

RUN useradd -u 10001 --user-group --create-home appuser

RUN mkdir -p /test
RUN chown -R appuser:appuser /test
RUN chmod -R 770 /test

WORKDIR /test

USER appuser

CMD ["tail", "-f", "/dev/null"]