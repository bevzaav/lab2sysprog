#!/bin/bash
set -e
cd "$(dirname "$0")/.."
mkdir -p bin
gcc -O0 -g -fno-omit-frame-pointer -o bin/matmul_naive_O0 matmul.c
gcc -O3 -g -fno-omit-frame-pointer -o bin/matmul_naive_O3 matmul.c
gcc -O3 -g -fno-omit-frame-pointer -DOPTIMIZED -o bin/matmul_opt_O3 matmul.c
ls -l bin
