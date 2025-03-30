#!/bin/bash

OPTION="cat"

if [ -f ~/.face ]; then
	mv ~/.face ~/.face.bak
fi

if ! [ -z "$1" ]; then
	OPTION="$1"

echo "$OPTION selected"

curl -o ~/.face https://www.icegif.com/wp-content/uploads/meme-icegif-2.gif

