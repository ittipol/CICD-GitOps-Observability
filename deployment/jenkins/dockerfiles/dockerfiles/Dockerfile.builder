FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env

USER root

WORKDIR /build

COPY ./shell_script/. .

ENV BUILDER_VERSION=1.0.0
ENV PRODUCT_NAME=

RUN chmod +x ./entrypoint.sh

WORKDIR /src

# docker run --entrypoint <new_entrypoint_command> <image_name> [arguments_for_new_entrypoint]
# e.g., docker run --entrypoint <entrypoint.sh> <image:tag> <arg1> <arg2> <arg3>
ENTRYPOINT ["./entrypoint.sh"]
# CMD ["arg1", "arg2"] # These are arguments to the ENTRYPOINT