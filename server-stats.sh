#!/bin/bash

# add safe bash settings
set -euo pipefail
IFS=$'\n\t'

######################################
# CPU usage
# %Cpu(s): 30.0 us, 60.0 sy,  0.0 ni, 10.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
# grab  -------------------------------^ (idle percentage) and substract from 100
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
cpu_usage=$(echo "100 - $cpu_idle" | bc)
echo "Cpu Usage: $cpu_usage%"

######################################
# Total memory usage
# Grab total, used and free memory values
memory_total=$(free -m | grep Mem: | awk '{print $2}')  
mem_used=$(free -m | grep Mem: | awk '{print $3}')
mem_free=$(free -m | grep Mem: | awk '{print $4}')
# Calculate memory usage and free percentages
mem_usage_percent=$(echo "100 * $mem_used / $memory_total" | bc)
mem_free_percent=$(echo "100 * $mem_free / $memory_total" | bc)
# Output memory usage
echo "Memory Used: $mem_used MB($mem_usage_percent%)"
echo "Memory Free: $mem_free MB($mem_free_percent%)"

######################################
# Total disk usage
# Grab total, used, available and percent used
disk_size=$(df | awk 'NR==3 {print $1}')
disk_used=$(df | awk 'NR==3 {print $2}')
disk_avbl=$(df | awk 'NR==3 {print $3}')
disk_used_percent=$(df | awk 'NR==3 {print $4}' | tr -d '%')
# Calculate disk free percentage
disk_free_percent=$(echo "100 - $disk_used_percent" | bc)
# Output disk usage
echo "Disk Size: $disk_size"
echo "Disk Used: $disk_used B"
echo "Disk Available: $disk_avbl B"
echo "Disk Used Percentage: $disk_used_percent%"
echo "Disk Free Percentage: $disk_free_percent%"

######################################
# Top 5 processes by CPU usage
# grab 6 rows, as 1st is a header
echo "Top 5 processes by CPU usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

######################################
# Top 5 processes by Memory usage
# grab 6 rows, as 1st is a header
echo "Top 5 processes by Memory usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
