alias topreview='git checkout preview; git merge master; git push origin preview; git checkout master;' 
alias deploy='cd _site; git add .; git commit -m "Deploy update"; git push origin gh-pages; cd ..'
alias teamspeak='. /home/cecilio/Utilites/TeamSpeak3-Client-linux_amd64/ts3client_runscript.sh'

alias ..='cd ..'
alias ...='..; cd ..'
alias ....='...; cd ..'
alias .....='....; cd ..'
alias ......='.....; cd ..'

alias vpnuib='sudo openvpn --config /home/cecilio/Documents/UIB/documents/vpnuib.crt'

alias matlas='sshfs cecilio@atlas.uib.es:/data /home/cecilio/Documents/UIB/atlas/data -o auto_cache,reconnect'
alias umatlas="fusermount -u /home/cecilio/Documents/UIB/atlas/data"

alias activate_conda="source /cvmfs/oasis.opensciencegrid.org/ligo/sw/conda/etc/profile.d/conda.sh"