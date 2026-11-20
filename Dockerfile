FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc libc6-dev make time linux-perf git perl ca-certificates binutils \
    && rm -rf /var/lib/apt/lists/*
RUN git clone --depth 1 https://github.com/brendangregg/FlameGraph /opt/FlameGraph
WORKDIR /lab
