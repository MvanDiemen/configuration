#!/bin/bash

# Terminate the existing polybar
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

DISPLAY1="$(xrandr -q | grep '^HDMI.* connected' | grep '.*x.* ' | cut -d ' ' -f1)"
  [[ ! -z "$DISPLAY1" ]] && MONITOR="${DISPLAY1}" polybar top &

DISPLAY2="$(xrandr -q | grep '^DP.* connected' | grep '.*x.* ' | cut -d ' ' -f1)"
  [[ ! -z "$DISPLAY2" ]] && MONITOR="${DISPLAY2}" polybar top &

DISPLAY6="$(xrandr -q | grep '^eDP1 connected' | grep '.*x.* ' | cut -d ' ' -f1)"
  [[ ! -z "$DISPLAY6" ]] && MONITOR="${DISPLAY6}" polybar top &
