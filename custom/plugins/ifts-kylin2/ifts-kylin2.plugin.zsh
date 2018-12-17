export PATH=/public/intel/compilers_and_libraries_2018.1.148/linux/mpi/intel64/bin:$PATH
export LD_LIBRARY_PATH=/public/intel/compilers_and_libraries_2018.1.148/linux/mpi/intel64/lib:$LD_LIBRARY_PATH

source /public/intel/compilers_and_libraries_2018.1.148/linux/mkl/bin/mklvars.sh intel64
export PATH=/public/intel/compilers_and_libraries_2018.1.148/linux/mkl/bin:$PATH
export LD_LIBRARY_PATH=/public/intel/compilers_and_libraries_2018.1.148/linux/mkl/lib/intel64_lin:$LD_LIBRARY_PATH

# PETSC TODO
export PETSC_DIR=/public/home/test3/hwyang/myapp-intel2018.1.148/petsc-3.6.4
export PETSC_ARCH=linux-gnu-c-debug
export PETSC_KSP_LIB=/public/home/test3/hwyang/myapp-intel2018.1.148/petsc-3.6.4/linux-gnu-c-debug/include:$PETSC_KSP_LIB

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