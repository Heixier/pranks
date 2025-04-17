# Introduction
These are scripts that written for 42 Singapore's Dell Optiplex 7400 computers. They work at the moment, but major system updates may impact functionality in future.  

These scripts are written for entertainment purposes only and are thus highly important and valuable.

# How To Use
## menu.sh
This is the main script used to run each module, using this is highly recommended as it allows for multiple modules to be run at once.

    source <(curl -s https://github.com/Heixier/pranks/blob/main/menu.sh)

## Running individual modules

When called without arguments, the script will launch with a short input window. If no modules are input within the window, the script will use the default set of modules.

The script accepts either an index or a module name as input. If an input is received, it will proceed to try and run it. It will intentionally fail silently if it cannot find the module (to confuse regular users).

<details><summary>But if you really want to know...</summary>

You can access the list of modules by using the `debug` argument
</details>

## Running multiple modules

This requires passing in arguments into the script, which will require editing the link.

	source <(curl -s https://github.com/Heixier/pranks/blob/main/menu.sh option1 option2 option3 etc.)
Entering multiple arguments during the short input window presents a high risk of accidentally running an unwanted module, hence this mode requires explicit argument input.

# Modules

0. Default (whatever I feel like setting it to
1. wallpaper
2. profile
3. parrot
4. sandstorm
5. lockout
6. flashbang
7. matrix

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

### Note
Replaced files will be stored in a .bak copy because I'm nice

