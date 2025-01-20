#!/bin/bash

killall stats_provider
$CONFIG_DIR/stats_provider/stats_provider --disk usage --memory ram_usage &

cpu_top=(
  label.font="$FONT:Semibold:7"
  label=CPU
  icon.drawing=off
  width=0
  padding_right=-52
  y_offset=10
)

cpu_percent=(
  label.font="$FONT:Heavy:10"
  label=CPU
  y_offset=0
  # padding_right=15
  width=55
  icon.drawing=off
  update_freq=4
  mach_helper="$HELPER"
)

cpu_sys=(
  width=0
  graph.color=$PEACH
  graph.fill_color=$PEACH
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
  padding_right=17
  y_offset=-10
)

disk_percent=(
  label.font="$FONT:Heavy:7"
  label=Disk
  padding_right=3.5
  y_offset=-10
  width=0
  icon.drawing=off
)

sketchybar --add item cpu.percent right          \
           --set cpu.percent "${cpu_percent[@]}" \
             --add item cpu.top right              \
             --set cpu.top "${cpu_top[@]}"         \
           --add item disk_usage right \
           --set disk_usage script='DISK_USAGE=$(echo $DISK_USAGE | sed "s/.$//"); sketchybar --set disk_usage label=$DISK_USAGE' "${disk_percent[@]}" \
           --subscribe disk_usage system_stats\
           --add item ram_usage right \
           --set ram_usage script='RAM_USAGE=$(echo $RAM_USAGE | sed "s/.$//"); sketchybar --set ram_usage label=$RAM_USAGE' "${ram_percent[@]}" \
           --subscribe ram_usage system_stats

           # TODO: Add CPU graph in popup or only show when monitor is used, to prevent overlapping
           # --add graph cpu.sys right 75          \
           #   --set cpu.sys "${cpu_sys[@]}"         \
           # --add graph cpu.user right 75         \
           # --set cpu.user "${cpu_user[@]}"\
