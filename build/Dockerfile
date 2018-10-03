FROM parity/parity:v2.0.6

RUN ln -s /parity/parity /usr/local/bin/parity

ENTRYPOINT /parity/parity --jsonrpc-port 8545 --jsonrpc-interface all --jsonrpc-hosts all --jsonrpc-cors all --ws-interface 0.0.0.0 --ws-port 8546 --ws-origins all --ws-hosts all --cache-size 3072 --warp-barrier 6440000