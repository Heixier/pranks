#!/bin/bash

if [ -f ~/.zshrc.bak ]; then
	rm ~/.zshrc.bak
fi;

if [ -f ~/.bashrc.bak ]; then
	rm ~/.bashrc.bak
fi;

if [ -f ~/.vimrc.bak ]; then
	rm ~/.vimrc.bak
fi;
