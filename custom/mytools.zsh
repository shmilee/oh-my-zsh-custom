# pixi
if [ -d ~/.pixi/bin/ ]; then
    export PATH=~/.pixi/bin:$PATH
fi
if [ -x ~/.pixi/bin/pixi ]; then
    eval "$(pixi completion --shell zsh)"
fi

# direnv
if hash direnv &>/dev/null; then
    eval "$(direnv hook zsh)"
fi


# redundant with Oh My Zsh
autoload -Uz compinit && compinit
