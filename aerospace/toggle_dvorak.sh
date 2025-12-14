#!/bin/bash
CONFIG="$HOME/.config/aerospace/aerospace.toml"
if grep -q "^# preset = 'dvorak'" "$CONFIG"; then
    sed -i '' 's/^# \[key-mapping\]/[key-mapping]/; s/^# preset = '\''dvorak'\''/preset = '\''dvorak'\''/' "$CONFIG"
else
    sed -i '' 's/^\[key-mapping\]/# [key-mapping]/; s/^preset = '\''dvorak'\''/# preset = '\''dvorak'\''/' "$CONFIG"
fi
aerospace reload-config
