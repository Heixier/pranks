#/bin/bash

# Run this script with "install" to install the required files, otherwise it just launches

# Don't mess up my custom config
if [ "$USER" = "rsiah" ]; then
	exit 0
fi

NAME="toothless"
FOLDER="live"
PREFIX="$HOME/.local"

XWINWRAP="$PREFIX/bin/xwinwrap"
CVLC="/usr/bin/cvlc"
VLC="/usr/bin/vlc"

IMG_EXT="jpg"
VID_EXT="mp4"
AUTOSTART_FILE="autoplay.desktop"
START_SCRIPT="play_bg.sh"

DEST="/home/$USER/.local/share/backgrounds"
RAW="https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/wallpaper"

IMAGE="$NAME.$IMG_EXT"
VIDEO="$NAME.$VID_EXT"

IMAGE_DEST="$DEST/$IMAGE"
VIDEO_DEST="$DEST/$VIDEO"
AUTOSTART_DEST="$HOME/.config/autostart/$AUTOSTART_FILE"
START_SCRIPT_DEST="$PREFIX/bin/$START_SCRIPT"

IMG_URL="$RAW"/"$FOLDER"/"$IMAGE"
VID_URL="$RAW"/"$FOLDER"/"$VIDEO"
AUTOSTART_URL="$RAW"/"$FOLDER"/"$AUTOSTART_FILE"

# Create destination directory if it doesn't exist
if ! [ -d "$DEST" ]; then
	mkdir -p "$DEST"
fi

cleanup () {
	rm -f "$IMAGE_DEST"
	rm -f "$VIDEO_DEST"
	rm -f "$AUTOSTART_DEST"
	rm -f "$START_SCRIPT_DEST"
}

download () {
	local status="$(curl -o /dev/null -sLw "%{http_code}" "$1")"
	if [ "$status" != "200" ]; then
		printf "Invalid URL: %s\nAborting...\n" "$1"
		cleanup
		exit 1
	else
		if ! curl -s "$1" -o "$2"; then
			printf "Failed to write to file: %s\nSkipping...\n" "$2"
		fi
	fi
}

install_xwinwrap () {
	local xwinwrap_url="https://github.com/mmhobi7/xwinwrap"
	local xwinwrap_src="/tmp/xwinwrap"
	git clone "$xwinwrap_url" "$xwinwrap_src"
	sed -i "s|prefix = .*|prefix = $HOME/.local|" "$xwinwrap_src/Makefile"
	make -C "$xwinwrap_src" &&
	make -C "$xwinwrap_src" install &&
	rm -rf "$xwinwrap_src"
	
	# Verify again
	if ! command -v "$PREFIX/bin/xwinwrap" >/dev/null; then
		printf "Fatal: xwinwrap: installation failed\n"
		cleanup
		exit
	fi
}

if [ "$1" = "install" ]; then
	download "$IMG_URL" "$IMAGE_DEST"
	download "$VID_URL" "$VIDEO_DEST"
	download "$AUTOSTART_URL" "$AUTOSTART_DEST"

	# Create script to start playback
	rm "$START_SCRIPT_DEST" 2>/dev/null
	printf "#!/bin/bash\n\nkillall -9 $VLC\nkillall -9 $XWINWRAP\n$PREFIX/bin/xwinwrap -fs -fdt -ni -b -nf -un -o 1.0 -- /usr/bin/cvlc --no-video-title-show --drawable-xid WID --loop --no-audio $VIDEO_DEST\n" > "$START_SCRIPT_DEST"

	chmod +x "$START_SCRIPT_DEST"

	# Set image
	gsettings set org.gnome.desktop.background color-shading-type 'solid'
	gsettings set org.gnome.desktop.background picture-options 'zoom'

	gsettings set org.gnome.desktop.background picture-uri-dark "file://$IMAGE_DEST"
	gsettings set org.gnome.desktop.background picture-uri "file://$IMAGE_DEST"

	# Set shortcut to show desktop (Windows ftw)
	gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d', '<Control><Alt>d', '<Control><Super>d']"
elif [ "$1" = "clean" ] || [ "$1" = "cleanup" ]; then
	cleanup
	exit
fi

# Perform checks



if ! command -v "$CVLC" >/dev/null; then
	printf "Fatal: %s not found. Aborting...\n" "$CVLC"
	cleanup
	exit
fi

if ! command -v "$XWINWRAP" >/dev/null; then
	install_xwinwrap
fi

# Start video

XWINWRAP_FLAGS="-fs -fdt -ni -b -nf -un -o 1.0 --"
VLC_FLAGS="--drawable-xid WID --no-video-title-show --loop --no-audio"

# Stop all other running vlc instances
killall -9 $VLC
killall -9 $XWINWRAP
$XWINWRAP $XWINWRAP_FLAGS $CVLC $VLC_FLAGS "$VIDEO_DEST"
