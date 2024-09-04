#!/bin/bash

killall stats_provider
$CONFIG_DIR/stats_provider/stats_provider --disk usage --memory ram_usage &

cpu_top=(
  label.font="$FONT:Semibold:7"
  label=CPU
  icon.drawing=off
  width=0
  padding_right=15
  y_offset=6
)

cpu_percent=(
  label.font="$FONT:Heavy:10"
  label=CPU
  y_offset=-4
  # padding_right=15
  width=55
  icon.drawing=off
  update_freq=4
  mach_helper="$HELPER"
)

cpu_sys=(
  width=0
  graph.color=$RED
  graph.fill_color=$RED
  label.drawing=off
  icon.drawing=off
  background.height=30
  background.drawing=on
  background.color=$TRANSPARENT
)

cpu_user=(
  graph.color=$BLUE
  label.drawing=off
  icon.drawing=off
  background.height=30
  background.drawing=on
  background.color=$TRANSPARENT
)

ram_percent=(
  label.font="$FONT:Heavy:7"
  label=RAM
  icon.drawing=off
  width=0
  padding_right=23.5
  y_offset=-14
)

disk_percent=(
  label.font="$FONT:Heavy:7"
  label=Disk
  padding_right=3.5
  y_offset=-14
  width=0
  icon.drawing=off
)

sketchybar --add item cpu.top right              \
           --set cpu.top "${cpu_top[@]}"         \
                                                 \
           --add item cpu.percent right          \
           --set cpu.percent "${cpu_percent[@]}" \
                                                 \
           --add graph cpu.sys right 75          \
           --set cpu.sys "${cpu_sys[@]}"         \
                                                 \
           --add graph cpu.user right 75         \
           --set cpu.user "${cpu_user[@]}"\
           --add item disk_usage right \
           --set disk_usage script="sketchybar --set disk_usage label=\$DISK_USAGE" "${disk_percent[@]}" \
           --subscribe disk_usage system_stats\
           --add item ram_usage right \
           --set ram_usage script="sketchybar --set ram_usage label=\$RAM_USAGE" "${ram_percent[@]}" \
           --subscribe ram_usage system_stats
