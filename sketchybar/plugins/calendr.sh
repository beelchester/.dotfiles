#!/bin/bash

source path/to/venv/bin/activate
LABEL=$(python3 /Users/sahil/.config/sketchybar/test.py)
sketchybar --set $NAME label="$LABEL"

# ICS_FILE="calendar.ics"
#
# # NOTE: Required to handle time after midnight
# OFFSET=60000
#
# TODAY=$(date +"%Y%m%d")
# TOMORROW=$(date -v+1d +"%Y%m%d")
# CURRENTTIME=$(date +"%H%M%S")
# CURRENTTIME=${CURRENTTIME#0}  # Remove leading zero from CURRENTTIME
# if [ "$CURRENTTIME" -lt "$OFFSET" ]; then
#   CURRENTTIME=$((CURRENTTIME + (240000 - OFFSET)))
# else
#   CURRENTTIME=$((CURRENTTIME - OFFSET))
# fi
# DAY=$(date +"%a")
#
# declare -a TODAY_EVENTS=()
# declare -a TOMORROW_EVENTS=()
# declare -a WEEKDAYS=()
# declare -a WEEKENDS=()
# declare -a DAILY=()
# declare -a CURRENT_EVENT=()
# declare -a NEXT_EVENT=()
# declare -a FINAL_TODAY_EVENTS=()
#
# EVENT_DATE=""
# EVENT_SUMMARY=""
# EVENT_RRULE=""
# EVENT_START_TIME=""
# EVENT_END_TIME=""
#
# NUM_EVENTS=0
#
# while IFS= read -r line; do
#
#   if [[ "$line" == "BEGIN:VEVENT" ]]; then
#     EVENT_DATE=""
#     EVENT_SUMMARY=""
#     EVENT_RRULE=""
#     EVENT_START_TIME=""
#     EVENT_END_TIME=""
#
#   elif [[ "$line" == RRULE* ]]; then
#     if [[ "$line" =~ (^|[^A-Za-z])DAILY([^A-Za-z]|$) ]]; then
#       EVENT_RRULE="DAILY"
#     fi
#     if [[ "$line" =~ BYDAY=([^;]*) ]]; then
#       BYDAY="${BASH_REMATCH[1]}"
#       if [[ "$BYDAY" == *"SU"* ]]; then
#           EVENT_RRULE="WEEKENDS"
#         else
#         EVENT_RRULE="WEEKDAYS"
#       fi
#       fi
#
#   elif [[ "$line" == DTSTART* || "$line" == DTEND* ]]; then
#     if [[ "$line" =~ DTSTART[^:]*:([0-9]{8}) ]]; then
#       EVENT_DATE="${BASH_REMATCH[1]}"
#     elif [[ "$line" =~ DTSTART[^:]*:([0-9]{8})T ]]; then
#       EVENT_DATE="${BASH_REMATCH[1]}"
#     fi
#
#     if [[ "$line" =~ DTSTART[^:]*:[0-9]{8}T([0-9]{6}) ]]; then
#       EVENT_START_TIME="${BASH_REMATCH[1]}"
# EVENT_START_TIME=${EVENT_START_TIME#0}
# if [ "$EVENT_START_TIME" -lt "$OFFSET" ]; then
#   EVENT_START_TIME=$((EVENT_START_TIME + (240000 - OFFSET)))
# else
#   EVENT_START_TIME=$((EVENT_START_TIME - OFFSET))
# fi
#     fi
#
#     if [[ "$line" =~ DTEND[^:]*:([0-9]{8})T([0-9]{6}) ]]; then
#       EVENT_END_TIME="${BASH_REMATCH[2]}"
#       EVENT_END_TIME=${EVENT_END_TIME#0}
# if [ "$EVENT_END_TIME" -lt "$OFFSET" ]; then
#   EVENT_END_TIME=$((EVENT_END_TIME + (240000 - OFFSET)))
# else
#   EVENT_END_TIME=$((EVENT_END_TIME - OFFSET))
# fi
#     fi
#
#   elif [[ "$line" == SUMMARY* ]]; then
#     EVENT_SUMMARY="${line#SUMMARY:}"
#     EVENT_SUMMARY="${EVENT_START_TIME};${EVENT_END_TIME};${EVENT_SUMMARY}"
#
#   elif [[ "$line" == END:VEVENT* ]]; then
#     if [[ "$EVENT_DATE" == "$TODAY" ]]; then
#       TODAY_EVENTS+=("$EVENT_SUMMARY")
#     fi
#     if [[ "$EVENT_DATE" == "$TOMORROW" ]]; then
#       TOMORROW_EVENTS+=("$EVENT_SUMMARY")
#     fi
#     if [[ "$EVENT_RRULE" == "WEEKENDS" ]]; then
#       WEEKENDS+=("$EVENT_SUMMARY")
#     fi
#     if [[ "$EVENT_RRULE" == "WEEKDAYS" ]]; then
#       WEEKDAYS+=("$EVENT_SUMMARY")
#     fi
#     if [[ "$EVENT_RRULE" == "DAILY" ]]; then
#       DAILY+=("$EVENT_SUMMARY")
#     fi
#     NUM_EVENTS=$((NUM_EVENTS+1))
#     fi
#   done <"$ICS_FILE"
#
# for event in "${TODAY_EVENTS[@]}"; do
#   FINAL_TODAY_EVENTS+=("$event")
# done
#
# for event in "${WEEKENDS[@]}"; do
#   if [ "$DAY" == "Sat" ] || [ "$DAY" == "Sun" ]; then
#     FINAL_TODAY_EVENTS+=("$event")
#   fi
# done	
# for event in "${WEEKDAYS[@]}"; do
#   if [ "$DAY" != "Sat" ] && [ "$DAY" != "Sun" ]; then
#     FINAL_TODAY_EVENTS+=("$event")
#   fi
# done
# for event in "${DAILY[@]}"; do
#   FINAL_TODAY_EVENTS+=("$event")
# done
#
# UPCOMING_EVENT=""
# SMALLEST_TIME_DIFF=999999
# UPCOMING_EVENT_START=""
# LABEL=""
#
# for event in "${FINAL_TODAY_EVENTS[@]}"; do
#   IFS=';' read -ra array <<< "$event"
#   START_TIME="${array[0]}"
#   END_TIME="${array[1]}"
#   EVENT_NAME="${array[2]}"
#   # Remove leading and trailing whitespace
#   EVENT_NAME=$(echo "$EVENT_NAME" | tr -d '\n' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
#
#     # Trim event name to 14 chars + ...
#   # if [ ${#EVENT_NAME} -gt 14 ]; then
#   #   EVENT_NAME="${EVENT_NAME:0:10}..."
#   # fi
#
#   echo "$CURRENTTIME"
#   echo "$START_TIME"
#   echo "$END_TIME"
#   if [ "$START_TIME" -le "$CURRENTTIME" ] && [ "$END_TIME" -ge "$CURRENTTIME" ]; then
#     CURRENT_EVENT+=("${array[2]}")
#     END_SEC=$(date -j -f '%Y-%m-%d %H%M%S' "2024-10-20 $END_TIME" '+%s')
#     CURRENT_SEC=$(date -j -f '%Y-%m-%d %H%M%S' "2024-10-20 $CURRENTTIME" '+%s')
#     DIFF_SEC=$((END_SEC - CURRENT_SEC))
#     MIN_DIFF=$((DIFF_SEC / 60))
#     if [ "$MIN_DIFF" -lt "60" ]; then
#       LABEL="$EVENT_NAME ends in $(((DIFF_SEC / 60) + 1)) minutes"
#   else
#     LABEL="$EVENT_NAME ends in $(awk -v diff=$DIFF_SEC 'BEGIN {printf "%.1f", diff/3600}') hours"
#     fi
#   elif [ "$START_TIME" -gt "$CURRENTTIME" ]; then
#     TIME_DIFF=$((START_TIME - CURRENTTIME))
#     if [ "$TIME_DIFF" -lt "$SMALLEST_TIME_DIFF" ]; then
#       SMALLEST_TIME_DIFF=$TIME_DIFF
#       UPCOMING_EVENT=$EVENT_NAME
#       UPCOMING_EVENT_START=$START_TIME
#     fi
#   fi
# done
#
# # If no current event was found, show the upcoming one
# if [ ${#CURRENT_EVENT[@]} -eq 0 ] && [ -n "$UPCOMING_EVENT" ]; then
#     UP_SEC=$(date -j -f '%Y-%m-%d %H%M%S' "2024-10-20 $UPCOMING_EVENT_START" '+%s')
#     CURRENT_SEC=$(date -j -f '%Y-%m-%d %H%M%S' "2024-10-20 $CURRENTTIME" '+%s')
#     DIFF_SEC=$((END_SEC - CURRENT_SEC))
#     if [ "$MIN_DIFF" -lt "60" ]; then
#     LABEL="$EVENT_NAME starts in $(((DIFF_SEC / 60) + 1)) minutes"
#   else
#     LABEL="$EVENT_NAME starts in $(awk -v diff=$DIFF_SEC 'BEGIN {printf "%.1f", diff/3600}') hours"
#     fi
# fi
#
# sketchybar --set $NAME label="$LABEL"
