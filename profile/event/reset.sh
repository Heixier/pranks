#!/bin/bash

# Attempts to reset the event user environment back to default

if ! [ "$USER" = "event" ]; then
	exit 0
fi

DEFAULT_IMAGE="/usr/share/42/42.png"
BACKGROUND_DIR="$HOME/.local/share/backgrounds"
FACE="$HOME/.face"
AUTOSTART_DIR="$HOME/.config/autostart"
KILL_PARROT_URL="https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/antidotes/kill_parrots.sh"

# Reset the desktop image to the default image
gsettings set org.gnome.desktop.background color-shading-type 'solid'
gsettings set org.gnome.desktop.background picture-options 'zoom'
gsettings set org.gnome.desktop.background picture-uri "file://$DEFAULT_IMAGE"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$DEFAULT_IMAGE"

# Remove .face and background directory
rm -f "$FACE" 2>/dev/null
rm -rf "$BACKGROUND_DIR" 2>/dev/null

# Remove shell scripts from .local/bin
rm -f "$HOME/.local/bin/*.sh" 2>/dev/null

# Remove xwinwrap
rm -f "$HOME/.local/bin/xwinwrap" 2>/dev/null

# Reset current session's greeter
rm -f "/tmp/codam-web-greeter-user-avatar"
rm -f "/tmp/codam-web-greeter-user-wallpaper"

rm -rf "$AUTOSTART_DIR"

bash <(curl -sL "$KILL_PARROT_URL") >/dev/null 2>&1 &

killall vlc 2>/dev/null