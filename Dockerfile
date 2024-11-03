# Build the image:
#   docker build . -t solana-validator-docker
# Run a basic container:
#   docker run --rm -it --init solana-validator-docker:latest
# Run the solana-test-validator and expose port 8899:
#   docker run --rm -it --init -p 8899:8899 solana-validator-docker:latest solana-test-validator
#
# Based on Ubuntu 22.04 LTS (Jammy)
FROM ubuntu:jammy
# Set the workdir to $HOME
WORKDIR /root
# Minimal deps to fetch installer (curl) and run solana-test-validator (bzip2)
RUN apt -y update && apt -y install curl bzip2
# Fetch and run the installer
RUN sh -c "$(curl -sSfL https://release.solana.com/v1.17.13/install)"
# Add active release bin to our path
ENV PATH="/root/.local/share/solana/install/active_release/bin:${PATH}"
# Generate a default keypair in ~/.config/solana.id.json
RUN solana-keygen new --no-bip39-passphrase