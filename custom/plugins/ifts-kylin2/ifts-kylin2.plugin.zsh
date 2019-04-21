source /public/intel/compilers_and_libraries_2018.1.148/linux/pkg_bin/ifortvars.sh intel64

# User specific aliases and functions
alias yhrun='srun'
alias yhbatch='sbatch'
alias yhq='squeue -u $USER'
alias yhcontrol='scontrol'
alias yhi='sinfo'
alias yhcancel='scancel'

yhqc() {
    local user
    user=${1:-$USER}
    squeue -u $user | sed -e "/${user}[ \t]*R[ \t]*/ s/^.*$/$fg_bold[green]&$reset_color/" \
        -e "/${user}[ \t]*F[ \t]*/ s/^.*$/$fg_bold[red]&$reset_color/" \
        -e "/${user}[ \t]*PD[ \t]*/ s/^.*$/$fg_bold[yellow]&$reset_color/" \
        -e "/${user}[ \t]*C[AG][ \t]*/ s/^.*$/$fg_bold[grey]&$reset_color/"
}
