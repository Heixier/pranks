#/bin/bash

DEST="/home/$USER/.local/share/backgrounds/prank.jpeg"
RAW="https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/wallpaper"
FOLDER="anime_C"

URL="$RAW"/"$FOLDER"/"$(shuf -i 0-4 -n 1).png"

#if ! [ -f $DEST ]; then
#	curl -s $URL -o "$DEST"
#fi

#gsettings set org.gnome.desktop.background picture-uri-dark "file://$DEST"

printf "RANDOM URL: $URL\n"
