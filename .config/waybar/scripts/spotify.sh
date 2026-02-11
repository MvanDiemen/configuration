#!/bin/sh

status=$(playerctl --player=spotify status 2>/dev/null)

if [[ "$status" == "Playing" ]]; then
    artist=$(playerctl --player=spotify metadata artist)
    title=$(playerctl --player=spotify metadata title)
    echo " $artist - $title"
elif [[ "$status" == "Paused" ]]; then
    artist=$(playerctl --player=spotify metadata artist)
    title=$(playerctl --player=spotify metadata title)
    echo " $artist - $title"
else
    echo ""
fi
