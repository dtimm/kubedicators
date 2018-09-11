FROM golang:1.11 AS build

RUN go get code.cloudfoundry.org/indicators/...
WORKDIR $GOPATH/src/code.cloudfoundry.org/indicators/

RUN GO111MODULE=on CGO_ENABLED=0 go build -mod=vendor -o /registry cmd/registry/main.go

FROM alpine

COPY --from=build /registry /bin/registry

EXPOSE 10567
CMD ["/bin/registry", "--port", "10567"]
