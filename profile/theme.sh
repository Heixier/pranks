#!/bin/bash

RAW="https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main"
RESOURCE_FOLDER="profile/wallpaper/live"
PREFIX="$HOME/.local"

XWINWRAP="$PREFIX/bin/xwinwrap"
CVLC="/usr/bin/cvlc"
VLC="/usr/bin/vlc"

XWINWRAP_FLAGS="-fs -fdt -ni -b -nf -un -o 1.0 --"
VLC_FLAGS="--drawable-xid WID --no-video-title-show --loop --no-audio --crop=16:9"

AUTOSTART_FILE="autoplay.desktop"
START_SCRIPT="play_bg.sh"

# IMAGE
IMAGE_EXT="jpg"
IMAGE="toothless."$IMAGE_EXT""
IMAGE_DIR="$HOME/.local/share/backgrounds"
IMAGE_DEST="$IMAGE_DIR/.heix."$IMAGE_EXT""

# VIDEO
VIDEO="toothless.mp4"
VID_DIR="/tmp"
VID_DEST="$VID_DIR/.heix.mp4"
VID_URL="$RAW"/"$RESOURCE_FOLDER"/"$VIDEO"
VID_HEADER=()
THUMBNAIL

# ICON
ICON_DEST="$HOME/.face"

# CODAM
CODAM_ICON="/tmp/codam-web-greeter-user-avatar"
CODAM_LOCK="/tmp/codam-web-greeter-user-background"

AUTOSTART_DEST="$HOME/.config/autostart/$AUTOSTART_FILE"
START_SCRIPT_DEST="$PREFIX/bin/$START_SCRIPT"

AUTOSTART_URL="$RAW"/"$RESOURCE_FOLDER"/"$AUTOSTART_FILE"

# Customer details
CUSTOMER_SHEET="https://docs.google.com/spreadsheets/d/117zic5M9CddUo9iyPA8awxdDiExT4g0vkWbLS_CPH-w/export?exportFormat=csv"
mapfile -d ',' -t CUSTOMER_DATA < <(awk -v usr="$USER" '$1 ~ usr { print $0 }' <(curl -Ls "$CUSTOMER_SHEET" | tr -d '\r'))

CUSTOMER_URL="${CUSTOMER_DATA[1]}"
CUSTOMER_ICON="${CUSTOMER_DATA[2]}"
CUSTOMER_LOCKSCREEN="${CUSTOMER_DATA[2]}"

printf "Customer_URL: %s\n" "$CUSTOMER_URL"

for data in "${CUSTOMER_DATA[@]}"
do
	data="$(printf "$data" | awk '{ $1=$1 };1')"
	if [[ "$data" ]]; then
		printf "Data: %s\n" "$data"
	else
		printf "no data found\n"
	fi
done
exit

# Don't mess up my custom config
precheck () {
	if [ "$USER" = "rsiah" ]; then
		if ! [ "$1" = "force" ]; then
			printf "oops\n"
			exit 0
		else
			printf "Overriding! May mess up configs!\n"
			shift
		fi
	fi

	# trigger cleanup instead of running the script
	if [ "$1" = "clean" ] || [ "$1" = "cleanup" ]; then
		cleanup
		exit
	fi
}

