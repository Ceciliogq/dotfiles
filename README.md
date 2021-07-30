# dotfiles
Gather useful dotfiles for easy setup in multiple machines

## First time

To use these dotfiles in a new machine:
 1. clone this repository under `$HOME/git`
 2. Create symbolic links in the home directory.
    Can be done with `bash make-symlinks.sh`
    It will use a defaul list if no arguments are passed.
    Run for specific dotfiles with `bash make-symlinks.sh vimr bash_aliases` 

## Next times

Whenever there is an update in the dotfiles, just refresh repo with `git pull` and changes will be updated automatically.
