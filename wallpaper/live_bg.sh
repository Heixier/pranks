#/bin/bash

NAME="live"

IMG_EXT="jpg"
VID_EXT="mp4"
AUTOSTART_FILE="autoplay.desktop"
START_SCRIPT="play_bg.sh"

DEST="/home/$USER/.local/share/backgrounds"
RAW="https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/wallpaper"
FOLDER="live"

IMAGE="$NAME.$IMG_EXT"
VIDEO="$NAME.$VID_EXT"

IMAGE_DEST="$DEST/$IMAGE"
VIDEO_DEST="$DEST/$VIDEO"

IMG_URL="$RAW"/"$FOLDER"/"$IMAGE"
VID_URL="$RAW"/"$FOLDER"/"$VIDEO"
AUTOSTART_URL="$RAW"/"$FOLDER"/"$AUTOSTART_FILE"
START_SCRIPT_URL="$RAW"/"$FOLDER"/"$START_SCRIPT"

printf "Curling: Image: %s\nVideo: %s\nAuto: %s\n" "$IMG_URL" "$VID_URL" "$AUTOSTART_URL"

curl -s "$IMG_URL" -o "$IMAGE_DEST"
curl -s "$VID_URL" -o "$VIDEO_DEST"
curl -s "$AUTOSTART_URL" -o "$HOME"/.config/autostart/"$AUTOSTART_FILE"
curl -s "$START_SCRIPT_URL" -o "$HOME"/.local/bin/"$START_SCRIPT"

# Set image
printf "Set image to %s\n" "$IMAGE_DEST"
gsettings set org.gnome.desktop.background color-shading-type 'solid'
gsettings set org.gnome.desktop.background picture-options 'zoom'

gsettings set org.gnome.desktop.background picture-uri-dark "file://$IMAGE_DEST"
gsettings set org.gnome.desktop.background picture-uri "file://$IMAGE_DEST"

# Start video

# First checks if xwinwrap is installed, if not install it 

# use command -v

printf "Trying to start video from %s\n" "$VIDEO_DEST"
$HOME/.local/bin/xwinwrap -fs -fdt -ni -b -nf -un -o 1.0 -- /usr/bin/cvlc --no-video-title-show --drawable-xid WID --loop --no-audio "$VIDEO_DEST"
