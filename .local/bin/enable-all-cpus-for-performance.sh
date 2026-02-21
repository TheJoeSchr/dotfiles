#!/usr/bin/env bash
# Gets the number of available processors on the system using nproc.

set -euo pipefail
PROCESSOR_COUNT="$(nproc-all)"
# max CPU is PROCESSOR_COUNT - 1 since CPU indexing starts at 0
CPU_MAX=$((PROCESSOR_COUNT - 1))

# start with CPU 1 since CPU 0 is usually online by default
printf "Enabling CPUs from %d to %d for performance mode...\n" "1" "$CPU_MAX"
for i in $(seq 1 "$CPU_MAX"); do
  echo 1 | sudo tee "/sys/devices/system/cpu/cpu$i/online"
done

# use "cpupower warning" to quickly check if CPUs are offline
sudo cpupower monitor
