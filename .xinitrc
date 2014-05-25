#!/bin/bash

# Load resources
xrdb -merge $HOME/.Xresources

# Set the background and poionter type
xsetroot -cursor_name left_ptr
hsetroot -fill $HOME/Pictures/1353056333875.jpg

# Fire up apps
ibus-daemon -d -x

exec xmonad
