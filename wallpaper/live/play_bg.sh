#!/bin/bash

if [[ $1 ]]; then
	FILE="$1"
else
	FILE="$HOME/.local/share/backgrounds/live.mp4"
fi
$HOME/.local/bin/xwinwrap -fs -fdt -ni -b -nf -un -o 1.0 -- /usr/bin/cvlc --no-video-title-show --drawable-xid WID --loop --no-audio "$FILE"
