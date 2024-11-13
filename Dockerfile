FROM golang:latest

WORKDIR /app

COPY . .

RUN go mod init gitlab.com/opstree/ot-go-webapp

RUN go mod tidy

RUN go build -o ot-go-webapp

FROM alpine:latest

WORKDIR /app

RUN apk add --no-cache libc6-compat bash

COPY --from=0 /app/ot-go-webapp /app/

ENTRYPOINT ["./ot-go-webapp"]
