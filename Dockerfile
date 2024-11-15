FROM rust:1.82.0

RUN apt-get update && apt-get install -y musl-tools
RUN rustup target add x86_64-unknown-linux-musl

RUN git clone https://github.com/HardAndHeavy/terrashine /app
WORKDIR /app
RUN git checkout proxy

RUN cargo install sqlx-cli
RUN cargo fetch
RUN SQLX_OFFLINE=1 cargo build --release
RUN mv ./target/x86_64-unknown-linux-musl/release/terrashine /usr/bin/terrashine
ENV RUST_LOG=info
CMD ["terrashine", "server"]
