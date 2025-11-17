#!/bin/bash

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
