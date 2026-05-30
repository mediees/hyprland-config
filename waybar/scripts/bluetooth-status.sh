#!/bin/bash

BT_POWER=$(bluetoothctl show 2>/dev/null | grep "Powered:" | awk '{print $2}')

if [ "$BT_POWER" != "yes" ]; then
    echo '{"text":"󰂲","tooltip":"Bluetooth выключен","class":"disabled"}'
    exit 0
fi

CONNECTED=$(bluetoothctl devices Connected 2>/dev/null)

if [ -z "$CONNECTED" ]; then
    echo '{"text":"󰂯","tooltip":"Bluetooth включён\nНет подключений","class":"on"}'
    exit 0
fi

DEVICE_NAME=$(echo "$CONNECTED" | head -1 | cut -d' ' -f3-)
DEVICE_MAC=$(echo "$CONNECTED" | head -1 | awk '{print $2}')
BATTERY=$(bluetoothctl info "$DEVICE_MAC" 2>/dev/null | \
          grep "Battery Percentage" | grep -o '[0-9]*' | tail -1)

if [ -n "$BATTERY" ]; then
    TOOLTIP="$DEVICE_NAME\nБатарея: $BATTERY%"
    TEXT="󰂱 $DEVICE_NAME $BATTERY%"
else
    TOOLTIP="$DEVICE_NAME"
    TEXT="󰂱 $DEVICE_NAME"
fi

echo "{\"text\":\"$TEXT\",\"tooltip\":\"$TOOLTIP\",\"class\":\"connected\"}"
