#!/bin/bash

# Adding safe mode to preserve sanity (default)
SAFE_MODE=1

# Note: YouTube tends to block streams; don't use YouTube
#URL="https://soundcloud.com/darude/sandstorm-radio-edit"
URL="https://soundcloud.com/the_thoosher/fripside-only-my-railgun-original-2020-version"

# Store original values to reset to later
original_volume="$(pactl get-sink-volume @DEFAULT_SINK@ | head -1 | awk '{ print $5 }')"
original_port="$(pactl list sinks | grep "Active Port" | awk '{ print $3 }')"

if ! [[ "$original_port" == "analog-output-speaker" ]]; then
	printf "connect to speakers!\n"
	exit 1
fi

# Unmute and set the volume
pactl set-sink-mute @DEFAULT_SINK@ 0
if (( $SAFE_MODE == 1 )); then
	pactl set-sink-volume @DEFAULT_SINK@ 25% # coward mode
else
	pactl set-sink-volume @DEFAULT_SINK@ 100% # can go up to 150%
fi

# Sleep for X number of seconds (if provided)
timebomb () {
	if [[ "$1" =~ ^[0-9]+$ ]]; then
		if (( $1 <= 420 )); then
			sleep $1
		else
			printf "jam: cancelled sleep: risky to sleep for so long\n"
		fi
	fi
}

timebomb "$@"

cvlc --quiet --play-and-exit "$URL" 2>/dev/null &
PID=$!
sleep 6 # Hardcoded guess at download times

# Bring volume back down
pactl set-sink-volume @DEFAULT_SINK@ 25%
wait $PID

pactl set-sink-volume @DEFAULT_SINK@ "$original_volume"
