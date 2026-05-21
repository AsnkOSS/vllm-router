FROM docker.io/rust:latest AS builder
WORKDIR /app
COPY . .
RUN cargo build --release

FROM docker.io/debian:buster-slim
WORKDIR /app
COPY --from=builder /app/target/release/vllm-router ./
EXPOSE 8000
CMD ["./vllm-router"]
