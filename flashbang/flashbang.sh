#!/bin/bash

disco () {
	clear
	count=30
	xrandr -x -y
	sleep 0.2
	while (( $count > 0 )); do
		if (( $count % 2 )) && (( $count != 1 )); then
			xrandr --output HDMI-2 --brightness 0
		else
			xrandr --output HDMI-2 --brightness 100000
		fi;
		sleep 0.025
		count=$(( $count - 1 ))
	done
	xrandr --output HDMI-2 --brightness 1
	xrandr --output HDMI-2 --reflect normal
}

disco
