# IFTS.ZJU
alias kylin="ssh -o ServerAliveInterval=60 -p 5789 smli@10.22.92.173"
alias oldifts="TERM=linux ssh -o ServerAliveInterval=60 -p 10321 smli@10.22.92.172"
alias zion='ssh -o ServerAliveInterval=60 -p 5789 smli@10.22.92.171'

scp2kylin () { scp -P 5789 -r $1 smli@10.22.92.173:upload/; }
scp4kylin () { scp -P 5789 -r smli@10.22.92.173:$1 ./; }

scp2zion () { scp -P 5789 -r $1 smli@10.22.92.171:upload/; }
scp4zion () { scp -P 5789 -r smli@10.22.92.171:$1 ./; }

scp2oldifts () { scp -P 10321 -r $1 smli@10.22.92.172:upload/; }
scp4oldifts () { scp -P 10321 -r smli@10.22.92.172:$1 ./; }

scp2th1a () { scp -P 2223 -r $1 zhaochen@192.168.5.126:upload/; }
scp4th1a () { scp -P 2223 -r zhaochen@192.168.5.126:$1 ./; }
