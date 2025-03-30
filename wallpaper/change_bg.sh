#!/bin/bash

DEST="/home/$USER/.local/share/backgrounds/alligot.png"

if ! [ -f $DEST ]; then
	curl -s "https://i.imgur.com/Elxs4.png" -o "$DEST"
fi

gsettings set org.gnome.desktop.background picture-uri-dark "file://$DEST"

