#!/bin/bash
# Get the first detected option and use that one
autorandr -c

# Old xrandr scripts
# if xrandr | grep "^HDMI.* connected" -A 2 | grep "2560x1440"; then
#   NAME="$(xrandr | grep '^HDMI.* connected' | grep -E -o '^\S*')"
#   xrandr --output $NAME --mode "2560x1440" --auto --output eDP1 --off
# elif xrandr | grep "^DP1 connected" -A 2 | grep "2560x1440"; then
#   autorandr home-display
# elif xrandr | grep "^DP3 connected" -A 2 | grep "2560x1440"; then
#   autorandr home-display
# elif xrandr | grep "^DP3-8 connected" -A 2 | grep "2560x1440"; then
#   autorandr home-display
# elif xrandr | grep "^eDP.* connected" -A 2 | grep "3840x2400"; then
#   autorandr laptop
# elif xrandr | grep "^eDP.* connected" -A 2 | grep "2560x1440"; then
#   xrandr --output eDP1 --mode "2560x1440"--primary --auto
# else
#   xrandr --output eDP1 --mode 1920x1080
# fi
