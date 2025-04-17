#!/bin/bash

# Note: YouTube tends to block streams
URL="https://soundcloud.com/darude/sandstorm-radio-edit"

# Store original values to reset to later
original_volume="pactl get-sink-volume @DEFAULT_SINK@ | head -1 | awk '{ print $5 }'"
original_port="pactl list sinks | grep "Active Port" | awk '{ print $3 }'"

# Make sure the audio plays

# Sets the output to speaker so people on headphones don't die
pactl set-sink-port @DEFAULT_SINK@ analog-output-speaker

# Unmute and max the volume
pactl set-sink-mute @DEFAULT_SINK@ 0
pactl set-sink-volume @DEFAULT_SINK@ 100% # can go up to 150%

# If the argument provided is a number, then delay for that number.

timebomb () {
	if [[ $1 ]] && [[ "$1" =~ ^[0-9]+$ ]]; then
		if (( $1 > 420 )); then
			sleep $1
		else
			printf "sandstorm: cancelled sleep: risky to sleep for so long\n"
		fi
	fi
}

timebomb "$@"

cvlc --quiet --play-and-exit "$URL" 2>/dev/null &
PID=$!
sleep 6 # Hardcoded guess at download times

# Set volume back to reasonable levels
pactl set-sink-volume @DEFAULT_SINK@ 25%
wait $PID

pactl set-sink-port @DEFAULT_SINK@ "$original_port"
pactl set-sink-volume @DEFAULT_SINK@ "$original_volume"
