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

# In this case, you can "fake" a long running service by overriding the default command with a long running command that basically does nothing but wait for the container to stop. Two widely used commands for this are sleep infinity (or whatever period suiting your needs) and tail -f /dev/null
# CMD ["tail", "-f", "/dev/null"]

# ENTRYPOINT is the process that’s executed inside the container
# CMD is the default set of arguments that are supplied to the ENTRYPOINT process

# ENTRYPOINT should be the path to the process that will be executed inside the container
# CMD should be the default arguments to pass to that command (if any)

# ENTRYPOINT ["tail"]
# CMD ["-f", "/dev/null"]