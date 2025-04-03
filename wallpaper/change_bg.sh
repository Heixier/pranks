#/bin/bash

DEST="/home/$USER/.local/share/backgrounds/prank.jpeg"
ROOT_URL="https://github.com/Heixier/pranks/tree/main/wallpaper"
FOLDER="anime_C"

URL="$ROOT_URL"/"$FOLDER"/"$(shuf -i 0-4 -n 1).png"

#if ! [ -f $DEST ]; then
#	curl -s $URL -o "$DEST"
#fi

#gsettings set org.gnome.desktop.background picture-uri-dark "file://$DEST"

printf "RANDOM URL: $URL\n"
