# IFTS.ZJU
alias kylin="ssh -p 5789 smli@10.22.92.173"     
alias oldifts="TERM=linux ssh -p 10321 smli@10.22.92.172"
alias zion='ssh -p 5789 smli@10.22.92.171'

scp2kylin () { scp -P 5789 -r $1 smli@10.22.92.173:upload/; }
scp4kylin () { scp -P 5789 -r smli@10.22.92.173:$1 ./; }

scp2zion () { scp -P 5789 -r $1 smli@10.22.92.171:upload/; }
scp4zion () { scp -P 5789 -r smli@10.22.92.171:$1 ./; }
