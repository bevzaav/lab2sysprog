#!/bin/bash
set -e
cd "$(dirname "$0")/.."
mkdir -p bin results/energy
clang -O0 -o bin/mac_naive_O0 matmul.c
clang -O3 -o bin/mac_naive_O3 matmul.c
clang -O3 -DOPTIMIZED -o bin/mac_opt_O3 matmul.c
REPEAT=${REPEAT:-3}
measure() {
  name=$1; shift
  sudo powermetrics --samplers cpu_power -i 200 > results/energy/$name.raw &
  PM=$!
  sleep 1
  s=$(date +%s.%N 2>/dev/null || python3 -c 'import time;print(time.time())')
  "$@" >/dev/null
  e=$(date +%s.%N 2>/dev/null || python3 -c 'import time;print(time.time())')
  sleep 1
  sudo kill $PM
  wait $PM 2>/dev/null || true
  echo "$name start=$s end=$e" >> results/energy/timing.txt
}
rm -f results/energy/timing.txt
sudo -v
measure idle sleep 10
measure naive_O0 ./bin/mac_naive_O0 $REPEAT
measure naive_O3 ./bin/mac_naive_O3 $REPEAT
measure opt_O3 ./bin/mac_opt_O3 $REPEAT
python3 scripts/energy_report.py
