#!/bin/bash

ICS_URL="https://calendar.google.com/calendar/ical/a471efc31871f08d6b49076e8661d94eaf6d992a948813a5d6fafa06906f8664%40group.calendar.google.com/public/basic.ics"
ICS_FILE="calendar.ics"

# === Download the ICS File ===
curl -s "$ICS_URL" -o "$ICS_FILE"

if [ $? -ne 0 ]; then
  echo "Failed to download the ICS file."
  exit 1
fi

# Get today's and tomorrow's dates
TODAY=$(date +"%Y%m%d")
TOMORROW=$(date -v+1d +"%Y%m%d")
# CURRENTTIME=$(date +"%H%M%S")
CURRENTTIME=130603
DAY=$(date +"%a")
# echo $DAY
# echo $TODAY
# echo $CURRENTTIME
# DTSTART;TZID=Asia/Kolkata:20250113T230000

# Declare arrays for today's and tomorrow's events
declare -a TODAY_EVENTS=()
declare -a TOMORROW_EVENTS=()
declare -a WEEKDAYS=()
declare -a WEEKENDS=()
declare -a DAILY=()

declare -a CURRENT_EVENT=()
declare -a NEXT_EVENT=()

declare -a FINAL_TODAY_EVENTS=()

# Initialize variables
EVENT_DATE=""
EVENT_SUMMARY=""
EVENT_RRULE=""
EVENT_START_TIME=""
EVENT_END_TIME=""

NUM_EVENTS=0

# Read and parse the ICS file
while IFS= read -r line; do

  # echo "$line"

  # Check for the start of an event
  if [[ "$line" == "BEGIN:VEVENT" ]]; then
    EVENT_DATE=""
    EVENT_SUMMARY=""
    EVENT_RRULE=""
    EVENT_START_TIME=""
    EVENT_END_TIME=""

  elif [[ "$line" == RRULE* ]]; then

    if [[ "$line" =~ (^|[^A-Za-z])DAILY([^A-Za-z]|$) ]]; then
      # echo "$NUM_EVENTS is daily"
      EVENT_RRULE="DAILY"
    fi
    if [[ "$line" =~ BYDAY=([^;]*) ]]; then
      # Extract BYDAY value
      BYDAY="${BASH_REMATCH[1]}"
      # echo "---------- byday $BYDAY"

      # Check if BYDAY includes only weekend
      if [[ "$BYDAY" == *"SU"* ]]; then
          # echo "**** $NUM_EVENTS is weekend"
          EVENT_RRULE="WEEKENDS"
        else
        # echo "$NUM_EVENTS is weekday"
        EVENT_RRULE="WEEKDAYS"
      fi
      fi

  elif [[ "$line" == DTSTART* || "$line" == DTEND* ]]; then
    # Extract date in YYYYMMDD format
    if [[ "$line" =~ DTSTART[^:]*:([0-9]{8}) ]]; then
      # echo "$NUM_EVENTS is DTSTART"
      EVENT_DATE="${BASH_REMATCH[1]}"
    elif [[ "$line" =~ DTSTART[^:]*:([0-9]{8})T ]]; then
      # echo "$NUM_EVENTS is DTSTART2"
      EVENT_DATE="${BASH_REMATCH[1]}"
    fi

    # Extract time in HHMMSS format
    if [[ "$line" =~ DTSTART[^:]*:[0-9]{8}T([0-9]{6}) ]]; then
      # echo "$NUM_EVENTS is DTSTART3"
      # echo "start ${BASH_REMATCH[1]}"
      EVENT_START_TIME="${BASH_REMATCH[1]}"
    fi

    if [[ "$line" =~ DTEND[^:]*:([0-9]{8})T([0-9]{6}) ]]; then
      # echo "$NUM_EVENTS is DTEND"
      # echo "end ${BASH_REMATCH[2]}"
      EVENT_END_TIME="${BASH_REMATCH[2]}"
    fi

  elif [[ "$line" == SUMMARY* ]]; then
    # Extract event summary and add EVENT_START_TIME and EVENT_END_TIME
    EVENT_SUMMARY="${line#SUMMARY:}"
    EVENT_SUMMARY="${EVENT_START_TIME};${EVENT_END_TIME};${EVENT_SUMMARY}"
    # echo "$EVENT_SUMMARY"

  elif [[ "$line" == END:VEVENT* ]]; then
    # echo "at end of event $NUM_EVENTS"
    # Check if the event is today or tomorrow
    if [[ "$EVENT_DATE" == "$TODAY" ]]; then
      # echo "$NUM_EVENTS as today"
      TODAY_EVENTS+=("$EVENT_SUMMARY")
    fi
    if [[ "$EVENT_DATE" == "$TOMORROW" ]]; then
      # echo "$NUM_EVENTS as tomorrow"
      TOMORROW_EVENTS+=("$EVENT_SUMMARY")
    fi
    if [[ "$EVENT_RRULE" == "WEEKENDS" ]]; then
      # echo "$NUM_EVENTS as weekend"
      WEEKENDS+=("$EVENT_SUMMARY")
    fi
    if [[ "$EVENT_RRULE" == "WEEKDAYS" ]]; then
      # echo "$NUM_EVENTS as weekday"
      WEEKDAYS+=("$EVENT_SUMMARY")
    fi
    if [[ "$EVENT_RRULE" == "DAILY" ]]; then
      # echo "$NUM_EVENTS as daily"
      DAILY+=("$EVENT_SUMMARY")
    fi
    # echo "num event $NUM_EVENTS is $EVENT_SUMMARY"
    NUM_EVENTS=$((NUM_EVENTS+1))
    # echo "------------------------------"
    fi
  done <"$ICS_FILE"

