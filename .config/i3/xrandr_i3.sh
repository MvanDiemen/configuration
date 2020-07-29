#!/bin/bash
if xrandr | grep "^HDMI1 connected" -A 2 | grep "2560x1440"; then
  xrandr --output HDMI1 --mode "2560x1440" --auto --output eDP1 --off
elif xrandr | grep "^HDMI1 connected" -A 2 | grep "1920x1080"; then
  xrandr --output HDMI1 --mode "1920x1080" --auto --output eDP1 --off
elif xrandr | grep "^DP1 connected"; then
  xrandr --output DP1 --mode "2560x1440" --auto --output eDP1 --off
elif xrandr | grep "^DP2 connected"; then
    xrandr --output DP2 --mode "2560x1440" --auto --output eDP1 --off
else
  xrandr --auto --output eDP1 --dpi 120 --mode "2560x1440"
fi
