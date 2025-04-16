#!/bin/bash

# Note: YouTube tends to block streams
URL="https://soundcloud.com/darude/sandstorm-radio-edit"

# Unmute and super max the volume
pactl set-sink-mute 0 0
pactl set-sink-volume 0 150%

# Only starts after 5 minutes. Tick tock...
sleep 300

cvlc --quiet --play-and-exit "$URL" 2>/dev/null &
PID=$!
sleep 7 # Hardcoded number because I have no idea how long it will take for VLC to finish downloading

# Set volume back to reasonable levels
pactl set-sink-volume 0 30%
wait $PID
