#/bin/bash

DEST="/home/$USER/.local/share/backgrounds/prank.jpeg"

if ! [ -f $DEST ]; then
	curl -s "https://i.imgur.com/JBJPR.jpeg" -o "$DEST"
fi

gsettings set org.gnome.desktop.background picture-uri-dark "file://$DEST"

