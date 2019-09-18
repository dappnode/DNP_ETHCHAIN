#!/bin/bash

set -x

LIGHT_PID=$(ps -ef | grep "syncmode light" | grep -v "grep" | awk '{print $1}')

curl -s -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_syncing","params":[],"id":1}'  http://localhost:8645 | grep 'false'
RESULT=$?

if [ "$RESULT" = 0 ];then
    # Avoid false positives
    sleep 30;
    curl -s -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_syncing","params":[],"id":1}'  http://localhost:8645 | grep 'false' 
    if [ $RESULT = 1 ];then
        # If it's a false positive we should exit
        exit 0;
    elif [ ! -z "$LIGHT_PID" ]; then
        kill $LIGHT_PID
    fi
    cp /etc/nginx/nginx.conf.full /etc/nginx/nginx.conf
    nginx -s reload
    pkill crond
elif [ -z "$LIGHT_PID" ]; then        
     geth --syncmode light --datadir /root/.ethereum/geth-light --port 31313 --nousb --rpc --rpcaddr 0.0.0.0 --rpcport 8745 --rpccorsdomain "*" --rpcvhosts "*" --ws --wsorigins "*" --wsaddr 0.0.0.0 --wsport 8746 &
else
    #Only start to use the light client in case it's a great block number
    LIGTH_BLOCKNUMBER=$(curl -s -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' localhost:8745 | jq '.result' | tr -d '"')
    FULL_BLOCKNUMBER=$(curl -s -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' localhost:8645 | jq '.result' | tr -d '"')
    if [[ $LIGTH_BLOCKNUMBER -gt $FULL_BLOCKNUMBER ]];then
        cp /etc/nginx/nginx.conf.light /etc/nginx/nginx.conf
        nginx -s reload
    fi
fi

