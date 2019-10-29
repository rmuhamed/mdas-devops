#!/bin/bash
set -e 
# install deps
go get github.com/labstack/echo
go get github.com/gorilla/websocket

# cleanup
rm -rf build || true
pkill votingapp

# build
mkdir build

go build -o ./build ./src/votingapp
cp -r ./src/votingapp/ui ./build

pushd build 
./votingapp &
popd

# test
curl --url http://localhost:2000/vote \
    --request POST \
    --data '{"topics":["dev", "ops"]}' \
    --header "Content-Type: application/json"

curl --url http://localhost:2000/vote \
    --request PUT \
    --data '{"topic": "dev"}' \
    --header "Content-Type: application/json"

winner=$(curl --url http://localhost:2000/vote \
    --request DELETE \
    --header "Content-Type: application/json" | ./jq -r '.winner') 

echo "Winner IS " $winner

expectedWinner = "dev"

if [ "$expectedWinner" == "$winner"]; then
    echo 'TEST PASSED'
    exit 0
else 
    echo 'TEST FAILED'
    exit 1
fi