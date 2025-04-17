# Introduction
These are scripts that written for 42 Singapore's Dell Optiplex 7400 computers. Note: major system updates may impact future functionaity

These scripts are written for entertainment purposes only and are thus highly important and valuable.

# How To Use
## menu.sh
This is the main script used to run each module, using this is highly recommended as it allows for multiple modules to be run at once.

    source <(curl -s https://github.com/Heixier/pranks/blob/main/menu.sh)

## Running individual modules

When called without arguments, the script will launch with a short input window. If no modules are input within the window, the script will use the default set of modules.

The script accepts either an index or a module name as input. If an input is received, it will proceed to try and run it. It will intentionally fail silently if it cannot find the module (to confuse regular users).

## Running multiple modules

This requires passing in arguments into the script, which will require editing the link.

	source <(curl -s https://github.com/Heixier/pranks/blob/main/menu.sh option1 option2 option3 etc.)
Entering multiple arguments during the short input window presents a high risk of accidentally running an unwanted module, hence this mode requires explicit argument input.

## Manual
Scripts can also be run manually if you want to provide arguments if supported, otherwise the default (recommended) settings will run.

# Modules

0. default (whatever I feel like setting it to
1. wallpaper
2. profile
3. parrot
4. sandstorm
5. lockout
6. flashbang
7. matrix

## Wallpaper
Changes the user's wallpaper to something random.

## Profile
Changes the user's profile picture to something random. 
Optional arguments:

* `nya`: random anime girl (sfw, default)
* `cat`: random cat gif
* `water`: Gravity Falls drinking water gif

## Parrot
Curls a parrot into their terminal config files (curl parrot.live is down at the time of writing).

## Sandstorm
Blasts the user with some darude. This script can be run manually with an argument to delay the time the sound plays.

## Lockout
Opens a very helpful terminal window

## Flashbang
May cause epilepsy, flashes the user's screen multiple times.

## Matrix
Installs ascii-matrix for whatever reason

### Note
Replaced files will be stored in a .bak file of the same name

