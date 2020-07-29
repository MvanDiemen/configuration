#!/usr/bin/env sh

# Terminate the existing polybar
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

DISPLAY1="$(xrandr -q | grep '^HDMI1 connected' | cut -d ' ' -f1)"
  [[ ! -z "$DISPLAY1" ]] && MONITOR="HDMI1" polybar top &

DISPLAY2="$(xrandr -q | grep '^DP1 connected' | cut -d ' ' -f1)"
  [[ ! -z "$DISPLAY2" ]] && MONITOR="DP1" polybar top &

DISPLAY3="$(xrandr -q | grep "^DP2 connected" | cut -d ' ' -f1)"
  [[ ! -z "$DISPLAY3" ]] && MONITOR="DP2" polybar top &

DISPLAY6="$(xrandr -q | grep '^eDP1 connected' | cut -d ' ' -f1)"
  [[ ! -z "$DISPLAY6" ]] && MONITOR="eDP1" polybar top &