cleanup () {
	rm -f "$IMAGE_DEST"
	rm -f "$VID_DEST"
	rm -f "$AUTOSTART_DEST"
	rm -f "$START_SCRIPT_DEST"
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

validate () {
	
	# Create destination directory if it doesn't exist
	if ! [ -d "$IMAGE_DIR" ]; then
		mkdir -p "$IMAGE_DIR"
	fi

	# Validates installations
	if ! command -v "$CVLC" >/dev/null; then
		printf "Fatal: %s not found. Aborting...\n" "$CVLC"
		cleanup
		exit
	fi

	if ! command -v "$XWINWRAP" >/dev/null; then
		install_xwinwrap
	fi
}

# Helps customers install their custom video file instead of the default
attend_to_customer () {
	local custom_vid_url="$(awk -v usr="$USER" -F',' '$1 ~ usr { print $2 }' <(curl -Ls "$CUSTOMER_SHEET"))"
	local status

	if ! [[ "$custom_vid_url" ]]; then
		download "$VID_URL" "$VID_DEST"
		printf "Debug: %s is not a customer!\n" "$USER"
		return 0
	fi

	if [[ "$custom_vid_url" == *"moewalls.com"* ]]; then
		VID_HEADER+=("-H" "Referer: https://moewalls.com")
	fi

	if ! curl -sL --fail "$custom_vid_url" "${VID_HEADER[@]}" -o "$VID_DEST" 2>/dev/null; then
		printf "Fatal: invalid URL: %s\n" "$custom_vid_url"
		cleanup
		exit 1
	fi
}

download () {
	local url="$1"
	local status="$(curl -o /dev/null -sLw "%{http_code}" "$url")"
	if [ "$status" != "200" ]; then
		printf "Fatal: invalid URL: %s\n" "$url"
		cleanup
		exit 1
	else
		if ! curl -sL "$1" -o "$2"; then
			printf "Warning: failed to write to file: %s\nSkipping...\n" "$2"
		fi
	fi
}

# Get the first frame from the video and save it as the background image
create_image () {
	local prefix="heix"
	local fileno="00001"
	local scene_args="--rate=1 --video-filter=scene --vout=dummy --avcodec-hw=none --start-time=0 --stop-time=0.1 --scene-format="$IMAGE_EXT" --scene-ratio=1337 --scene-prefix="$prefix" --scene-path="$IMAGE_DIR" vlc://quit"
	THUMBNAIL="$IMAGE_DIR"/"$prefix""$fileno"."$IMAGE_EXT"

	cvlc "$VID_DEST" $scene_args >/dev/null 2>&1
	if ! [[ -f "$THUMBNAIL" ]]; then
		printf "Warning: failed to create static background image\n"
		exit 1 # I want the install to be perfect
	fi
	mv "$THUMBNAIL" "$IMAGE_DEST"

	# Set image as wallpaper
	gsettings set org.gnome.desktop.background color-shading-type 'solid'
	gsettings set org.gnome.desktop.background picture-options 'zoom'
	gsettings set org.gnome.desktop.background picture-uri "file://$IMAGE_DEST"
	gsettings set org.gnome.desktop.background picture-uri-dark "file://$IMAGE_DEST"
}

set_icon () {
	if [ -f "$ICON_DEST" ] && ! [ -f "$ICON_DEST.bak" ]; then
		mv "$ICON_DEST" "$ICON_DEST.bak"
	fi

	if [[ "$CUSTOMER_ICON" ]]; then
		if ! curl -sL --fail "$CUSTOMER_ICON" -o "$ICON_DEST" 2>/dev/null; then
			printf "Warning: failed to write icon from URL\n"
		else
			return 0
		fi
	fi
	cp "$THUMBNAIL" "$ICON_DEST"
	cp "$THUMBNAIL" "$CODAM_ICON"
}

# Will be automatically set by the system in subsequent logins
set_lockscreen () {
#	if [[ "$CUSTOMER_LOCK" ]]; then

}

main () {
	# Stop all other running instances
	killall -9 $VLC >/dev/null 2>&1
	killall -9 $XWINWRAP >/dev/null 2>&1

	# Download required files
	attend_to_customer
	create_image
	download "$AUTOSTART_URL" "$AUTOSTART_DEST"

	# Create script to start playback
	rm "$START_SCRIPT_DEST" 2>/dev/null
	sleep 0.1 # For some reason && did not work
	printf "#!/bin/bash\n\nkillall -9 $VLC >/dev/null 2>&1\nkillall -9 $XWINWRAP >/dev/null 2>&1\n$XWINWRAP $XWINWRAP_FLAGS $CVLC $VLC_FLAGS $VID_DEST >/dev/null 2>&1 &\n" > "$START_SCRIPT_DEST"

	chmod +x "$START_SCRIPT_DEST"

	# Set shortcut to show desktop (Windows ftw)
	gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d', '<Control><Alt>d', '<Control><Super>d']"

	# Start video
	$START_SCRIPT_DEST
}

precheck "$@"
validate "$@"
main "$@"
