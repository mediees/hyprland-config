#!/bin/bash
# Режимы работы батареи

get_current_mode() {
    if [ -f /sys/firmware/acpi/platform_profile ]; then
        cat /sys/firmware/acpi/platform_profile
    elif command -v powerprofilesctl &>/dev/null; then
        powerprofilesctl get
    else
        echo "unknown"
    fi
}

set_mode() {
    local MODE=$1
    if [ -f /sys/firmware/acpi/platform_profile ]; then
        echo "$MODE" | sudo tee /sys/firmware/acpi/platform_profile
    elif command -v powerprofilesctl &>/dev/null; then
        powerprofilesctl set "$MODE"
    fi
}

show_menu() {
    CURRENT=$(get_current_mode)

    # Иконки для режимов
    case "$CURRENT" in
        "performance") CURRENT_ICON="󰓅" ;;
        "balanced")    CURRENT_ICON="󰾅" ;;
        "power-saver") CURRENT_ICON="󰾆" ;;
        *)             CURRENT_ICON="󰾅" ;;
    esac

    BATTERY=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1)
    STATUS=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -1)

    CHOICE=$(printf \
        "󰓅  Performance\n󰾅  Balanced\n󰾆  Power Saver\n─────────────\n󰂄  Battery Info" | \
        wofi --dmenu \
             --prompt "Battery [$BATTERY%] $CURRENT_ICON" \
             --width 300 \
             --height 280 \
             --cache-file /dev/null)

    case "$CHOICE" in
        *"Performance"*)
            set_mode "performance"
            notify-send "Battery" "Режим: Performance 󰓅" \
                --icon=battery-full-charging
            ;;
        *"Balanced"*)
            set_mode "balanced"
            notify-send "Battery" "Режим: Balanced 󰾅" \
                --icon=battery-full
            ;;
        *"Power Saver"*)
            set_mode "power-saver"
            notify-send "Battery" "Режим: Power Saver 󰾆" \
                --icon=battery-caution
            ;;
        *"Battery Info"*)
            HEALTH=$(cat /sys/class/power_supply/BAT*/capacity_level 2>/dev/null | head -1)
            VOLTAGE=$(cat /sys/class/power_supply/BAT*/voltage_now 2>/dev/null | head -1)
            NOTIFY_MSG="Заряд: $BATTERY%\nСтатус: $STATUS\nРежим: $CURRENT"
            notify-send "Battery Info" "$NOTIFY_MSG" --icon=battery-full
            ;;
    esac
}

show_menu
