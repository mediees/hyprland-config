#!/bin/bash
# nmtui в красивой обёртке

ACTION=$1

show_menu() {
    # Получаем текущее подключение
    CURRENT=$(nmcli -t -f NAME connection show --active 2>/dev/null | head -1)
    WIFI_LIST=$(nmcli -t -f SSID,SIGNAL,SECURITY device wifi list 2>/dev/null | head -10)

    CHOICE=$(printf \
        "󰤨  WiFi подключения\n󰈀  Проводные сети\n󰒃  VPN\n─────────────────\n󱘖  Открыть nmtui\n󰤭  Отключить WiFi" | \
        wofi --dmenu \
             --prompt "Сеть: ${CURRENT:-Нет}" \
             --width 320 \
             --height 300 \
             --cache-file /dev/null)

    case "$CHOICE" in
        *"Открыть nmtui"*)
            kitty --class nmtui \
                  --title "Network Manager" \
                  --override font_size=12 \
                  -e nmtui
            ;;
        *"WiFi подключения"*)
            # Список WiFi сетей
            WIFI=$(nmcli -f SSID,SIGNAL,SECURITY device wifi list | \
                   awk 'NR>1 {printf "%s (signal: %s) %s\n", $1, $2, $3}' | \
                   wofi --dmenu \
                        --prompt "Выберите сеть" \
                        --width 400 \
                        --height 400 \
                        --cache-file /dev/null)

            if [ -n "$WIFI" ]; then
                SSID=$(echo "$WIFI" | awk '{print $1}')
                # Проверяем нужен ли пароль
                SECURITY=$(nmcli -f SSID,SECURITY device wifi list | \
                           grep "^$SSID" | awk '{print $2}')

                if [ "$SECURITY" != "--" ]; then
                    PASSWORD=$(wofi --dmenu \
                        --prompt "Пароль для $SSID" \
                        --width 300 \
                        --height 100 \
                        --password \
                        --cache-file /dev/null < /dev/null)
                    nmcli device wifi connect "$SSID" password "$PASSWORD" && \
                        notify-send "WiFi" "Подключено к $SSID" --icon=network-wireless
                else
                    nmcli device wifi connect "$SSID" && \
                        notify-send "WiFi" "Подключено к $SSID" --icon=network-wireless
                fi
            fi
            ;;
        *"Отключить WiFi"*)
            nmcli radio wifi off
            notify-send "WiFi" "Отключён" --icon=network-wireless-offline
            ;;
        *"VPN"*)
            kitty --class nmtui -e nmtui
            ;;
    esac
}

show_menu
