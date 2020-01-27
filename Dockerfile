FROM golang:alpine3.10 as build
COPY . /src
WORKDIR /src

RUN apk add make && \
    make build

FROM alpine:3.9.5
COPY --from=build /src/demo.bin /demo
ENV IP="0.0.0.0" PORT=8000
ENV DEMO_REDIS_ADDR=redis:6379
ENV DEMO_APP_ADDR="${IP}:${PORT}"

EXPOSE ${PORT}

CMD ./demo 




