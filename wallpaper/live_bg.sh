#/bin/bash

# Run this script with "install" to install the required files, otherwise it just launches

NAME="toothless"
FOLDER="live"

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
START_SCRIPT_DEST="$HOME/.local/bin/$START_SCRIPT"

IMG_URL="$RAW"/"$FOLDER"/"$IMAGE"
VID_URL="$RAW"/"$FOLDER"/"$VIDEO"
AUTOSTART_URL="$RAW"/"$FOLDER"/"$AUTOSTART_FILE"

cleanup () {
	rm -f "$IMAGE_DEST"
	rm -f "$VIDEO_DEST"
	rm -f "$AUTOSTART_DEST"
	rm -f "$START_SCRIPT_DEST"
}

download () {
	local status="$(curl -o /dev/null -sLw "%{http_code}" "$1")"
	if [ "$status" != "200" ]; then
		printf "Invalid URL! %s\nAborting...\n" "$1"
		exit 1
	else
		curl -s "$1" -o "$2"
	fi
}

trap cleanup EXIT

if [ "$1" = "install" ]; then
	download "$IMG_URL" "$IMAGE_DEST"
	download "$VID_URL" "$VIDEO_DEST"
	download "$AUTOSTART_URL" "$AUTOSTART_DEST"

	# Create script to start playback

	echo "#!/bin/bash\n\n$HOME/.local/bin/xwinwrap -fs -fdt -ni -b -nf -un -o 1.0 -- /usr/bin/cvlc --no-video-title-show --drawable-xid WID --loop --no-audio $VIDEO_DEST" > "$START_SCRIPT_DEST"

	chmod +x "$AUTOSTART_DEST"
	chmod +x "$START_SCRIPT_DEST"

	# Set image
	gsettings set org.gnome.desktop.background color-shading-type 'solid'
	gsettings set org.gnome.desktop.background picture-options 'zoom'

	gsettings set org.gnome.desktop.background picture-uri-dark "file://$IMAGE_DEST"
	gsettings set org.gnome.desktop.background picture-uri "file://$IMAGE_DEST"
fi

# Perform checks



# Start video

# First checks if xwinwrap is installed, if not install it 

# Then check if the rest of the installs exist

# use command -v

printf "Trying to start video from %s\n" "$VIDEO_DEST"
$HOME/.local/bin/xwinwrap -fs -fdt -ni -b -nf -un -o 1.0 -- /usr/bin/cvlc --no-video-title-show --drawable-xid WID --loop --no-audio "$VIDEO_DEST"
