alias df='df -h'
alias du='du -c -h'

if [[ $(uname) != Darwin ]]; then
    alias xopen='xdg-open'
    alias chown='chown --preserve-root'
    alias chmod='chmod --preserve-root'
    alias chgrp='chgrp --preserve-root'
    alias openports='netstat --all --numeric --programs --inet --inet6'
fi

if [ -f ~/.local/matlab/bin/matlab ]; then
    if hash optirun &>/dev/null; then
        alias matlabcli='unset _JAVA_OPTIONS; optirun ~/.local/matlab/bin/matlab -nodesktop -nosplash'
    else
        alias matlabcli='unset _JAVA_OPTIONS; ~/.local/matlab/bin/matlab -nodesktop -nosplash'
    fi
fi

alias scp-append='rsync --progress -v -z --append-verify -e "ssh -o ServerAliveInterval=60"'

if (hash you-get &>/dev/null) && (hash mpv &>/dev/null); then
    alias you-mpv='you-get -p mpv'
fi
