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

# Declare arrays for today's and tomorrow's events
declare -a TODAY_EVENTS=()
declare -a TOMORROW_EVENTS=()
declare -a WEEKDAYS=()
declare -a WEEKENDS=()
declare -a DAILY=()

# Initialize variables
EVENT_DATE=""
EVENT_SUMMARY=""
EVENT_RRULE=""

# Read and parse the ICS file
while IFS= read -r line; do

  # Check for the start of an event
  if [[ "$line" == "BEGIN:VEVENT" ]]; then
    EVENT_DATE=""
    EVENT_SUMMARY=""
    EVENT_RRULE=""
  
  elif [[ "$line" == RRULE* ]]; then

    if [[ "$line" =~ (^|[^A-Za-z])DAILY([^A-Za-z]|$) ]]; then
      EVENT_RRULE="DAILY"
    elif [[ "$line" =~ BYDAY=([^;]*) ]]; then
      # Extract BYDAY value
      BYDAY="${BASH_REMATCH[1]}"

      # Check if BYDAY includes only weekend
	if [[ "$BYDAY" == *"SU"* ]]; then
          EVENT_RRULE="WEEKENDS"
      #   else
      #     EVENT_RRULE="MIXED"
      #   fi
      else
        EVENT_RRULE="WEEKDAYS"
      fi
    elif [[ "$line" =~ (^|[^A-Za-z])WEEKLY([^A-Za-z]|$) ]]; then
      EVENT_RRULE="WEEKDAYS"
    fi

  elif [[ "$line" == DTSTART* ]]; then
    # Extract date in YYYYMMDD format
    if [[ "$line" =~ DTSTART[^:]*:([0-9]{8}) ]]; then
      EVENT_DATE="${BASH_REMATCH[1]}"
    elif [[ "$line" =~ DTSTART[^:]*:([0-9]{8})T ]]; then
      EVENT_DATE="${BASH_REMATCH[1]}"
    fi

  elif [[ "$line" == SUMMARY* ]]; then
    # Extract event summary
    EVENT_SUMMARY="${line#SUMMARY:}"
  
    # FIXME:
    # Recurring events not working in this End vevent block
  elif [[ "$line" == "END:VEVENT" ]]; then
    # Check if the event is today or tomorrow
    if [[ "$EVENT_DATE" == "$TODAY" ]]; then
      TODAY_EVENTS+=("$EVENT_SUMMARY")
    fi
    if [[ "$EVENT_DATE" == "$TOMORROW" ]]; then
      TOMORROW_EVENTS+=("$EVENT_SUMMARY")
    fi
    if [[ "$EVENT_RRULE" == "WEEKENDS" ]]; then
      WEEKENDS+=("$EVENT_SUMMARY")
    fi
    if [[ "$EVENT_RRULE" == "WEEKDAYS" ]]; then
      WEEKDAYS+=("$EVENT_SUMMARY")
    fi
    if [[ "$EVENT_RRULE" == "DAILY" ]]; then
      DAILY+=("$EVENT_SUMMARY")
    fi
  fi
done <"$ICS_FILE"

# Print results
for event in "${TODAY_EVENTS[@]}"; do
  echo "- $event"
done

for event in "${TOMORROW_EVENTS[@]}"; do
  echo "- $event"
done
for event in "${WEEKENDS[@]}"; do
  echo "- $event"
done	
for event in "${WEEKDAYS[@]}"; do
  echo "- $event"
done
for event in "${DAILY[@]}"; do
	echo "$event"
done
