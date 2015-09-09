alias c='clear'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias df='df -h'
alias du='du -c -h'
alias fbterm_zh='LANG=zh_CN.UTF-8 fbterm'
alias more='less'
alias openports='netstat --all --numeric --programs --inet --inet6'
alias matlabcli='~/.local/matlab2010a/bin/matlab -nodesktop -nosplash'

# simplified systemd command
if systemd-notify --booted 2>/dev/null; then
    alias 0.start='sudo systemctl start'
    alias 0.restart='sudo systemctl restart'
    alias 0.stop='sudo systemctl stop'
    alias 0.enable='sudo systemctl enable'
    alias 0.disable='sudo systemctl disable'
    alias 0.reload='sudo systemctl reload'
    alias 0.log='sudo journalctl'
    alias 0.status='systemctl status'
    alias 0.list='systemctl'
    alias 0.list-files='systemctl list-unit-files'
    alias 0.wants='systemctl show -p "Wants"'
    alias 0.analyze='systemd-analyze'
    alias 0.failed='systemctl --failed'
fi

nikola() {
    nkl_Ver=${1:-using}
    if [[ x$nkl_Ver == 'x-h' ]]; then
        echo "$0 <docker nikola tag>"
        echo "Default is <using>"
        docker images
        return 0
    fi
    docker run -u 1000 -t --rm -p 8000:8000 -v $(pwd):/blog -w /blog -i nikola:$nkl_Ver bash
}

