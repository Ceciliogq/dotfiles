# dotfiles
Gather useful dotfiles for easy setup in multiple machines

## First time

To use these dotfiles in a new machine:
 1. Clone this repository under `$HOME/git`
 2. Create symbolic links in the home directory<br/>
    It can be done with `bash make-symlinks.sh`<br/>
    It will use a defaul list if no arguments are passed<br/>
    Run for specific dotfiles with `bash make-symlinks.sh vimrc bash_aliases` (file name without ".")
 3. Remember to do `source ~/.bashrc` to bring the changes to the current shell

## Next times

Whenever there is an update in the dotfiles, just refresh repo with `git pull` and changes will be updated automatically.

**Note**: if different versions are required for different machines, create branches for each machine and follow the previous steps.
