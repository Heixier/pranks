#/bin/bash

EXT="jpg"
IMAGE="hi.$EXT"
DEST="/home/$USER/.local/share/backgrounds"
RAW="https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/wallpaper"

case "$1" in
	"anime" | "anime_C")
		FOLDER="anime_C";;
	*)
		FOLDER="anime_C";;
esac

if ! [ -d "$DEST" ]; then
	mkdir -p "$DEST"
fi

URL="$RAW"/"$FOLDER"/"$(shuf -i 0-5 -n 1).$EXT"
curl -s $URL -o "$DEST/$IMAGE"

gsettings set org.gnome.desktop.background color-shading-type 'solid'
gsettings set org.gnome.desktop.background picture-options 'zoom'

#printf "URL: $URL DEST: $DEST\n"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$DEST/$IMAGE"
gsettings set org.gnome.desktop.background picture-uri "file://$DEST/$IMAGE"

