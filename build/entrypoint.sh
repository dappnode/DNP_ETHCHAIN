#!/bin/bash

set -e

# If there is no nodekey we generate a new one and we copy to parity and geth directories
if [ ! -f /root/identity/nodekey ]; then

    if [ ! -f /root/.local/share/io.parity.ethereum/network/key ]; then
        # Generate a new identity
        bootnode -genkey=/root/identity/nodekey
    else
        # Migrate the old key
        cp /root/.local/share/io.parity.ethereum/network/key /root/identity/nodekey
        rm /root/.local/share/io.parity.ethereum/network/key
    fi

    # Create needed dirs
    mkdir -p /root/.local/share/io.parity.ethereum/network
    mkdir -p /root/.ethereum/geth

    # Create a symbolic link to the key for parity and geth clients
    ln -s /root/identity/nodekey /root/.ethereum/geth/nodekey
    ln -s /root/identity/nodekey /root/.local/share/io.parity.ethereum/network/key
fi

if [ "${DEFAULT_CLIENT^^}" = "GETH" ]; then
    geth --nousb --rpc --rpcaddr 0.0.0.0 --rpccorsdomain "*" --rpcvhosts "*" --ws --wsorigins "*" --wsaddr 0.0.0.0 ${EXTRA_OPTS_GETH}
else
    parity --jsonrpc-port 8545 --jsonrpc-interface all --jsonrpc-hosts all --jsonrpc-cors all --ws-interface 0.0.0.0 --ws-port 8546 --ws-origins all --ws-hosts all --ws-max-connections 1000 ${EXTRA_OPTS_PARITY}
fi 