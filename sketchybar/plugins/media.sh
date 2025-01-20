#!/bin/bash

update_media() {
  STATE="$(echo "$INFO" | jq -r '.state')"

  if [ "$STATE" = "playing" ]; then
    APP=$(echo "$INFO" | jq -r '.app')
    MEDIA="$(echo "$INFO" | jq -r '.title')"
    sketchybar --set $NAME label="$MEDIA" drawing=on
  else
    sketchybar --set $NAME drawing=off
  fi
}

click() {
  CURRENT_WIDTH="$(sketchybar --query $NAME | jq -r .label.width)"

  WIDTH=0
  PAD=false
  if [ "$CURRENT_WIDTH" -eq "0" ]; then
    WIDTH=dynamic
    PAD=true
  else 
    PAD=false
  fi

  if $PAD; then
    sketchybar --set $NAME label.padding_right=10
  else
    sketchybar --set $NAME label.padding_right=0
  fi

  sketchybar --animate sin 20 --set $NAME label.width="$WIDTH"
}

case "$SENDER" in
  "media_change") update_media
  ;;
  "mouse.clicked") click
  ;;
esac
