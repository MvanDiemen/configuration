#!/bin/bash
if xrandr | grep "^HDMI.* connected" -A 2 | grep "2560x1440"; then
  NAME="$(xrandr | grep '^HDMI.* connected' | grep -E -o '^\S*')"
  xrandr --output $NAME --mode "2560x1440" --auto --output eDP1 --off
elif xrandr | grep "^DP.* connected" -A 2 | grep "2560x1440"; then
  NAME="$(xrandr | grep '^DP.* connected' | grep -E -o '^\S*')"
  eval $(xrandr --output $NAME --mode "2560x1440" --primary --auto --output eDP1 --off)
elif xrandr | grep "^eDP.* connected" -A 2 | grep "3840x2400"; then
  # Laptop monitor Dell XPS (4k 16:10)
  NAME="$(xrandr | grep '^eDP.* connected' | grep -E -o '^\S*')"
  eval $(xrandr --output $NAME --mode "3840x2400" --scale 0.50x0.50 --primary --auto)
  betterlockscreen -u ~/Pictures/wallpapers/pastel-mountains.jpg -r 3840x2400
  feh --bg-scale ~/Pictures/wallpapers/panda.jpg
elif xrandr | grep "^eDP.* connected" -A 2 | grep "2560x1440"; then
  # Laptop monitor Lenovo X1 (2k 16:9)
  NAME="$(xrandr | grep '^eDP.* connected' | grep -E -o '^\S*')"
  eval $(xrandr --output $NAME --mode "2560x1440"--primary --auto)
else
  xrandr --output eDP1 --mode 1920x1080
fi
