# Build Parity in a stock alpine builder container
FROM alpine:edge as builder

ARG PARITY_VERSION=v2.1.11

RUN apk --no-cache add \
    build-base \
    cargo \
    cmake \
    eudev-dev \
    linux-headers \
    perl \
    rust \ 
    git

RUN git clone -b ${PARITY_VERSION} https://github.com/paritytech/parity-ethereum && \ 
    cd parity-ethereum && \
    cargo build --release --features final --target x86_64-alpine-linux-musl --verbose && \
    strip target/x86_64-alpine-linux-musl/release/parity

# Pull Parity into a second stage deploy alpine container
FROM alpine:3.8

WORKDIR /home/parity

RUN apk --no-cache add \
    libstdc++ \ 
    eudev-libs \
    libgcc

RUN addgroup -g 1000 parity && \
    adduser -u 1000 -G parity -s /bin/sh -D parity

USER parity

RUN mkdir -p /home/parity/.local/share/io.parity.ethereum/

COPY --chown=parity:parity --from=builder /parity-ethereum/target/x86_64-alpine-linux-musl/release/parity /usr/local/bin

ENTRYPOINT parity --jsonrpc-port 8545 --jsonrpc-interface all --jsonrpc-hosts all --jsonrpc-cors all --ws-interface 0.0.0.0 --ws-port 8546 --ws-origins all --ws-hosts all --ws-max-connections 1000 --warp-barrier 7045000 $EXTRA_OPTS
