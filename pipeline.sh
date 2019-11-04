#!/bin/bash
set -e

# install deps
deps(){
    go get github.com/gorilla/websocket
    go get github.com/labstack/echo
}

# cleanup
cleanup(){
    docker rm -f myvotingapp
    rm -rf build || true
}

# build
build(){
    mkdir build
    go build -o ./build ./src/votingapp
    cp -r ./src/votingapp/ui ./build

    docker build -f src/votingapp/Dockerfile -t rmuhamed/votingapp .
    docker run --name votingapp -p 8080:80 -d rmuhamed/votingapp
}

retry(){
    n=0
    interval=5
    retries=3
    $@ && return 0
    until [ $n -ge $retries ]
    do
        n=$[$n+1]
        echo "Retrying...$n of $retries, wait for $interval seconds"
        sleep $interval
        $@ && return 0
    done

    return 1
}

# test
test() {
    votingurl='http://localhost:8080/vote'
    curl --url  votingurl \
        --request POST \
        --data '{"topics":["dev", "ops"]}' \
        --header "Content-Type: application/json"

    curl --url $votingurl \
        --request PUT \
        --data '{"topic": "dev"}' \
        --header "Content-Type: application/json"

    winner=$(curl --url $votingurl \
        --request DELETE \
        --header "Content-Type: application/json" | jq -r '.winner')

    echo "Winner IS "$winner

    expectedWinner="dev"

    if [ "$expectedWinner" == "$winner" ]; then
        echo 'TEST PASSED'
        return 0
    else
        echo 'TEST FAILED'
        return 1
    fi
}

deps
cleanup || true
GOOS=linux build
retry test

#delivery
docker push rmuhamed/votingapp