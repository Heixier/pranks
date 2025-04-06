#!/bin/bash

# Menu for selecting which scripts to run

for opt in "$@"
do
	case opt in
		"bg" | "wallpaper")
			bash <(curl -s https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/wallpaper/change_bg.sh);;

		"profile" | "icon" | face)
			bash <(curl -s https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/face/change_pic.sh);;

		"parrot")
			bash <curl -s 

exit 
