# 1) Builder Stage
#    Use the official Rust image to compile your project
FROM rust:1.72 as builder

# Set the working directory inside the container
WORKDIR /app

# Copy your source code (and Cargo config) into the container
COPY . .

# Build your application in release mode
RUN cargo build --release

# 2) Runtime Stage
#    Use a small base image to keep the final image size minimal
FROM debian:bullseye-slim

# (Optional) Install any additional libraries or dependencies your binary needs
# RUN apt-get update && apt-get install -y \
#     ca-certificates \
#     && rm -rf /var/lib/apt/lists/*

# Create a non-root user (recommended for production)
# RUN useradd -m -s /bin/bash myuser
# USER myuser

# Copy the compiled binary from the builder stage
COPY --from=builder /app/target/release/your-binary-name /usr/local/bin/your-binary-name

# Set environment variables if needed
# ENV RUST_LOG=info

# Expose the port your application listens on (if needed)
# EXPOSE 8080

# Define the default command to run your application
CMD ["your-binary-name"]
