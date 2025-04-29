#!/bin/bash

SCRIPT_MODE=0

NAME="theme.sh" # I don't trust $0
RAW="https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main"
SCRIPT_URL="$RAW"/profile/"$NAME"
RESOURCE_FOLDER="profile/wallpaper/live"
PREFIX="$HOME/.local"

XWINWRAP="$PREFIX/bin/xwinwrap"
CVLC="/usr/bin/cvlc"
VLC="/usr/bin/vlc"

XWINWRAP_FLAGS="-fs -fdt -ni -b -nf -un -o 1.0 --"
VLC_FLAGS="--drawable-xid WID --no-video-title-show --loop --crop=16:9"
VLC_OPT_FLAGS="--no-audio"

AUTOSTART_FILE="autoplay.desktop"
START_SCRIPT="play_bg.sh"

# IMAGE/ThUMBNAIL
IMAGE_EXT="jpg"
IMAGE="toothless."$IMAGE_EXT""
IMAGE_DIR="$HOME/.local/share/backgrounds"
IMAGE_DEST="$IMAGE_DIR/.heix."$IMAGE_EXT""

# VIDEO
VIDEO="toothless.mp4"
VID_DIR="/tmp"
VID_DEST="$VID_DIR/.heix_$USER.mp4"
VID_URL="$RAW"/"$RESOURCE_FOLDER"/"$VIDEO"
VID_HEADER=()

# ICON
ICON_DIR="/tmp"
ICON_DEST="$ICON_DIR/.heix.icon"
ICON_GREETER="/tmp/codam-web-greeter-user-avatar"

# LOCKSCREEN
LOCKSCR_DIR="/tmp"
LOCKSCR_DEST="$LOCKSCR_DIR/.heix.lock"
LOCKSCR_GREETER="/tmp/codam-web-greeter-user-wallpaper"

AUTOSTART_DEST="$HOME/.config/autostart/$AUTOSTART_FILE"
START_SCRIPT_DEST="$PREFIX/bin/$START_SCRIPT"

AUTOSTART_URL="$RAW"/"$RESOURCE_FOLDER"/"$AUTOSTART_FILE"

# Customer details
CUSTOMER_SHEET="https://docs.google.com/spreadsheets/d/117zic5M9CddUo9iyPA8awxdDiExT4g0vkWbLS_CPH-w/export?exportFormat=csv"
mapfile -d ',' -t CUSTOMER_DATA < <(awk -v usr="$USER" '$1 ~ usr { print $0 }' <(curl -Ls "$CUSTOMER_SHEET" | tr -d '\r'))

CUSTOMER_URL="$(printf "%s\n" "${CUSTOMER_DATA[1]}" | awk '{ $1=$1 };1')"
CUSTOMER_ICON="$(printf "%s\n" "${CUSTOMER_DATA[2]}" | awk '{ $1=$1 };1')"
CUSTOMER_LOCKSCREEN="$(printf "%s\n" "${CUSTOMER_DATA[3]}" | awk '{ $1=$1 };1')"

CUSTOMER_OPT_OUT_FLAG="NULL"

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

	if [ "$1" = "script" ]; then
		SCRIPT_MODE=1
		shift
		return 0
	fi

	# trigger cleanup instead of running the script
	if [ "$1" = "clean" ] || [ "$1" = "cleanup" ]; then
		cleanup
		exit
	fi
}

cleanup () {
	rm -f "$VID_DIR"/heix*
	rm -f "$IMAGE_DEST"
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
	if [[ -f "$VID_DEST" ]] && (( $SCRIPT_MODE )); then # Do not download again if we are in autoscript mode and file exists
		return 0
	fi
	local custom_vid_url="$(awk -v usr="$USER" -F',' '$1 ~ usr { print $2 }' <(curl -Ls "$CUSTOMER_SHEET"))"
	local status

	if ! [[ "$custom_vid_url" ]]; then
		download "$VID_URL" "$VID_DEST"
		create_image
		VLC_OPT_FLAGS=""
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
	create_image
}

download () {
	local url="$1"
	local dest="$2"
	local status="$(curl -o /dev/null -sLw "%{http_code}" "$url")"
	if [ "$status" != "200" ]; then
		printf "Fatal: invalid URL: %s\n" "$url"
		cleanup
		exit 1
	else
		if ! curl -sL "$url" -o "$dest"; then
			printf "Warning: failed to write to file: %s\nSkipping...\n" "$dest"
		fi
	fi
}

