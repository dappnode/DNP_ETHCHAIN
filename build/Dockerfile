# Build Parity in a stock alpine builder container
FROM alpine:edge as builder

WORKDIR /usr/src/app

ARG PARITY_VERSION=v2.2.6

RUN apk --no-cache add git rust cargo make openssl-dev eudev-dev linux-headers g++ cmake perl musl-dev
RUN git clone -b ${PARITY_VERSION} https://github.com/paritytech/parity-ethereum && cd parity-ethereum && \
    cargo build --release

# Pull Parity into a second stage deploy alpine container
FROM alpine:3.8

RUN apk --no-cache add libstdc++ eudev
COPY --from=builder /usr/src/app/parity-ethereum/target/release/parity /usr/local/bin

ENTRYPOINT parity --jsonrpc-port 8545 --jsonrpc-interface all --jsonrpc-hosts all --jsonrpc-cors all --ws-interface 0.0.0.0 --ws-port 8546 --ws-origins all --ws-hosts all --ws-max-connections 1000 --cache-size 3072 --warp-barrier 6500000 $EXTRA_OPTS




