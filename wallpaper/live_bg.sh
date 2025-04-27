#/bin/bash

NAME="live"

IMG_EXT="jpg"
VID_EXT="mp4"
AUTOSTART_FILE="autoplay.desktop"

dest="/home/$USER/.local/share/backgrounds"
RAW="https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/wallpaper"
folder="live"

IMAGE="$NAME.$IMG_EXT"
VIDEO="$NAME.$VID_EXT"

IMAGE_DEST="$DEST/$IMAGE"
VIDEO_DEST="$DEST/$VIDEO"

IMG_URL="$RAW"/"$FOLDER"/"$IMAGE"
VID_URL="$RAW"/"$FOLDER"/"$VIDEO"
AUTOSTART_URL="$RAW"/"$AUTOSTART_FILE"

curl -s "$IMG_URL" -o "$IMAGE_DEST"
curl -s "$VID_URL" -o "$VIDEO_DEST"
curl -s "$AUTOSTART_URL" -i "$HOME"/.config/autostart/"$AUTOSTART_FILE"

# Set image
gsettings set org.gnome.desktop.background color-shading-type 'solid'
gsettings set org.gnome.desktop.background picture-options 'zoom'

gsettings set org.gnome.desktop.background picture-uri-dark "file://$IMAGE_DEST"
gsettings set org.gnome.desktop.background picture-uri "file://$IMAGE_DEST"

# Start video

xwinwrap -fs -fdt -ni -b -nf -un -o 1.0 -- cvlc --no-video-title-show --drawable-xid WID --loop --no-audio "$VIDEO_DEST"
