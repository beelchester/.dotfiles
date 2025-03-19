num_displays=$(system_profiler SPDisplaysDataType | grep -c "Resolution:")

if [ "$num_displays" -eq 2 ]; then
  DISPLAY_OPTION=1
else
  DISPLAY_OPTION=2
fi

sketchybar --add item calendr center \
  --set calendr \
  background.height=25 \
  padding_left=0 \
  padding_right=10 \
  script=$PLUGIN_DIR/calendr.sh \
  update_freq=15 \
  display=$DISPLAY_OPTION
