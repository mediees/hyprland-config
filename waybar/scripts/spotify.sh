#!/bin/bash

PLAYER="spotify"
STATUS=$(playerctl -p $PLAYER status 2>/dev/null)

if [ -z "$STATUS" ] || [ "$STATUS" = "No players found" ]; then
    printf '{"text":"","tooltip":"Spotify не запущен","class":"stopped"}\n'
    exit 0
fi

TITLE=$(playerctl -p $PLAYER metadata title 2>/dev/null | cut -c1-22)
ARTIST=$(playerctl -p $PLAYER metadata artist 2>/dev/null | cut -c1-18)
ALBUM=$(playerctl -p $PLAYER metadata album 2>/dev/null | cut -c1-25)

# Добавляем … если обрезано
RAW_TITLE=$(playerctl -p $PLAYER metadata title 2>/dev/null)
RAW_ARTIST=$(playerctl -p $PLAYER metadata artist 2>/dev/null)

if [ ${#RAW_TITLE} -gt 22 ]; then
    TITLE="${TITLE}…"
fi
if [ ${#RAW_ARTIST} -gt 18 ]; then
    ARTIST="${ARTIST}…"
fi

if [ "$STATUS" = "Playing" ]; then
    CLASS="playing"
    STATUS_ICON=""
else
    CLASS="paused"
    STATUS_ICON=""
fi

# Текст: иконка + трек — артист
TEXT="${STATUS_ICON}  ${TITLE}  —  ${ARTIST}"

# Tooltip с деталями
TOOLTIP="${STATUS_ICON} ${TITLE}\n ${ARTIST}\n 󰀥 ${ALBUM}\n\n󰒭 Scroll Up — Next\n󰒮 Scroll Down — Prev\n  Click — Play/Pause"

printf '{"text":"%s","tooltip":"%s","class":"%s"}\n' \
    "$TEXT" "$TOOLTIP" "$CLASS"
