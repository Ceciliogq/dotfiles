#!/usr/bin/env bash

# Script to add/modify environment variables in a conda environment

# This scripts sets environment variables that are specific for a conda environment.
# If the variables already exist they remain unaltered once the environment is deactivated.
# E.g. modify PATH only when the environment is active and get back the original PATH when deactivated.

# Needs to be run with . set-variables-conda-env.sh or source set-variables-conda-env.sh.
# We can only 'retur' from a function or sourced script, cannot do bash set-variables-conda-env.sh


# Check that there is a conda environment active
if [[ -z "${CONDA_PREFIX}" ]]; then
    echo "First you need to activate a conda environment. Exiting."
    return 0
fi

# Ask for the variable to be set/modify
if [ $# -eq 0 ]; then
   read -p "Enter variable name (e.g. PATH): " -e variable_name
   read -p "Enter variable value (e.g. /new/path. If exists, it will be prepended): " -e variable_value
else
  variable=$@
fi

# Define the folders and files that need to be modify as in https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#macos-and-linux
active_dir=$CONDA_PREFIX/etc/conda/activate.d
deactive_dir=$CONDA_PREFIX/etc/conda/deactivate.d

active_file=$active_dir/env_vars.sh
deactive_file=$deactive_dir/env_vars.sh

# Create folders if needed
if ! [ -d $active_dir ]; then
    mkdir -p $active_dir
fi
if ! [ -d $deactive_dir ]; then
    mkdir -p $deactive_dir
fi
# Create files if needed
if ! [ -f $active_file ]; then
    touch $active_file
    echo -e "#!/usr/bin/env bash \n" >> $active_file

fi
if ! [ -f $deactive_file ]; then
    touch $deactive_file
    echo -e "#!/usr/bin/env bash \n" >> $deactive_file
fi

# In the activation file, prepend the new value to the old value
echo "export $variable_name=$variable_value:\$${variable_name}" >> $active_file
# In the deactivation file, set the variable to the old value
echo "export $variable_name=${!variable_name}" >> $deactive_file
