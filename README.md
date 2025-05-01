# Introduction

These are scripts that written for 42 Singapore's Dell Optiplex 7400 computers on Ubuntu 22.04.5 LTS. Note: major system updates may impact future functionaity

These scripts are written for entertainment purposes only and are thus highly important and valuable.

# How To Use

## menu.sh

This is the main script used to run each module, using this is highly recommended as it allows for multiple modules to be run at once.

    bash <(curl -s https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/menu.sh)

## Running individual modules

When called without arguments, the script will launch with a short input window. If no modules are input within the window, the script will continue with the default set of modules.

The script accepts either an index or a module name as input. If an input is received, it will proceed to try and run it.

## Running multiple modules

In order to run multiple modules, the program needs to be run with multiple arguments which will require manually adding to the copy block

    bash <(curl -s https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/menu.sh) option1 option2 etc.

Entering multiple arguments during the short input window presents a high risk of accidentally running an unwanted module, hence this mode requires explicit argument input.

## Manual

Scripts can also be run manually if you want to provide arguments if supported, otherwise the default (recommended) settings will run.

bash <(curl -s https://raw.githubusercontent.com/Heixier/pranks/refs/heads/main/thescriptyouwant) optionshereifany

# Modules

Note: may be out of date

0. `default` (whatever I last set it to)
1. `wallpaper`
2. `theme`
3. `icon`
4. `reset_event`
5. `timebomb`
6. `hallosh`
7. `flashbang`
8. `matrix`
9. `reset_event`

# Profile

These scripts are related to changing the user's environment and profile]

## Wallpaper

Sets the user's wallpaper to something random.

## Theme

![toothless_demo](https://github.com/user-attachments/assets/e97ca49c-8675-4fb3-99cd-e369192e8f83)  
Example of an animated wallpaper

Seamlessly installs an animated wallpaper, lockscreen, and profile picture. Custom media files can be requested via the [Wallpaper Sheet](https://docs.google.com/spreadsheets/d/117zic5M9CddUo9iyPA8awxdDiExT4g0vkWbLS_CPH-w).

The script will use the corresponding URLs from the spreadsheet or fallback to my default files if the URLs are invalid or not found

Manual usage:

    bash <(curl -sL "bit.ly/42wall")

## Icon

Changes the user's profile picture to something random. Default option: `nya`

#### Manual options

- `nya`: random anime girl (sfw, default)
- `cat`: random cat gif
- `water`: Gravity Falls drinking water gif

# Misc.

Currently uncategorised scripts

## Parrot

Adds a parrot into the user's zsh and bash config

## Timebomb

Plays an audio track after a certain time (reconfigurable). If the event user is logged in, immediately log out after playing the track.

#### Manual options

Accepts a number as the timer duration

#### Note

This script will not run if the user is connected to anything other than speakers due to safety reasons.

## Hallosh

Runs the latest bash version in a new terminal  
![image](https://github.com/user-attachments/assets/724db011-8feb-42f4-9fad-1b4bde2bbe8d)

## Flashbang

May trigger epilepsy. Flashes the user's screen multiple times.

## Matrix

Installs and runs ascii-matrix

## Reset event

Resets the environment for the `event` user (it's just a cleanup script)

### Note

Replaced files will be stored in a .bak file of the same name
