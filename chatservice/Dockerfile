FROM golang:1.20.3-bullseye as build

# # Set environment variables
ENV PATH="/root/.cargo/bin:${PATH}"
ENV USER=root

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \ 
    && rustup default stable \ 
    && rustup target add x86_64-unknown-linux-gnu

WORKDIR /go/src
RUN ln -sf /bin/bash /bin/sh
COPY go.mod go.sum ./
RUN go mod download && go mod verify
COPY . .

# Build the Rust library
RUN cd tiktoken-cffi && \
    cargo build --release --target=x86_64-unknown-linux-gnu && \
    cp target/x86_64-unknown-linux-gnu/release/libtiktoken.a /go/src/tiktoken-cffi/target/release/libtiktoken.a


# Build the Go program
RUN cd /go/src && \
    GOOS=linux CGO_ENABLED=1 go build -o chatservice cmd/chatservice/main.go

# Build the final image
# Use an updated version of the base image
FROM golang:1.20.3

RUN curl -s https://packagecloud.io/install/repositories/golang-migrate/migrate/script.deb.sh | bash && \
    apt-get update && \
    apt-get install migrate

# Create a non-root user and set it as the default user
RUN useradd -m -s /bin/bash appuser
USER appuser

# Set the working directory
WORKDIR /app

# Copy files and directories from the build stage
COPY --from=build --chown=appuser:appuser /go/src/chatservice .
COPY --from=build --chown=appuser:appuser /go/src/tiktoken-cffi/libtiktoken.a libtiktoken/
COPY --from=build --chown=appuser:appuser /go/src/.env.example .env

# Run the application
CMD ["./chatservice"]