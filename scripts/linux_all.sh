#!/bin/bash
set -e
cd "$(dirname "$0")/.."
REPEAT=3
FG=/opt/FlameGraph
mkdir -p results/flamegraphs results/time results/perf_stat results/perf_report results/asm
./scripts/build.sh
for b in matmul_naive_O0 matmul_naive_O3 matmul_opt_O3; do
  echo "=== $b"
  /usr/bin/time --verbose ./bin/$b $REPEAT 2> results/time/$b.txt >/dev/null
  perf stat -d ./bin/$b $REPEAT 2> results/perf_stat/$b.txt >/dev/null
  perf record -F 999 -g -o /tmp/$b.data ./bin/$b $REPEAT >/dev/null 2>&1
  perf report -i /tmp/$b.data --no-children --stdio 2>/dev/null | head -60 > results/perf_report/$b.txt
  perf script -i /tmp/$b.data | $FG/stackcollapse-perf.pl > /tmp/$b.folded
  $FG/flamegraph.pl --title "$b" /tmp/$b.folded > results/flamegraphs/$b.svg
done
gcc -O0 -S -fno-asynchronous-unwind-tables -o results/asm/naive_O0_arm64.s matmul.c
gcc -O3 -S -fno-asynchronous-unwind-tables -o results/asm/naive_O3_arm64.s matmul.c
gcc -O3 -S -fno-asynchronous-unwind-tables -DOPTIMIZED -o results/asm/opt_O3_arm64.s matmul.c
echo done
