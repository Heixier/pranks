#!/bin/bash

# Avoid using YouTube links; YouTube hates fun
URL="https://soundcloud.com/darude/sandstorm-radio-edit"

VOLUME="150%"

pactl set-sink-mute 0 0
pactl set-sink-volume 0 150%

cvlc --quiet --play-and-exit "$URL" 2>/dev/null &
PID=$!
sleep 7 # Hardcoded number because honestly no idea how long it will take for VLC to start playing
pactl set-sink-volume 0 30%
wait $PID
