#!/bin/bash

if ! [ "$USER" = "event" ]; then
	exit 0
fi

DEFAULT_IMAGE="/usr/share/42/42.png"
FACE="$HOME/.face"

gsettings set org.gnome.desktop.background picture-uri "file://$DEFAULT_IMAGE"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$DEFAULT_IMAGE"

rm -f "$FACE" 2>/dev/null