# User specific aliases and functions

_mpi=/usr/local/mpi.intel/openmpi1.6.4
#_mpi=/usr/local/mpi.intel/mvapi2_1.8
#_mpi=/usr/local/mpi.intel/mpich2_1.5

export PATH=$_mpi/bin:$PATH
export LD_LIBRARY_PATH=$_mpi/lib:$LD_LIBRARY_PATH
export MANPATH=$_mpi/share/man:$MANPATH
export INCLUDE=$_mpi/include:$INCLUDE

export PETSC_DIR=$HOME/myapp/petsc-3.5.3/linux-openmpi-intel
#export PETSC_ARCH=linux-gnu-intel

#functions

qstatc() {
    local name Ent
    name=${1:-$USER}
    Ent=${2:+'\n'}
    if [[ x$name != x ]];then
        qstat | sed -e "/${name}[ \t]*[rR]/ s/^.*$/$fg_bold[green]${Ent}&${Ent}$reset_color/" \
            -e "/${name}[ \t]*[Ee]/ s/^.*$/$fg_bold[red]${Ent}&${Ent}$reset_color/" \
            -e "/${name}[ \t]*[qQ]/ s/^.*$/$fg_bold[yellow]${Ent}&${Ent}$reset_color/" \
            -e "/${name}[ \t]*[dD]/ s/^.*$/$fg_bold[grey]${Ent}&${Ent}$reset_color/"
    else
        qstat
    fi
}