# Print results
for event in "${TODAY_EVENTS[@]}"; do
  FINAL_TODAY_EVENTS+=("$event")
  # echo "today $event"
done

# for event in "${TOMORROW_EVENTS[@]}"; do
  # echo "tom $event"
# done

for event in "${WEEKENDS[@]}"; do
  if [ "$DAY" == "Sat" ] || [ "$DAY" == "Sun" ]; then
    # echo "weekend $event"
    FINAL_TODAY_EVENTS+=("$event")
  fi
done	
for event in "${WEEKDAYS[@]}"; do
  if [ "$DAY" != "Sat" ] && [ "$DAY" != "Sun" ]; then
    # echo "weekday $event"
    FINAL_TODAY_EVENTS+=("$event")
  fi
done
for event in "${DAILY[@]}"; do
  FINAL_TODAY_EVENTS+=("$event")
  # echo "daily $event"
done

UPCOMING_EVENT=""
SMALLEST_TIME_DIFF=999999  # Initialize with a large number
UPCOMING_EVENT_START=""

for event in "${FINAL_TODAY_EVENTS[@]}"; do
  IFS=';' read -ra array <<< "$event"
  START_TIME="${array[0]}"
  END_TIME="${array[1]}"
  EVENT_NAME="${array[2]}"
  # Remove leading and trailing whitespace
  EVENT_NAME=$(echo "$EVENT_NAME" | tr -d '\n' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

    # Trim event name to 10 chars + ...
  if [ ${#EVENT_NAME} -gt 14 ]; then
    EVENT_NAME="${EVENT_NAME:0:10}..."
  fi

  if [ "$START_TIME" -le "$CURRENTTIME" ] && [ "$END_TIME" -ge "$CURRENTTIME" ]; then
    # echo "current is $EVENT_NAME"
    CURRENT_EVENT+=("${array[2]}")
    END_SEC=$(date -j -f '%Y-%m-%d %H%M%S' "2024-10-20 $END_TIME" '+%s')
    CURRENT_SEC=$(date -j -f '%Y-%m-%d %H%M%S' "2024-10-20 $CURRENTTIME" '+%s')
    DIFF_SEC=$((END_SEC - CURRENT_SEC))
    MIN_DIFF=$((DIFF_SEC / 60))
    if [ "$MIN_DIFF" -lt "60" ]; then
    echo "$EVENT_NAME ends in $((DIFF_SEC / 60)) minutes"
  else
    echo "$EVENT_NAME ends in $(awk -v diff=$DIFF_SEC 'BEGIN {printf "%.1f", diff/3600}') hours"
    fi
  elif [ "$START_TIME" -gt "$CURRENTTIME" ]; then
    # Calculate time difference for upcoming events
    TIME_DIFF=$((START_TIME - CURRENTTIME))
    if [ "$TIME_DIFF" -lt "$SMALLEST_TIME_DIFF" ]; then
      SMALLEST_TIME_DIFF=$TIME_DIFF
      UPCOMING_EVENT=$EVENT_NAME
      UPCOMING_EVENT_START=$START_TIME
    fi
  fi
done

# If no current event was found, show the upcoming one
# if [ ${#CURRENT_EVENT[@]} -eq 0 ] && [ -n "$UPCOMING_EVENT" ]; then
    UP_SEC=$(date -j -f '%Y-%m-%d %H%M%S' "2024-10-20 $UPCOMING_EVENT_START" '+%s')
    CURRENT_SEC=$(date -j -f '%Y-%m-%d %H%M%S' "2024-10-20 $CURRENTTIME" '+%s')
    DIFF_SEC=$((END_SEC - CURRENT_SEC))
    if [ "$MIN_DIFF" -lt "60" ]; then
    echo "$EVENT_NAME starts in $((DIFF_SEC / 60)) minutes"
  else
    echo "$EVENT_NAME starts in $(awk -v diff=$DIFF_SEC 'BEGIN {printf "%.1f", diff/3600}') hours"
    fi
# fi
