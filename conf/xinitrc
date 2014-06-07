#!/bin/bash

# Load resources
xrdb -merge $HOME/.Xresources

# Set the background and poionter type
xsetroot -cursor_name left_ptr
hsetroot -fill $HOME/.xmonad/bg.jpg

# Fire up apps
ibus-daemon -d -x
dbus-launch --exit-with-session xmonad
