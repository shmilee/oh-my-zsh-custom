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
    alias scp-sync='rsync -aAX -D --progress --numeric-ids --links --hard-links --itemize-changes --times --recursive --perms --owner --group --stats --human-readable -e "ssh -o ServerAliveInterval=60"'
fi

if hash nvim-qt &>/dev/null; then
    alias qvim='nvim-qt'
fi

if hash rofi &>/dev/null; then
    alias crofi='rofi -show combi -modes combi -combi-modes "drun,window,run,emoji"  -dpi 144'
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
    ffmpeg-slim-h264() {
        if [ x"$1" = x -o x"$2" = x ]; then
            echo "Usage: ffmpeg-copy INPUT OUTPUT [vcodec] [size]"
        else
            # -vcodec encoders: libx264 h264_nvenc h264_qsv h264_vaapi
            local encoder=${3:-libx264}
            if [ x"$4" = x ]; then
                ffmpeg -i "$1" -c:a copy -vcodec $encoder -profile:v high -r 30 -crf 28 "$2"
            else
                ffmpeg -i "$1" -c:a copy -vcodec $encoder -profile:v high -r 30 -crf 28 -s $4 "$2"
            fi
        fi
    }
fi

if hash find &>/dev/null; then
    find_newer() {
        if [ x"$1" = x -o x"$2" = x ];then
            echo 'Usage: find_newer starting-point [[CC]YY]MMDDhhmm[.ss] Your-find-EXPRESSION (like -type d -exec xxx)'
            return 1
        fi
        start="${1}"
        tmpfile="$(mktemp -u -t findnewer-XXXXXX)"
        other=(${@:3})
        echo touch -t "$2" "$tmpfile" "&&" find $start -newer $tmpfile ${other[@]}
        read -q "Ent?Enter y to run: "
        echo
        if [ x"$Ent" = xy ]; then
            touch -t "$2" "$tmpfile" && (
                find $start -newer $tmpfile ${other[@]}
                rm "$tmpfile"
            )
        fi
    }
fi
