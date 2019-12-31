# Build Parity in a stock alpine builder container
FROM alpine:edge as builder

ARG PARITY_VERSION=v2.5.13

# show backtraces
ENV RUST_BACKTRACE 1

RUN apk --no-cache add \
    build-base \
    cargo \
    cmake \
    eudev-dev \
    linux-headers \
    perl \
    rust \ 
    git

RUN git clone -b ${PARITY_VERSION} https://github.com/paritytech/parity-ethereum /parity-ethereum
WORKDIR /parity-ethereum
RUN cargo build 
RUN cargo build --release --features final --target x86_64-alpine-linux-musl
RUN strip target/x86_64-alpine-linux-musl/release/parity

FROM ethereum/client-go:alltools-v1.9.9 as geth

# Pull Parity into a second stage deploy alpine container
FROM alpine:edge

RUN apk --no-cache add \
    libstdc++ \ 
    eudev-libs \
    libgcc \
    bash

RUN apk add -u musl

ADD entrypoint.sh /usr/local/bin/entrypoint.sh

COPY --from=geth /usr/local/bin/geth /usr/local/bin/geth
COPY --from=geth /usr/local/bin/bootnode /usr/local/bin/bootnode
COPY --from=builder /parity-ethereum/target/x86_64-alpine-linux-musl/release/parity /usr/local/bin

ENTRYPOINT ["entrypoint.sh"]
