#/bin/bash

DEST="/home/$USER/.local/share/backgrounds/prank.jpeg"
RAW="https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/wallpaper"

case "$1" in
	"anime" | "anime_C")
		FOLDER="anime_C";;
	*)
		FOLDER="anime_C";;
esac

URL="$RAW"/"$FOLDER"/"$(shuf -i 0-5 -n 1).png"

#if ! [ -f $DEST ]; then
curl -s $URL -o "$DEST"
#fi

gsettings set org.gnome.desktop.background picture-uri-dark "file://$DEST"

