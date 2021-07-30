old_dotfiles=$HOME/.old_dotfiles
new_dotfiles=$HOME/git/dotfiles

files="vimrc bash_aliases"

echo "Copying new dot files from $new_dotfiles"
for file in $files;
do
    if [ -f ~/.$file ]; then
        echo "Existing .$file detected, backup to $old_dotfiles..."
        mv ~/.$file $old_dotfiles
    fi
    echo "Creating symlink to $new_dotfiles/$file in home directory"
    ln -s $new_dotfiles/.$file $HOME/.$file
done
echo "Done"
