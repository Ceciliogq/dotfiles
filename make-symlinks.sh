#!/usr/bin/env bash

old_dotfiles=$HOME/.old_dotfiles
new_dotfiles=$HOME/git/dotfiles


files="vimrc bash_aliases bashrc"

if [ $# -eq 0 ]; then
    echo -e "No files supplied, using default list: $files \n"
else
    files="$@"
fi

echo -e "Taking new dot files from $new_dotfiles \n"
for file in $files;
do
    if [ -L $HOME/.$file ] || [ -f $HOME/.$file ] ; then
        echo "Existing .$file detected, backup to $old_dotfiles..."
        if ! [ -d $old_dotfiles ]; then
            mkdir $old_dotfiles
        fi
        mv $HOME/.$file $old_dotfiles
    fi
    echo "Creating symlink to $file in home directory"
    ln -s $new_dotfiles/.$file $HOME/.$file
    echo ""
done
echo "Done"
