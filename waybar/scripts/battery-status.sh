#!/bin/bash

BAT_PATH=$(ls /sys/class/power_supply/ | grep -i "BAT" | head -1)

if [ -z "$BAT_PATH" ]; then
    echo '{"text":"󰁹","tooltip":"Нет батареи","class":"ac"}'
    exit 0
fi

CAPACITY=$(cat /sys/class/power_supply/$BAT_PATH/capacity 2>/dev/null)
STATUS=$(cat /sys/class/power_supply/$BAT_PATH/status 2>/dev/null)

# Режим питания
if command -v powerprofilesctl &>/dev/null; then
    PROFILE=$(powerprofilesctl get 2>/dev/null)
else
    PROFILE=$(cat /sys/firmware/acpi/platform_profile 2>/dev/null || echo "balanced")
fi

case "$PROFILE" in
    "performance") PROFILE_ICON="󰓅" ;;
    "balanced")    PROFILE_ICON="󰾅" ;;
    "power-saver") PROFILE_ICON="󰾆" ;;
    *)             PROFILE_ICON="󰾅" ;;
esac

# Иконка батареи
if [ "$STATUS" = "Charging" ]; then
    ICON="󰂄"
    CLASS="charging"
elif [ "$CAPACITY" -ge 90 ]; then
    ICON="󰁹"; CLASS="good"
elif [ "$CAPACITY" -ge 70 ]; then
    ICON="󰂂"; CLASS="good"
elif [ "$CAPACITY" -ge 50 ]; then
    ICON="󰂀"; CLASS="good"
elif [ "$CAPACITY" -ge 30 ]; then
    ICON="󰁾"; CLASS="warning"
elif [ "$CAPACITY" -ge 15 ]; then
    ICON="󰁻"; CLASS="critical"
else
    ICON="󰁺"; CLASS="critical"
fi

TOOLTIP="Заряд: $CAPACITY%\\nСтатус: $STATUS\\nРежим: $PROFILE $PROFILE_ICON"

echo "{\"text\":\"$ICON $CAPACITY% $PROFILE_ICON\",\"tooltip\":\"$TOOLTIP\",\"class\":\"$CLASS\"}"
