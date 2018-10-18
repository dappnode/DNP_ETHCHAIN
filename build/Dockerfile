FROM parity/parity:v2.1.3

USER root
RUN ln -s /home/parity/bin/parity /usr/local/bin/parity

ENTRYPOINT parity --jsonrpc-port 8545 --jsonrpc-interface all --jsonrpc-hosts all --jsonrpc-cors all --ws-interface 0.0.0.0 --ws-port 8546 --ws-origins all --ws-hosts all --ws-max-connections 1000 --cache-size 3072 --warp-barrier 6500000







