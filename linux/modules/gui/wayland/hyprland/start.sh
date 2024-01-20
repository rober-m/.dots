#!/usr/bin/env bash
 
# Initialize wallpaper deamon
swww init &
# Set wallpaper
swww img ~/.dots/wallpapers/4k-photo-mountain-afternoon.jpg &

# Initialize status bar
waybar &

# Add Network manager menu to status bar
nm-applet --indicator &

# Add notification daemon
dunst
