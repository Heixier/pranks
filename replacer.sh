#!/bin/bash

if [ -f ~/.zshrc ]; then
	cp ~/.zshrc ~/.zshrc.bak
fi;

if [ -f ~/.bashrc ]; then
	cp ~/.bashrc ~/.bashrc.bak
fi;

if [ -f ~/.vimrc ]; then
	cp ~/.vimrc ~/.vimrc.bak
fi;
