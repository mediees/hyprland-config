#!/bin/bash
# Bluetooth меню (аналог nmtui для BT)

ACTION=$1

show_menu() {
    # Получаем список устройств
    DEVICES=$(bluetoothctl devices | awk '{print $2, $3}')
    CONNECTED=$(bluetoothctl info 2>/dev/null | grep "Name:" | awk '{print $2}')

    OPTIONS="󰂯 Scan for devices\n󰂲 Toggle Bluetooth\n─────────────────"

    # Добавляем сохранённые устройства
    while IFS= read -r line; do
        MAC=$(echo "$line" | awk '{print $1}')
        NAME=$(echo "$line" | awk '{$1=""; print $0}' | xargs)
        IS_CONNECTED=$(bluetoothctl info "$MAC" 2>/dev/null | grep "Connected: yes")

        if [ -n "$IS_CONNECTED" ]; then
            OPTIONS="$OPTIONS\n󰂱 $NAME (connected)"
        else
            OPTIONS="$OPTIONS\n󰂯 $NAME"
        fi
    done <<< "$DEVICES"

    CHOICE=$(echo -e "$OPTIONS" | wofi \
        --dmenu \
        --prompt "Bluetooth" \
        --width 350 \
        --height 400 \
        --style "$HOME/.config/wofi/bluetooth.css" \
        --cache-file /dev/null)

    case "$CHOICE" in
        *"Toggle Bluetooth"*)
            BT_STATE=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')
            if [ "$BT_STATE" = "yes" ]; then
                bluetoothctl power off
                notify-send "Bluetooth" "Выключен" -i bluetooth-disabled
            else
                bluetoothctl power on
                notify-send "Bluetooth" "Включён" -i bluetooth-active
            fi
            ;;
        *"Scan"*)
            kitty --class bluetooth-scan -e bash -c "
                bluetoothctl scan on &
                echo 'Сканирование...'
                sleep 10
                bluetoothctl scan off
                echo 'Готово. Нажмите Enter'
                read
            "
            ;;
        *)
            if [ -n "$CHOICE" ]; then
                DEVICE_NAME=$(echo "$CHOICE" | sed 's/󰂱 //;s/󰂯 //;s/ (connected)//')
                MAC=$(bluetoothctl devices | grep "$DEVICE_NAME" | awk '{print $2}')

                IS_CONNECTED=$(bluetoothctl info "$MAC" 2>/dev/null | grep "Connected: yes")
                if [ -n "$IS_CONNECTED" ]; then
                    bluetoothctl disconnect "$MAC"
                    notify-send "Bluetooth" "Отключено от $DEVICE_NAME" -i bluetooth-disabled
                else
                    bluetoothctl connect "$MAC" && \
                    notify-send "Bluetooth" "Подключено к $DEVICE_NAME" -i bluetooth-active || \
                    notify-send "Bluetooth" "Ошибка подключения" -i bluetooth-disabled
                fi
            fi
            ;;
    esac
}

show_menu
