#!/bin/bash

# Adds parrot animation to shell config files

# Touches the files first in case to prevent file not found error
touch ~/.zshrc
touch ~/.bashrc

if ! ( cat ~/.zshrc | grep -q "^curl parrot.live" )
then
	echo "curl parrot.live" >> ~/.zshrc
fi

if ! ( cat ~/.bashrc | grep -q "^curl parrot.live" )
then
	echo "curl parrot.live" >> ~/.bashrc
fi
