#!/bin/bash

TAG="Doing"

res=$(curl -s -X GET \
  "https://api.todoist.com/rest/v2/tasks?label=$TAG" \
  -H "Authorization: Bearer $TODOIST_TOKEN")

TASK_CONTENT=$(echo "$res" | jq -r '.[0].content')

# Trim task name to 10 chars + ...
# if [ ${#TASK_CONTENT} -gt 14 ]; then
#   TASK_CONTENT="${TASK_CONTENT:0:10}..."
# fi

sketchybar --set $NAME label="$TASK_CONTENT"
