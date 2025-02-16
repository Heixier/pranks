#!/bin/bash

# unmute
pactl set-sink-mute 0 0
pactl set-sink-volume 0 150%

set -o ignoreeof

NEWLINE=$'\n'

function command_not_found_handler() {
  printf "oi don't anyhow type commands la\n#\n"
  return 127
}

exec 2>/dev/null

export PS1="You are in a room with many doors, all alike${NEWLINE}# "

# text base adventure
alias cd='printf "where u trying to go bro\n#\n"'
alias pwd="echo You are lost, have you try the exit ${NEWLINE}#"
alias ls="echo It is too dark to see anything ${NEWLINE}#"
alias tree="echo The tree is blocking the way out ${NEWLINE}#"
alias cat="echo It is too dark to see anything ${NEWLINE}#"
alias clear="echo It is too foggy to see anything ${NEWLINE}#"
alias type="echo What is done, is done ${NEWLINE}#"

alias chmod="echo You are not powerful enough ${NEWLINE}#"
alias chown="echo You are not powerful enough ${NEWLINE}#"
alias unzip="echo You are weak ${NEWLINE}#"
alias tar="echo You are weak ${NEWLINE}#"

alias env="echo What you have is all you will get ${NEWLINE}#"

alias mkdir="echo There is no more room ${NEWLINE}#"
alias touch="echo There is no more room ${NEWLINE}#"

alias git="echo Point of no return ${NEWLINE}#"
alias man="echo The door remained shut ${NEWLINE}#"
alias make="echo Do you want to meet your maker? ${NEWLINE}#"

alias whoami="yes $USER"
alias uname="echo UnicornOS 4.2.0 ${NEWLINE}#"

alias lsof="echo You lack the knowledge ${NEWLINE}#"

alias history="echo You have forgotten your past ${NEWLINE}#"

alias cp="echo You cannot make two from one ${NEWLINE}#"
alias mv="echo You are facing an immovable object ${NEWLINE}#"

alias groups="echo You are alone ${NEWLINE}#"

alias sudo="echo You are weak ${NEWLINE}#"

alias cc="xdg-open 'https://www.youtube.com/watch?v=oHg5SJYRHA0?autoplay=1'"
alias gcc="xdg-open 'https://www.youtube.com/watch?v=oHg5SJYRHA0?autoplay=1'"
alias clang="xdg-open 'https://www.youtube.com/watch?v=oHg5SJYRHA0?autoplay=1'"

alias code="nano"
alias vim="nano"
alias vi="nano"
alias nano="emacs -nw"

# boo :)
alias exit="gnome-session-quit --no-prompt"

alias unalias="echo That which is done cannot be undone ${NEWLINE}#"
alias alias="echo The name you started with is good enough ${NEWLINE}#"
