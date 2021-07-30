alias ..='cd ..'
alias ...='..; cd ..'
alias ....='...; cd ..'
alias .....='....; cd ..'
alias ......='.....; cd ..'

alias vpnuib='sudo openvpn --config /home/cecilio/Documents/UIB/documents/vpnuib.crt'

alias matlas='sshfs cecilio@atlas.uib.es:/data /home/cecilio/Documents/UIB/atlas/data -o auto_cache,reconnect'
alias umatlas="fusermount -u /home/cecilio/Documents/UIB/atlas/data"

alias teamspeak='. /home/cecilio/Utilites/TeamSpeak3-Client-linux_amd64/ts3client_runscript.sh'

alias activate_conda="source /cvmfs/oasis.opensciencegrid.org/ligo/sw/conda/etc/profile.d/conda.sh"

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

# Function to do all deploy steps for jekyll site
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
