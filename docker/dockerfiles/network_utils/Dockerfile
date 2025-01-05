FROM alpine:3.14

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
        bind-tools \
        curl \
        iproute2 \
        wget \
        && \
        : 
ENTRYPOINT [ "/bin/sh", "-c", "--" , "while true; do sleep 3600; done;" ]