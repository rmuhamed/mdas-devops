FROM alpine
#Cambiar por el gestor de alpine
RUN apt-get update && apt-get install -y \ 
    curl \
    jq \
    && rm -rf /var/lib/apt/lists/*

COPY test.sh .
RUN chmod +x test.sh

ENTRYPOINT [ "./test.sh" ]