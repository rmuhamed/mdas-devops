FROM alpine:3.10
#Cambiar por el gestor de alpine
RUN apk add --no-cache curl jq

COPY test.sh .
RUN chmod +x test.sh

ENTRYPOINT [ "./test.sh" ]