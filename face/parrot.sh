#!/bin/bash

if [ -f .face ]; then
	mv .face .face.bak
	echo file found
fi

# curl -o .face https://i.redd.it/lklmn5fwu60c1.gif