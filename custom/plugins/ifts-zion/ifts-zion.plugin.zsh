export PATH=/opt/matlab/bin:/home/czhao/petsc-3.1-p8/bin:/home/czhao/mpi/mpich2/bin:/opt/pgi/linux86-64/10.0/bin:/opt/pgi/linux86-64/2010/cuda/bin:/opt/intel/bin::$PATH

export PGI=/opt/pgi/

MANPATH=$MANPATH:/opt/pgi/linux86-64/10.0/man
export MANPATH

LD_LIBRARY_PATH=/usr/lib:/home/czhao/lib:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH

LM_LICENSE_FILE=$LM_LICENSE_FILE:/usr/local/itt/license/license.dat
export LM_LICENSE_FILE

export PETSC_DIR=/home/czhao/petsc-3.1-p8
export PETSC_ARCH=linux-gnu-cxx-debug
