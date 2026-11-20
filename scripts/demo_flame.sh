#!/bin/bash
set -e
cd "$(dirname "$0")/.."
perf record -F 999 -g -o /tmp/p.data ./bin/matmul_opt_O3 3
perf script -i /tmp/p.data | /opt/FlameGraph/stackcollapse-perf.pl | /opt/FlameGraph/flamegraph.pl > /tmp/opt.svg
perf report -i /tmp/p.data --no-children --stdio | head -20
