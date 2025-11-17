#!/bin/bash

######################################
# CPU usage
# %Cpu(s): 30.0 us, 60.0 sy,  0.0 ni, 10.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
# grab  -------------------------------^ (idle percentage) and substract from 100
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
cpu_usage=$(echo "100 - $cpu_idle" | bc)
echo "Cpu Usage: $cpu_usage %"
######################################
