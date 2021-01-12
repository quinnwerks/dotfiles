#!/bin/sh

sudo apt-get update
sudo apt-get install -y \
    ghc ghc-prof ghc-doc \
    zsh \
    neovim \
    xmonad \
    xmobar \
    fonts-font-awesome \
    fonts-ibm-plex \
    feh \
    i3lock \
    libx11-dev \
    imagemagick \
    rofi \
    scrot

git clone https://github.com/quinnwerks/st.git ~/st
(cd ~/st/ && sudo make install)

git clone https://github.com/quinnwerks/xcolor.git ~/xcolor
(cd ~/xcolor && sudo ./install)



