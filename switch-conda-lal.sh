#!/usr/bin/env bash

# Script to switch between lal installations in a igwn-like conda environment.


# It will set some environment variables so in order to keep the changes it needs to be run with
# . /path/to/switch-conda-lal.sh or source /path/to/switch-conda-lal.sh
# Then it will ask for the name of the new-lal installation to be switched to.

# The result can be checked with the aliases check-lal, sys-path and by running e.g. python test_phenomX.py


# Set the old-lal installation to be replaced
if [[ -z "${LAL_PREFIX}" ]]; then
    old_lal=$CONDA_PREFIX/lalsuite-default  #if LAL_PREFIX not defined we want the default lal in conda
else
    old_lal=$LAL_PREFIX   # if we have previously sourced another lal
fi

# Input the new-lal installation to be switched by command line
if [ $# -eq 0 ]; then
   read -p "Enter NEW LAL installation (current is $LAL_PREFIX): " -e name
else
   name=$1
fi
new_lal=$CONDA_PREFIX/$name
# Check that the input new-lal exists, exiting otherwise
if ! [ -d $new_lal ]; then
    echo "Invalid path, $new_lal does not exist. Exit."
    return 0
fi


echo "new_lal = $new_lal"
echo "old_lal = $old_lal"

# Function to replace the current lal with new-lal and backup to old-lal if files are present in both installations
create-links-new-lal(){
    item=$1
    if [ -d $CONDA_PREFIX/$item ]; then
    # new-lal's folder exists in current, search recursively wich new-lal files are already in current
      	new_items=$(ls $new_lal/$item)
        local subfolder=$item
        if ! [ -d $old_lal/$item ]; then
            mkdir -p $old_lal/$item
        fi
        for new_item in $new_items
        do
            create-links-new-lal $subfolder/$new_item
        done
    elif [ -f $CONDA_PREFIX/$item ]; then
        # File from new-lal exists in current, backup to old-lal"
        if ! [ -f $old_lal/$item ] && ! [ -L $old_lal/$item ] ; then
           # backup to old-lal
           mv $CONDA_PREFIX/$item $old_lal/$item
        else
          # if it is already in old-lal, don't need to backup, remove
           rm $CONDA_PREFIX/$item
        fi
        # Creat symlink in current pointing to new-lal
        ln -s $new_lal/$item $CONDA_PREFIX/$item
    else
        # File or folder didn't exist, no need to backup. Create symlink in current pointing to new-lal
        ln -s $new_lal/$item $CONDA_PREFIX/$item
    fi
}

# Function to remove the files in current which are already backed up in old-lal
remove-old-lal-from-current(){
    item=$1
    if [ -d $CONDA_PREFIX/$item ]; then
        # Folder exists in current, search recursively wich files are already in old-lal
      	new_items=$(ls $old_lal/$item)
        local subfolder=$item
        for new_item in $new_items
        do
            remove-old-lal-from-current $subfolder/$new_item
        done
    elif [ -f $CONDA_PREFIX/$item ]; then
        # File exists in old and in current, removing
        rm $CONDA_PREFIX/$item
    fi
}

# Remove old-lal files from current which will not be used by new.
# Call to function remove-old-lal-from-current passing the old-lal path
echo -e "\nRemoving old-lal"
if [ -d $old_lal ] && [ "$(ls -A $old_lal)" ]; then
    # If backup folder exists and it is not empty,
    # then remove those files which are in current
    folders_to_check=$(ls $old_lal)
    #echo "folders_to_check = $folders_to_check"
    for folder in $folders_to_check
    do
        remove-old-lal-from-current $folder
    done
fi
echo -e "Done\nCreate symlinks to new-lal"

# Create symlinks in current pointing to new-lal
# Call to create-links-new-lal function passing the new-lal path
folders_to_check=$(ls $new_lal)
for folder in $folders_to_check
do
    create-links-new-lal $folder
done
echo -e "Done\n"

# Source the new-lal installation and set environment variables
echo "LAL_PREFIX before source: $LAL_PREFIX"
echo "PYTHONPATH before source: $PYTHONPATH"
echo -e "\nsource $new_lal/etc/lalsuite-user-env.sh\n"
files_to_source=$(ls $new_lal/etc/lal*-user-env.sh)
for file_to_source in $files_to_source;
do
   . $file_to_source
done

# Unset LAL_PREFIX and PYTHONPATH if the required new-lal is the default
# PYTHONPATH need to unset to have a cleaner sys-path, if not it would contain all the different lals
if [ $new_lal == $CONDA_PREFIX/lalsuite-default ]; then
    unset LAL_PREFIX
    unset PYTHONPATH
fi
echo "LAL_PREFIX after source: $LAL_PREFIX"
echo "PYTHONPATH after source: $PYTHONPATH"
