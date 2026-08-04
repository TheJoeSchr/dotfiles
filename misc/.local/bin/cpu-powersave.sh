#!/usr/bin/env bash
# Gets the number of available processors on the system using nproc.

set -euo pipefail
PROCESSOR_COUNT="$(nproc-all)"
# max CPU is PROCESSOR_COUNT - 1 since CPU indexing starts at 0
CPU_MAX=$((PROCESSOR_COUNT - 1))
printf "CPU_MAX set automatically to %d\n" "$CPU_MAX"
CPU_MIN=$((PROCESSOR_COUNT / 2))
printf "CPU_MIN set automatically to %d\n" "$CPU_MIN"

# Make sure least 4 CPUs are online to avoid trying to offline CPU all

# The `:-` operator sets the value only if `CPU_MIN` is **unset or empty**.
CPU_MIN=${CPU_MIN-"1"}
CPU_MAX=${CPU_MAX-"4"}

printf "Disabling CPUs from %d to %d for powersave mode...\n" "$CPU_MIN" "$CPU_MAX"
for i in $(seq "$CPU_MIN" "$CPU_MAX"); do
  echo 0 | sudo tee "/sys/devices/system/cpu/cpu$i/online"
done

# use "cpupower warning" to quickly check if CPUs are offline
sudo cpupower monitor
