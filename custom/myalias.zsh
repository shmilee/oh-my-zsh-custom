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

if (hash rsync &>/dev/null) && (hash ssh &>/dev/null); then
    alias scp-append='rsync --progress -v -z --append-verify -e "ssh -o ServerAliveInterval=60"'
fi

if (hash you-get &>/dev/null) && (hash mpv &>/dev/null); then
    alias you-mpv='you-get -p mpv'
fi

if hash ffprobe &>/dev/null; then
    alias ffprobe-show-json='ffprobe -v quiet -print_format json -show_format -show_data -show_streams'
fi
if hash ffmpeg &>/dev/null; then
    ffmpeg-copy () {
        if [ x"$1" = x -o x"$2" = x ];then
            echo "Usage: ffmpeg-copy INPUT OUTPUT"
        else
            ffmpeg -i "$1" -vcodec copy -acodec copy "$2"
        fi
    }
fi
