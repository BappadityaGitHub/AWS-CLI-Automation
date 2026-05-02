#!/bin/bash

# 1. Capture and Clean the Data
# Use -P for POSIX format to prevent long names from breaking the line
DISK=$(df -hP / | awk 'NR==2 {print $5}' | tr -d '%')

# 2. Threshold Logic
if [ "$DISK" -gt 90 ]; then
    echo "CRITICAL: $DISK%"
elif [ "$DISK" -gt 80 ]; then
    echo "WARNING: $DISK%"
elif [ "$DISK" -gt 70 ]; then
    echo "NOTICE: $DISK%"
else
    echo "OK: $DISK%"
fi

