source /opt/intel/composer_xe_2013.0.079/bin/iccvars.sh intel64
source /opt/intel/composer_xe_2013.0.079/bin/ifortvars.sh intel64
source /opt/intel/composer_xe_2013.0.079/mkl/bin/mklvars.sh intel64

export LD_LIBRARY_PATH=/vol6/intel_composer_xe_2013.0.079_lib:$LD_LIBRARY_PATH
_mpi=/vol6/software/mpi/mpi-intel2013
_other_software=(/vol6/software/{expat210,xz,python-2.7.11,hdf5})
for _sw in $_mpi ${_other_software[@]}; do
    export PATH=$_sw/bin:$PATH
    export LD_LIBRARY_PATH=$_sw/lib:$LD_LIBRARY_PATH
    export MANPATH=$_sw/share/man:$MANPATH
    export INCLUDE=$_sw/include:$INCLUDE
done
unset _mpi _sw _other_software

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
