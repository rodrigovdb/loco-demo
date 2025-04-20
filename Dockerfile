# Use a Rust base image with Cargo installed
FROM rust:1.86-slim as builder

# Install the PostgreSQL client and development libraries
# pkg-config is needed for building some Rust crates
RUN apt-get update && apt-get install -y libpq-dev postgresql-client pkg-config

RUN cargo install loco 
RUN cargo install sea-orm-cli

ARG APP_HOME=/usr/src/app
# Set the working directory inside the container
WORKDIR $APP_HOME

# Now copy the source code
COPY . .

EXPOSE 5150

# Build the dependencies without the actual source code to cache dependencies separately
# RUN cargo build

# CMD ["rcat", "-h"]
