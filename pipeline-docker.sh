#!/bin/bash
set -e

# install deps
deps(){
    go get github.com/gorilla/websocket
    go get github.com/labstack/echo
}

# cleanup
cleanup(){
    # pkill votingapp || ps aux | grep votingapp | awk {'print $1'} | head -1 | xargs kill -9
    docker rm -f myvotingapp
    rm -rf build
}

# build 
build(){
    mkdir build
    go build -o ./build ./src/votingapp 
    cp -r ./src/votingapp/ui ./build

    # pushd build
    # ./votingapp 
    docker build -f src/votingapp/Dockerfile -t paulopez/votingapp .
    # docker run --name myvotingapp -v $(pwd)/build:/app -w /app -p 8080:80 -d ubuntu ./votingapp
    docker run --name myvotingapp -p 8080:80 -d paulopez/votingapp
    # popd
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
    curl --url  $votingurl \
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
docker push paulopez/votingapp