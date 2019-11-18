#BUILDER
FROM golang:1.13.4-alpine3.10 as builder

#Git isn't part of this distribución, We have to download it first 
#Package manager from alpine is apk so We should run first this one to get this dependencys

RUN apk add --no-cache git

RUN go get github.com/gorilla/websocket && \  
    go get github.com/labstack/echo

COPY . .

RUN go build -o /build/votingapp && \
    cp -r ui ./build

#RUNTINE
FROM alpine:3.10

WORKDIR /app
COPY --from=builder /build .

ENTRYPOINT [ "./votingapp" ]