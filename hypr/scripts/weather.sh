#!/bin/bash

# Catppuccin Mocha colors
BLUE="#89b4fa"
YELLOW="#f9e2af"
GREEN="#a6e3a1"
RED="#f38ba8"
TEXT="#cdd6f4"
SUBTEXT="#a6adc8"
OVERLAY="#6c7086"

CITY="Bangalore"

# Use wttr.in's simple format string — no JSON parsing needed
# %t = temperature, %h = humidity, %C = condition text, %c = condition icon
TEMP=$(curl -sf --max-time 5 "https://wttr.in/${CITY}?format=%t" 2>/dev/null | tr -d '+')
HUMIDITY=$(curl -sf --max-time 5 "https://wttr.in/${CITY}?format=%h" 2>/dev/null)
CONDITION=$(curl -sf --max-time 5 "https://wttr.in/${CITY}?format=%C" 2>/dev/null)

if [[ -z "$TEMP" ]]; then
  echo "<span foreground='${RED}'>󰊠 offline</span>"
  exit 0
fi

# Strip °C from temp to get raw number for color comparison
TEMP_NUM=$(echo "$TEMP" | tr -d '°C°F ')

# Condition icon + pacman/ghost based on condition text
CONDITION_LOWER=$(echo "$CONDITION" | tr '[:upper:]' '[:lower:]')
case "$CONDITION_LOWER" in
  *sunny*|*clear*)           ICON="☀︎"  ; FLAVOR="󰮯" ; FLAVOR_COLOR="$YELLOW" ;;
  *cloud*|*overcast*)        ICON="󰖐" ; FLAVOR="󰊠" ; FLAVOR_COLOR="$OVERLAY" ;;
  *fog*|*mist*|*haze*)       ICON="󰖑" ; FLAVOR="󰊠" ; FLAVOR_COLOR="$OVERLAY" ;;
  *rain*|*drizzle*|*shower*) ICON="󰖗" ; FLAVOR="󰊠" ; FLAVOR_COLOR="$BLUE"    ;;
  *snow*|*sleet*|*blizzard*) ICON="󰖘" ; FLAVOR="󰊠" ; FLAVOR_COLOR="$TEXT"    ;;
  *thunder*|*storm*)         ICON="󰖓" ; FLAVOR="󰊠" ; FLAVOR_COLOR="$YELLOW"  ;;
  *)                         ICON="󰖐" ; FLAVOR="󰊠" ; FLAVOR_COLOR="$OVERLAY" ;;
esac

# Temp color
if   [[ "$TEMP_NUM" -ge 30 ]] 2>/dev/null; then TEMP_COLOR="$RED"
elif [[ "$TEMP_NUM" -ge 20 ]] 2>/dev/null; then TEMP_COLOR="$YELLOW"
elif [[ "$TEMP_NUM" -ge 10 ]] 2>/dev/null; then TEMP_COLOR="$BLUE"
else                                             TEMP_COLOR="$SUBTEXT"
fi

echo "<span foreground='${SUBTEXT}'>${CITY} </span><span foreground='${FLAVOR_COLOR}'>${FLAVOR}</span> <span foreground='${TEXT}'>${ICON} </span><span foreground='${TEMP_COLOR}'>${TEMP}</span><span foreground='${OVERLAY}'>  </span><span foreground='${SUBTEXT}'>${HUMIDITY}</span>"
