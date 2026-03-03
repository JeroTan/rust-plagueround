# Multi-stage Dockerfile for Rust projects
# Build argument to specify which project to build
ARG PROJECT_NAME=project1

# Stage 1: Build
FROM rust:latest as builder

ARG PROJECT_NAME
WORKDIR /usr/src

# Copy the specific project
COPY ${PROJECT_NAME}/Cargo.toml ${PROJECT_NAME}/Cargo.toml
COPY ${PROJECT_NAME}/Cargo.lock* ${PROJECT_NAME}/

# Create a dummy main.rs to cache dependencies
RUN mkdir -p ${PROJECT_NAME}/src && \
    echo "fn main() {}" > ${PROJECT_NAME}/src/main.rs && \
    cd ${PROJECT_NAME} && \
    cargo build --release && \
    rm -rf src

# Copy actual source code
COPY ${PROJECT_NAME}/src ${PROJECT_NAME}/src

# Build the actual project
RUN cd ${PROJECT_NAME} && \
    cargo build --release

# Stage 2: Runtime
FROM debian:bookworm-slim

ARG PROJECT_NAME
RUN apt-get update && \
    apt-get install -y ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Copy the built binary
COPY --from=builder /usr/src/${PROJECT_NAME}/target/release/${PROJECT_NAME} /usr/local/bin/app

CMD ["app"]
