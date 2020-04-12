#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
for DOTFILE_IN_DIR in $DIR/home/* 
do
	DOTFILE=$(basename $DOTFILE_IN_DIR)
	DOTFILE_IN_HOME="$HOME/.$DOTFILE"
	echo "LINKING $DOTFILE_IN_DIR -> $DOTFILE_IN_HOME"
	ln -s  $DOTFILE_IN_DIR $DOTFILE_IN_HOME 
done
