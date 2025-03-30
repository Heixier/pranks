#!/bin/bash

OPTION="cat"

if [ -f ~/.face ]; then
	mv ~/.face ~/.face.bak
fi

if ! [ -z "$1" ]; then
	OPTION="$1"
fi

echo "$OPTION selected"

case "$OPTION" in
	"cat")
		echo "meow";;
	"anime")
		echo "nya";;
	*)
		echo "idk";;
esac

curl -o ~/.face https://www.icegif.com/wp-content/uploads/meme-icegif-2.gif

