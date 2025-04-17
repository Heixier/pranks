#!/bin/bash

# Note: YouTube tends to block streams
URL="https://soundcloud.com/darude/sandstorm-radio-edit"

# Unmute and max the volume
pactl set-sink-mute @DEFAULT_SINK@ 0
pactl set-sink-volume @DEFAULT_SINK@ 100% # can go up to 150% but we're civil people here

# If the delay argument is provided, only start after 5 minutes. Tick tock...
if [[ "$1" == "delay" ]]; then
	sleep 300
fi

cvlc --quiet --play-and-exit "$URL" 2>/dev/null &
PID=$!
sleep 7 # Hardcoded number because I have no idea how long it will take for VLC to finish downloading

# Set volume back to reasonable levels
pactl set-sink-volume @DEFAULT_SINK@ 30%
wait $PID
