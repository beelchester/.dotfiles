#!/bin/bash

SESSION=$(/Users/sahil/.cargo/bin/kairos get active | cut -d':' -f1,2)

if [ -z "$SESSION" ] || [ "$SESSION" = "No active session" ]; then
  SESSION="T: $(/Users/sahil/.cargo/bin/kairos get today_total | cut -d':' -f1,2)"
fi

sketchybar --set $NAME label="$SESSION"

