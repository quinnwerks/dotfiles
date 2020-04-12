#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
if [ -e $HOME/.config ]; then
    echo "FOUND CONFIG DIRECTORY: $HOME/.config"
else
    echo "CREATE CONFIG DIRECTORY: $HOME/.config"
    mkdir $HOME/.config
fi

for DOTFILE_IN_DIR in $DIR/config/*
do
	DOTFILE=$(basename $DOTFILE_IN_DIR)
	DOTFILE_IN_CONFIG="$HOME/.config/$DOTFILE"
	echo "LINKING $DOTFILE_IN_DIR -> $DOTFILE_IN_CONFIG"
	ln -s  $DOTFILE_IN_DIR $DOTFILE_IN_CONFIG
done
