FROM golang:1.9.2 AS builder
WORKDIR /go-http-hello-world/
RUN go get -d -v golang.org/x/net/html
COPY app.go    ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM scratch
#RUN apk --no-cache add ca-certificates
#WORKDIR /root/
COPY --from=builder /go-http-hello-world/app ./
CMD ["./app"]
