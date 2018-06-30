FROM golang:1.10.2 AS build

RUN go get golang.org/x/vgo
RUN go get code.cloudfoundry.org/cf-indicators/...
WORKDIR $GOPATH/src/code.cloudfoundry.org/cf-indicators/

RUN CGO_ENABLED=0 vgo build -o /registry code.cloudfoundry.org/cf-indicators/cmd/registry

FROM alpine

COPY --from=build /registry /bin/registry

EXPOSE 10567
CMD ["/bin/registry", "--port", "10567"]
