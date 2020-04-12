#!/bin/bash
# @file Configure lock screen. Uses i3lock. Lock screen is a blured image of the screen.
# @author Quinn Smith
# @data April 9th, 2020
# @dependencies cut, grep, i3lock-color, imagemagick, xdpyinfo, scrot

LOCK_IMAGE="/tmp/lockscreen.png"
scrot -o $LOCK_IMAGE 
convert $LOCK_IMAGE -filter Gaussian -blur 0x8 $LOCK_IMAGE;
i3lock --image=$LOCK_IMAGE;

