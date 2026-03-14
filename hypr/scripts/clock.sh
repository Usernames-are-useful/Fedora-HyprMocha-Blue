#!/usr/bin/env bash

# Catppuccin Mocha Blue
ACCENT="#89b4fa"

# Get Time
HH=$(date +%H)
MM=$(date +%M)

# Output as a single colored block
echo -n "<span foreground='${ACCENT}'>$HH:$MM</span>"
