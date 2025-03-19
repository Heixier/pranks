#!/bin/bash

if [ -f .face ]; then
	mv .face .face.bak
fi

curl -o .face https://i.redd.it/lklmn5fwu60c1.gif
