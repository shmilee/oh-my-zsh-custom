## test TH-3
_software=(
    '/vol7/software/gcc/8.2.0'
    '/vol7/software/mpich/3.2.1-gcc8.2.0'
    '/vol7/software/python/3.6.6-gcc8.2.0'
    '/vol7/software/hdf5/1.8.21-gcc8.2.0-mpich3.2.1'
)
for _sw in ${_software[@]}; do
    if [ -d $_sw/bin ]; then
        export PATH=$_sw/bin:$PATH
    fi
    if [ -d $_sw/lib ]; then
        export LD_LIBRARY_PATH=$_sw/lib:$LD_LIBRARY_PATH
    fi
    if [ -d $_sw/lib64 ]; then
        export LD_LIBRARY_PATH=$_sw/lib64:$LD_LIBRARY_PATH
    fi
    if [ -d $_sw/share/man ]; then
        export MANPATH=$_sw/share/man:$MANPATH
    fi
    if [ -d $_sw/include ]; then
        export INCLUDE=$_sw/include:$INCLUDE
    fi
done
unset _sw _software

# User specific aliases and functions
alias yhq='squeue'
alias yhqc='yhq|sqc'
alias yhi='sinfo'

sqc() {
    local user=${1:-$USER}
    cat - | sed \
        -e "/${user}[ \t]*R[ \t]*/ s/^.*$/$fg_bold[green]&$reset_color/" \
        -e "/${user}[ \t]*F[ \t]*/ s/^.*$/$fg_bold[red]&$reset_color/" \
        -e "/${user}[ \t]*PD[ \t]*/ s/^.*$/$fg_bold[yellow]&$reset_color/" \
        -e "/${user}[ \t]*C[AG][ \t]*/ s/^.*$/$fg_bold[grey]&$reset_color/"
}

yhused() {
    local st args cal
    if [ x"$1" = x ]; then
        st=''
    else
        st="start=$1"
    fi
    args=(cluster AccountUtilizationByUser $st user=$USER -t hours)
    sreport ${args[@]}
    cal=$(sreport ${args[@]} | awk '/zju-ifts/{print $4}')
    echo ""
    echo " ==> $cal (core*hour)"
}
