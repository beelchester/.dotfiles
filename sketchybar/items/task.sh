sketchybar --add item task_separator center \
  --set task_separator \
  label="|" \
  label.color=$MAGENTA \
  padding_left=0 \
  padding_right=10 \

sketchybar --add item task center \
  --set task \
  background.height=25 \
  padding_left=0 \
  padding_right=10 \
  script=$PLUGIN_DIR/task_dont_push.sh \
  update_freq=15 \
