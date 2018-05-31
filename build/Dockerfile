FROM parity/parity:v1.11.1

RUN ln -s /parity/parity /usr/local/bin

ENTRYPOINT /parity/parity --jsonrpc-port 8545 --jsonrpc-interface all --jsonrpc-hosts all --jsonrpc-cors '*' --ws-interface 0.0.0.0 --ws-port 8546 --ws-origins '*' --ws-hosts all --cache-size 1024 --ui-interface "0.0.0.0" --ui-hosts all --ui-no-validation 