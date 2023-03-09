alias ..='cd ..'
alias ...='..; cd ..'
alias ....='...; cd ..'
alias .....='....; cd ..'
alias ......='.....; cd ..'

alias scratch_picasso='cd /mnt2/fscratch/users/uib54_res/uib54017/'
alias scratch_mn4='cd /gpfs/scratch/uib91/uib91611'

alias gpu_session='srun -p gpu_interactive -t 0-02:00 --mem 2G --gres=gpu:v100:1 --pty bash -i'

alias vpnuib='sudo openvpn --config /home/cecilio/Documents/UIB/vpn/vpnuib.crt'

alias matlas='sshfs cecilio@atlas.uib.es:/data /home/cecilio/Documents/UIB/atlas -o auto_cache,reconnect'
alias umatlas="fusermount -u /home/cecilio/Documents/UIB/atlas"

alias teamspeak='/home/cecilio/Utilities/TeamSpeak3-Client-linux_amd64/ts3client_runscript.sh'

alias open='xdg-open'

# Activate cvmfs' conda. Add PYTHONNOUSERSITE to not use ~/.local packages.
alias activate_conda="export PYTHONNOUSERSITE=True; source /cvmfs/oasis.opensciencegrid.org/ligo/sw/conda/etc/profile.d/conda.sh"
alias nousersitetrue="export PYTHONNOUSERSITE=True"
alias nousersitefalse="unset PYTHONNOUSERSITE";
alias sys-path="python -c 'import sys; print(sys.path)'"  # Check where python looks for packages

# Switch between LAL installations in conda environment
alias switch-conda-lal=". $HOME/git/dotfiles/switch-conda-lal.sh"
# Set environment variables only whe a conda environment remains active
alias set-variables-conda-env=". $HOME/git/dotfiles/set-variables-conda-env.sh"

# Alias to check LAL installation
alias check-lal="python -c 'import lal; from lal import git_version; print(lal.__version__, lal.__file__); print(git_version.branch, git_version.id)'"

alias topreview='git checkout preview; git merge master; git push origin preview; git checkout master;'
#alias deploy='cd _site; git add .; git commit -m "Deploy update"; git push origin gh-pages; cd ..'
alias jekyll-build='bundle exec jekyll build'

# Function to deploy jekyll site changes to github pages
deploy(){
    cd _site
    git add .
    git commit -m "$@"
    git push origin gh-pages
    cd ..
}

# Function to do all the deploy steps for jekyll site
deploy-all() {
    echo ">>> Building jekyll site..."
    jekyll-build
    echo -e "Done \n"
    echo ">>> Commit changes..."
    git add .
    read -p "Enter commit message: " -e msg
    git commit -m "$msg"
    git push origin master
    echo -e "\n>>> Sending changes to preview branch..."
    topreview
    echo -e "Done \n"
    echo ">>> Deploying changes to github pages..."
    deploy "$msg"
    echo "Done"
}

alias starwars="telnet towel.blinkenlights.nl"
