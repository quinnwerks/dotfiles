#!/bin/bash
FILE=.vimrc
REPO_DIR=~/dotfiles
if [ -f ~/$FILE ]; then
    OLD_FILE=${FILE}_old
    echo "File exists, moving it to $OLD_FILE"
    mv ~/$FILE ~/$OLD_FILE
    echo "Moving file from $REPO_DIR to $HOME"
    cp $REPO_DIR/$FILE ~/$FILE
else
    echo "No $FILE in the home directory"
    echo "Moving $FILE from $REPO_DIR to $HOME"
    cp $REPO_DIR/$FILE ~/$FILE
fi
