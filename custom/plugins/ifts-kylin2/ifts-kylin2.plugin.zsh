source /public/intel/compilers_and_libraries_2018.1.148/linux/pkg_bin/ifortvars.sh intel64

# User specific aliases and functions
alias yhrun='srun'
alias yhbatch='sbatch'
alias yhq='squeue -u $USER'
alias yhqc='yhq|sqc'
alias yhcontrol='scontrol'
alias yhi='sinfo'
alias yhcancel='scancel'

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
    echo " ==> $((cal/24/40)) (node*day)"
}

yhused2() {
    local st args cal
    if [ x"$1" = x ]; then
        st=''
    else
        st="-S $1"
    fi
    args=($st -o "partition,alloccpus,cputimeraw,state,workdir%60" -X)
    sacct ${args[@]}
    cal=$(sacct ${args[@]} | awk 'BEGIN{total=0}{total+=$3}END{print total/3600}')
    echo ""
    echo " ==> $cal (core*hour)"
    echo " ==> $((cal/24/40)) (node*day)"
}
