#!/bin/bash

if [ -f .face ]; then
	mv .face .face.bak
fi

curl -o .face https://i.pinimg.com/736x/87/0b/5a/870b5af9af577cff6a82cd60774ced79.jpg