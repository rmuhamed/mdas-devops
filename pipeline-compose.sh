#!/bin/bash
set -e

#cleanup
docker-compose rm -f || true

#build
docker-compose build
docker-compose up -d

# test
docker-compose run --rm mytest

#delivery
docker-compose push