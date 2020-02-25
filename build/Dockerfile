# Build Parity in a stock alpine builder container
FROM alpine:edge as builder

ARG OPENETHEREUM_VERSION=v2.7.2

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
    git \ 
    clang-dev \
    llvm-dev

RUN git clone -b ${OPENETHEREUM_VERSION} https://github.com/OpenEthereum/open-ethereum /open-ethereum
WORKDIR /open-ethereum
ENV C=clang CXX=clang++

RUN cargo build --release --features final --target x86_64-alpine-linux-musl
RUN strip target/x86_64-alpine-linux-musl/release/parity

FROM ethereum/client-go:alltools-v1.9.11 as geth

# Pull Parity into a second stage deploy alpine container
FROM alpine:edge

RUN apk --no-cache add \
    libstdc++ \ 
    eudev-libs \
    libgcc \
    bash \
    musl \
    tini

ADD entrypoint.sh /usr/local/bin/entrypoint.sh

COPY --from=geth /usr/local/bin/geth /usr/local/bin/geth
COPY --from=geth /usr/local/bin/bootnode /usr/local/bin/bootnode
COPY --from=builder /open-ethereum/target/x86_64-alpine-linux-musl/release/parity /usr/local/bin

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["entrypoint.sh"]
