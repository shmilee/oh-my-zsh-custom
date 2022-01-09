source /thfs1/software/modules/4.2.1/init/zsh

module load GCC/9.3.0
module load mpich/mpi-x-gcc9.3.0
module load python/2.7.18
module load lapack/3.8.0-gcc9.3.0
module load libpng/1.6.37-gcc9.3.0
module load libjpeg-turbo/2.1.0-gcc9.3.0

_GTC_DEPENDS_DIST=~/shmilee/gtc-config/third_party_product

export PATH=$_GTC_DEPENDS_DIST/bin:$PATH
export INCLUDE=$_GTC_DEPENDS_DIST/include:$INCLUDE
export LD_LIBRARY_PATH=$_GTC_DEPENDS_DIST/lib:$LD_LIBRARY_PATH

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
