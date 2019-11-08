#!/bin/bash

docker-compose rm -f && \
docker-compose build && \
docker-compose up -d && \
docker-compose run --rm mytest && \
docker-compose push
echo "GREEN" || echo "RED"