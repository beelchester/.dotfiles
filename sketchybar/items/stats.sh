killall stats_provider
# Update with path to stats_provider and invoke cli for your desired stats
# This example will send cpu, disk and ram usage percentages
$CONFIG_DIR/stats_provider/stats_provider --disk usage --memory ram_usage &
ram_percent=(
  label.font="$FONT:Semibold:9"
  label=RAM
  icon.drawing=off
  width=0
  padding_right=-40
  y_offset=6
)

disk_percent=(
  label.font="$FONT:Semibold:9"
  label=Disk
  y_offset=-4
  padding_right=15
  width=55
  icon.drawing=off
)

sketchybar --add item disk_usage right \
           --set disk_usage script="sketchybar --set disk_usage label=\$DISK_USAGE" "${disk_percent[@]}" \
           --subscribe disk_usage system_stats
sketchybar --add item ram_usage right \
           --set ram_usage script="sketchybar --set ram_usage label=\$RAM_USAGE" "${ram_percent[@]}" \
           --subscribe ram_usage system_stats
