# Automated
If you want to run multiple scripts at once using one command

## Menu.sh
This is a main script I use for running any of the options. It utilises background processing to call multiple downloads simultaneously. The documentation for this script is incomplete, but most of the features should be intuitive enough.

    source <(curl -s https://github.com/Heixier/pranks/blob/main/menu.sh option)

### Note
Replaced files will be stored in a .bak copy because I'm nice

(These programs have only been tested on 42SG's Dell Optiplex 7400s with their specific user environments, I cannot guarantee they will work forever due to system updates)

# Manual
Alternatively, you can run each script manually

## Lockout Terminal
Launches a trapped terminal

    source <(curl -s https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/lockout/lockout.sh)

## Parrot
Squawk
	
	source <(curl -s https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/parrot/parrot.sh)

## Flashbang
Rapidly flashes the screen multiple times (epilepsy warning)

    bash <(curl -s https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/flashbang/flashbang.sh)

## Profile Picture

Optional arguments:

* nya: random anime girl (sfw, default)
* cat: random cat gif (may take a while)
* water: Gravity Falls drinking water gif
###
    bash <(curl -s https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/face/change_pic.sh)

## Wallpaper
Changes the wallpaper to definitely not anime girls

    bash <(curl -s https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/wallpaper/change_bg.sh)

## Matrix
Helps you install ascii-matrix for whatever reason

    bash <(curl -s https://github.com/Heixier/pranks/blob/main/menu.sh matrix)
    
## Darude
Sandstorm

    bash <(curl -s https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/audio/bg_play.sh)

# ASCII Animations
Collection of ASCII animations
* curl parrot.live
* ssh starwarstel.net

