FROM golang:1.23.0-bookworm AS build

WORKDIR /go-app

COPY go.mod go.sum ./
RUN go mod download

COPY . ./

RUN go build -o ./app

# =================================================
FROM gcr.io/distroless/base-debian12 AS production

WORKDIR /go-app

COPY --from=build /go-app/app ./
COPY --from=build /go-app/config.yaml ./

EXPOSE 5000

USER 1000

ENTRYPOINT ["./app"]