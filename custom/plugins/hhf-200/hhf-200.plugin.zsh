# HPC环境快捷命令
alias hpc-env='source /etc/profile.d/hpc-modules.sh'
alias hpc-check='check-hpc-env'
alias hpc-reset='module purge && unset CFLAGS FFLAGS CXXFLAGS LDFLAGS'

export PATH=~/local-llama/bin:~/.local/bin:/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=~/local-llama/lib:~/.local/lib:$LD_LIBRARY_PATH

export PATH=~/.pixi/bin:$PATH
eval "$(pixi completion --shell zsh)"
export PIXI_CACHE_DIR=/data/rattler-cache
export RATTLER_CACHE_DIR=/data/rattler-cache
