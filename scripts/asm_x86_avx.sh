#!/bin/bash
set -e
cd "$(dirname "$0")/.."
mkdir -p results/asm
docker run --rm --platform linux/amd64 -v "$PWD":/lab -w /lab debian:bookworm-slim bash -c '
apt-get update -qq && apt-get install -y -qq gcc libc6-dev >/dev/null
gcc -O0 -S -fno-asynchronous-unwind-tables -o results/asm/naive_O0_x86.s matmul.c
gcc -O3 -S -fno-asynchronous-unwind-tables -o results/asm/naive_O3_x86_sse2.s matmul.c
gcc -O3 -mavx2 -mfma -S -fno-asynchronous-unwind-tables -DOPTIMIZED -o results/asm/opt_O3_x86_avx2.s matmul.c
'
