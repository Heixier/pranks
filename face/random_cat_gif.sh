#!/bin/bash

if [ -f ~/.face ]; then
	mv ~/.face ~/.face.bak
fi

curl -o ~/.face https://www.icegif.com/wp-content/uploads/meme-icegif-2.gif