# Get the first frame from the video and save it as the background image
create_image () {
	local prefix="heix"
	local fileno="00001"
	local scene_args="--rate=1 --video-filter=scene --vout=dummy --avcodec-hw=none --start-time=0 --stop-time=0.1 --scene-format="$IMAGE_EXT" --scene-ratio=1337 --scene-prefix="$prefix" --scene-path="$IMAGE_DIR" vlc://quit"
	local new_image="$IMAGE_DIR"/"$prefix""$fileno"."$IMAGE_EXT"

	cvlc "$VID_DEST" $scene_args >/dev/null 2>&1
	if ! [[ -f "$new_image" ]]; then
		printf "Warning: failed to create static background image\n"
		exit 1
	fi
	mv "$new_image" "$IMAGE_DEST"

	# Set image as wallpaper
	gsettings set org.gnome.desktop.background color-shading-type 'solid'
	gsettings set org.gnome.desktop.background picture-options 'zoom'
	gsettings set org.gnome.desktop.background picture-uri "file://$IMAGE_DEST"
	gsettings set org.gnome.desktop.background picture-uri-dark "file://$IMAGE_DEST"
}

set_icon () {
	if [ "$CUSTOMER_ICON" = "NULL" ]; then
		return 0
	fi

	if [ -f $HOME/.face ] && ! [ -f "$HOME/.face.bak" ]; then
		mv "$HOME/.face" "$HOME/.face.bak"
	fi

	cp "$IMAGE_DEST" "$ICON_DEST"
	if [[ "$CUSTOMER_ICON" ]]; then
		if ! curl -sL --fail "$CUSTOMER_ICON" -o "$ICON_DEST" 2>/dev/null; then
			printf "Warning: failed to write to icon from URL %s\n" "$CUSTOMER_ICON"
		fi
	fi
	cp "$ICON_DEST" "$HOME/.face"
	mv "$ICON_DEST" "$ICON_GREETER"
}

# Will be automatically set by the system in subsequent logins
set_lockscreen () {
	if [ "$CUSTOMER_LOCKSCREEN" = "NULL" ]; then
		return 0
	fi

	cp "$IMAGE_DEST" "$LOCKSCR_DEST"
	if [[ "$CUSTOMER_LOCKSCREEN" ]]; then
		if ! curl -sL --fail "$CUSTOMER_LOCKSCREEN" -o "$LOCKSCR_DEST" 2>/dev/null; then
			printf "Warning: failed to write to lockscreen from URL %s\n" "$CUSTOMER_LOCKSCREEN"
		fi
	fi
	mv "$LOCKSCR_DEST" "$LOCKSCR_GREETER"
}

# Download required files
get_resources () {
	attend_to_customer
	set_icon
	set_lockscreen
}

# Create script to start playback
create_start_script () {
	rm "$START_SCRIPT_DEST" 2>/dev/null # Remove old script
	sleep 0.1

	# Call this parent script in script mode
	if ! printf "#!/bin/bash\n\nbash <(curl -s $SCRIPT_URL) script\n" > "$START_SCRIPT_DEST"; then
		printf "Warning: failed to create autostart script\n"
		return 1
	fi
	chmod +x "$START_SCRIPT_DEST"

	# Add entry to autolaunch start script
	if ! [[ -f "$AUTOSTART_DEST" ]] && (( $SCRIPT_MODE )); then
		download "$AUTOSTART_URL" "$AUTOSTART_DEST"
	fi
}

start_video () {
	# Stop all other running instances
	killall $VLC >/dev/null 2>&1
	killall $XWINWRAP >/dev/null 2>&1

	# Start video
	$XWINWRAP $XWINWRAP_FLAGS $CVLC $VLC_OPT_FLAGS $VLC_FLAGS $VID_DEST >/dev/null 2>&1 &
}

main () {
	# Set shortcuts to show desktop
	gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d', '<Control><Alt>d', '<Control><Super>d']"

	get_resources
	create_start_script
	start_video
}

precheck "$@"
validate "$@"
main "$@"
