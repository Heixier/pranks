#/bin/bash

EXT="jpg"
DEST="/home/$USER/.local/share/backgrounds/prank.$EXT"
RAW="https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/wallpaper"

case "$1" in
	"anime" | "anime_C")
		FOLDER="anime_C";;
	*)
		FOLDER="anime_C";;
esac

URL="$RAW"/"$FOLDER"/"$(shuf -i 0-5 -n 1).$EXT"

#if [ -f $DEST ]; then
#	rm "$DEST"
#fi
#sleep 0.1
curl -s $URL -o "$DEST"

open $URL
printf "URL: $URL DEST: $DEST\n"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$DEST"

