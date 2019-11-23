FROM alpine:3.10
#To run the test script, first, We have to download mandatory dependencies (i.e curl & jo)
RUN apk add --no-cache curl jq

COPY test.sh .
RUN chmod +x test.sh

ENTRYPOINT [ "sh", "./test.sh" ]