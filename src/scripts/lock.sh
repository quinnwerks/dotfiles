#!/bin/bash
# @file: Configure lock screen. Uses i3lock.
# @author: Quinn Smith
# @data: April 9th, 2020

# @brief Get the horizontal screen dimention 
get_horizontal_screen_dims() {
    echo $(xdpyinfo | grep dimensions | cut -d\  -f7 | cut -dx -f1);
}

# @brief Lock the screen with input image. Blur the image before applying lock.
# @param[in] $1 The original lock screen image
lock_screen_with_blur() {
    local LOCK_IMAGE=$1;
    local TEMP_IMAGE="/tmp/lockscreen.png";
    DIMS=$(get_horizontal_screen_dims);
    convert -scale $DIMS $LOCK_IMAGE $TEMP_IMAGE;
    convert $TEMP_IMAGE -filter Gaussian -blur 0x8 $TEMP_IMAGE;
    i3lock --image=$TEMP_IMAGE;
}

lock_screen_with_blur $1

