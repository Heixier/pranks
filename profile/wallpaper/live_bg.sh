#!/bin/bash

# Run this script with "install" to install the required files, otherwise it just launches

# Don't mess up my custom config
if [ "$USER" = "rsiah" ]; then
	if ! [ "$1" = "force" ]; then
		exit 0
	else
		printf "WARNING: will most likely mess up config!\n"
		shift
	fi
fi

NAME="toothless"
FOLDER="live"
PREFIX="$HOME/.local"

XWINWRAP="$PREFIX/bin/xwinwrap"
CVLC="/usr/bin/cvlc"
VLC="/usr/bin/vlc"

XWINWRAP_FLAGS="-fs -fdt -ni -b -nf -un -o 1.0 --"
VLC_FLAGS="--drawable-xid WID --no-video-title-show --loop --no-audio --crop=16:9"

IMG_EXT="jpg"
VID_EXT="mp4"
AUTOSTART_FILE="autoplay.desktop"
START_SCRIPT="play_bg.sh"

DEST="$HOME/.local/share/backgrounds"
RAW="https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/profile/wallpaper"

IMAGE="$NAME.$IMG_EXT"
VIDEO="$NAME.$VID_EXT"
VID_HEADER=()

IMAGE_DEST="$DEST/$IMAGE"
# VIDEO_DEST="$DEST/$VIDEO" # Deprecated, now streams instead of downloading

AUTOSTART_DEST="$HOME/.config/autostart/$AUTOSTART_FILE"
START_SCRIPT_DEST="$PREFIX/bin/$START_SCRIPT"

# IMG_URL="$RAW"/"$FOLDER"/"$IMAGE" # Deprecated, now takes a screenshot with vlc instead
VID_URL="$RAW"/"$FOLDER"/"$VIDEO"

AUTOSTART_URL="$RAW"/"$FOLDER"/"$AUTOSTART_FILE"

CUSTOMER_SHEET="https://docs.google.com/spreadsheets/d/117zic5M9CddUo9iyPA8awxdDiExT4g0vkWbLS_CPH-w/export?exportFormat=csv"

# Create destination directory if it doesn't exist
if ! [ -d "$DEST" ]; then
	mkdir -p "$DEST"
fi

cleanup () {
	rm -f "$IMAGE_DEST"
	# rm -f "$VIDEO_DEST"
	rm -f "$AUTOSTART_DEST"
	rm -f "$START_SCRIPT_DEST"
}

# Changes vid url for customers
attend_to_customer () {
	local vid_url="$(awk -v usr="$USER" -F',' '$1 ~ usr { print $2 }' <(curl -Ls "$CUSTOMER_SHEET"))"
	local status

	if ! [[ "$vid_url" ]]; then
		printf "Debug: %s is not a customer!\n" "$USER"
		return 0
	fi

	if [[ "$vid_url" == *"moewalls.com"* ]]; then
		VID_HEADER+=("-H" "'Referer: https://moewalls.com'")
	fi

	status="$(curl -o /dev/null -sLw "%{http_code}" "$vid_url" "${VID_HEADER[@]}")"
	if [ "$status" != "200" ]; then
		printf "Invalid URL: %s\nAborting... %s\n" "$vid_url" "$status"
		cleanup
		exit 1
	else
		VID_URL="$vid_url"
	fi
}

download () {
	local url="$1"
	local status="$(curl -o /dev/null -sLw "%{http_code}" "$url")"
	if [ "$status" != "200" ]; then
		printf "Invalid URL: %s\nAborting...\n" "$1"
		cleanup
		exit 1
	else
		if ! curl -sL "$1" -o "$2"; then
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

if [ "$1" = "clean" ] || [ "$1" = "cleanup" ]; then
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

# Stop all other running instances
killall -9 $VLC >/dev/null 2>&1
killall -9 $XWINWRAP >/dev/null 2>&1

# Install

# download "$IMG_URL" "$IMAGE_DEST"
# download "$VID_URL" "$VIDEO_DEST"
attend_to_customer
download "$AUTOSTART_URL" "$AUTOSTART_DEST"

# Create script to start playback
rm "$START_SCRIPT_DEST" 2>/dev/null
sleep 0.1 # For some reason && did not work
printf "#!/bin/bash\n\nkillall -9 $VLC >/dev/null 2>&1\nkillall -9 $XWINWRAP >/dev/null 2>&1\n$XWINWRAP $XWINWRAP_FLAGS $CVLC $VLC_FLAGS <(curl -sL \"$VID_URL\" ${VID_HEADER[*]}) >/dev/null 2>&1 &\n" > "$START_SCRIPT_DEST"

chmod +x "$START_SCRIPT_DEST"

# Set image
gsettings set org.gnome.desktop.background color-shading-type 'solid'
gsettings set org.gnome.desktop.background picture-options 'zoom'

gsettings set org.gnome.desktop.background picture-uri-dark "file://$IMAGE_DEST"
gsettings set org.gnome.desktop.background picture-uri "file://$IMAGE_DEST"

# Set shortcut to show desktop (Windows ftw)
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d', '<Control><Alt>d', '<Control><Super>d']"

# Start video
$START_SCRIPT_DEST
