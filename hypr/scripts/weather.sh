#!/bin/bash
# Colors (Hex)
BLUE="#89b4fa"
YELLOW="#f9e2af"
RED="#f38ba8"
TEXT="#cdd6f4"
SUBTEXT="#a6adc8"
OVERLAY="#6c7086"
CITY="Bangalore"

# Fetch JSON once
DATA=$(curl -sf --max-time 5 "https://wttr.in/${CITY}?format=j1" 2>/dev/null)

if [ -z "$DATA" ]; then
    echo "<span foreground='$RED'>offline</span>"
    exit 0
fi

# Parse with jq (install if missing: sudo dnf install jq)
TEMP=$(echo "$DATA" | jq -r '.current_condition[0].temp_C')
HUMIDITY=$(echo "$DATA" | jq -r '.current_condition[0].humidity')
CONDITION=$(echo "$DATA" | jq -r '.current_condition[0].weatherDesc[0].value')

# Validate — if jq returned null/empty, something is wrong
if [ "$TEMP" = "null" ] || [ -z "$TEMP" ]; then
    echo "<span foreground='$RED'>parse error</span>"
    exit 0
fi

# Temperature color logic
if [ "$TEMP" -ge 30 ] 2>/dev/null; then
    TEMP_COLOR="$RED"
elif [ "$TEMP" -ge 20 ] 2>/dev/null; then
    TEMP_COLOR="$YELLOW"
elif [ "$TEMP" -ge 10 ] 2>/dev/null; then
    TEMP_COLOR="$BLUE"
else
    TEMP_COLOR="$SUBTEXT"
fi

# Condition icon
CONDITION_LOWER=$(echo "$CONDITION" | tr '[:upper:]' '[:lower:]')
case "$CONDITION_LOWER" in
    *sunny*|*clear*)       ICON="☀"  ICON_COLOR="$YELLOW"  ;;
    *cloud*|*overcast*)    ICON="☁"  ICON_COLOR="$OVERLAY" ;;
    *fog*|*mist*|*haze*)   ICON="≋"  ICON_COLOR="$OVERLAY" ;;
    *rain*|*drizzle*)      ICON="⛆"  ICON_COLOR="$BLUE"    ;;
    *snow*|*sleet*)        ICON="☃"  ICON_COLOR="$TEXT"    ;;
    *thunder*)             ICON="🗲"  ICON_COLOR="$YELLOW"  ;;
    *)                     ICON=""  ICON_COLOR="$OVERLAY"  ;;
esac

echo "<span foreground='$SUBTEXT'>$CITY</span> <span foreground='$ICON_COLOR'>$ICON</span> <span foreground='$TEMP_COLOR'>${TEMP}°C</span> <span foreground='$SUBTEXT'>${HUMIDITY}%</span>"
