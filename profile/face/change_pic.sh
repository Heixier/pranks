#!/bin/bash

DEST=~/.face
TEMP_DEST=/tmp/codam-web-greeter-user-avatar # update for the current session

if [ -f ~/.face ] && ! [ -f ~/.face.bak ]; then
	mv ~/.face ~/.face.bak
fi

URL=$(curl -s https://nekos.best/api/v2/neko | jq -r '.results[0].url')

case "$1" in
	"cat")
		URL=$(curl -s -L http://edgecats.net/random)
		;;
	"nya")
		URL=$(curl -s https://nekos.best/api/v2/neko | jq -r '.results[0].url')
		;;
	"water")
		URL="https://www.icegif.com/wp-content/uploads/meme-icegif-2.gif"
		;;
	*)
		;;
esac

curl -s -o $DEST "$URL"
cp $DEST $TEMP_DEST
