#!/bin/bash

WIFI_DEVICE=$(nmcli -t -f DEVICE,TYPE device | grep ":wifi" | cut -d: -f1)
WIFI_STATUS=$(nmcli radio wifi)
CONNECTION=$(nmcli -t -f NAME connection show --active 2>/dev/null | head -1)
SIGNAL=$(nmcli -t -f IN-USE,SIGNAL device wifi list 2>/dev/null | grep "^\*" | cut -d: -f2)

if [ "$WIFI_STATUS" = "disabled" ]; then
    echo '{"text":"󰤭","tooltip":"WiFi выключен","class":"disabled"}'
    exit 0
fi

if [ -z "$CONNECTION" ]; then
    echo '{"text":"󰤯","tooltip":"Нет подключения","class":"disconnected"}'
    exit 0
fi

# Иконка по уровню сигнала
if   [ "${SIGNAL:-0}" -ge 80 ]; then ICON="󰤨"
elif [ "${SIGNAL:-0}" -ge 60 ]; then ICON="󰤥"
elif [ "${SIGNAL:-0}" -ge 40 ]; then ICON="󰤢"
elif [ "${SIGNAL:-0}" -ge 20 ]; then ICON="󰤟"
else                                  ICON="󰤯"
fi

IP=$(nmcli -t -f IP4.ADDRESS connection show "$CONNECTION" 2>/dev/null | head -1 | cut -d: -f2)

echo "{\"text\":\"$ICON $CONNECTION\",\"tooltip\":\"Сеть: $CONNECTION\\nIP: $IP\\nСигнал: ${SIGNAL}%\",\"class\":\"connected\"}"
