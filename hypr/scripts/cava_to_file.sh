#!/bin/bash
RAMFILE="/dev/shm/cava_output.txt"
cava -p ~/.config/cava/service.conf | while read -r line; do
    echo "$line" > "$RAMFILE"
done
