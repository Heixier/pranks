#!/bin/bash

disco () {
	count=25
	xrandr -x -y
	while (( $count > 0 )); do
		if (( $count % 2 )) && (( $count != 1 )); then
			xrandr --output HDMI-2 --brightness 0
		else
			xrandr --output HDMI-2 --brightness 10000
		fi;
		sleep 0.1
		count=$(( $count - 1 ))
	done
	xrandr --output HDMI-2 --brightness 1
	xrandr --output HDMI-2 --reflect normal
}

disco
