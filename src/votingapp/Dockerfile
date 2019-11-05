#BUILDER
FROM alpine as builder

#Cambiar por el gestor de alpine
#Git no es parte de la distribución, hay que bajarlo

RUN go get github.com/gorilla/websocket && \  
    go get github.com/labstack/echo

COPY . .

RUN go build -o /build/votingapp && \
    cp -r ui ./build

#RUNTINE
FROM alpine

WORKDIR /app
COPY --from=builder /build .

ENTRYPOINT [ "./votingapp" ]