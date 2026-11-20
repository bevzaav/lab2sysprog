import re
import sys

RAW_DIR = sys.argv[1] if len(sys.argv) > 1 else "results/energy"


def parse(name):
    dts, cpu, comb = [], [], []
    for line in open(f"{RAW_DIR}/{name}.raw", errors="ignore"):
        m = re.search(r"\(([\d.]+)ms elapsed\)", line)
        if m:
            dts.append(float(m.group(1)) / 1000)
        m = re.match(r"CPU Power: (\d+) mW", line)
        if m:
            cpu.append(int(m.group(1)))
        m = re.match(r"Combined Power.*: (\d+) mW", line)
        if m:
            comb.append(int(m.group(1)))
    k = min(len(dts), len(comb))
    return dts[:k], cpu[:k], comb[:k]


def timings():
    out = {}
    for line in open(f"{RAW_DIR}/timing.txt"):
        name, s, e = line.split()
        out[name] = float(e.split("=")[1]) - float(s.split("=")[1])
    return out


def energy_j(power_mw, dts):
    return sum(p * d for p, d in zip(power_mw, dts)) / 1000


t = timings()
d, cpu, comb = parse("idle")
idle_w = energy_j(comb, d) / sum(d)
print(f"idle: {idle_w * 1000:.0f} mW combined")
print("name        run_s  capture_J  net_J(run-idle)  net_avg_W")
for name in ("naive_O0", "naive_O3", "opt_O3"):
    d, cpu, comb = parse(name)
    total = energy_j(comb, d)
    net = total - idle_w * sum(d)
    print(f"{name:10} {t[name]:6.2f} {total:10.2f} {net:15.2f} {net / t[name]:10.2f}")
