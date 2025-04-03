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

curl -s $URL -o "$DEST"

gsettings set org.gnome.desktop.background color-shading-type 'solid'
gsettings set org.gnome.desktop.background picture-options 'zoom'

#printf "URL: $URL DEST: $DEST\n"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$DEST"

URL="$RAW"/"$FOLDER"/"$(shuf -i 0-5 -n 1).$EXT"
gsettings set org.gnome.desktop.background picture-uri "file://$DEST"

