# Build Parity in a stock alpine builder container
FROM alpine:edge as builder

ARG PARITY_VERSION=v2.2.9

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

RUN apk --no-cache add \
    libstdc++ \ 
    eudev-libs \
    libgcc

COPY --from=builder /parity-ethereum/target/x86_64-alpine-linux-musl/release/parity /usr/local/bin

ENTRYPOINT parity $EXTRA_OPTS
