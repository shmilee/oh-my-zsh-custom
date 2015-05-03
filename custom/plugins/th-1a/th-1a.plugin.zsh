export LD_LIBRARY_PATH=/vol-th/lib-11.1:$LD_LIBRARY_PATH
source /opt/intel/Compiler/11.1/059/bin/intel64/iccvars_intel64.sh
source /opt/intel/Compiler/11.1/059/bin/intel64/ifortvars_intel64.sh

#_mpi=/vol-th/software/mpi/mpi_1.2.1_intel_11.1
_mpi=/vol-th/software/mpi/mpi_1.4.1_intel_11.1
#_mpi=/vol-th/software/mpi/mpi_1.4.1_intel_11.1_large
_other_software=(/vol-th/software/{expat210,xz,python2.7,hdf5})

for _sw in $_mpi ${_other_software[@]}; do
    export PATH=$_sw/bin:$PATH
    export LD_LIBRARY_PATH=$_sw/lib:$LD_LIBRARY_PATH
    export MANPATH=$_sw/share/man:$MANPATH
    export INCLUDE=$_sw/include:$INCLUDE
done
unset _sw _other_software
