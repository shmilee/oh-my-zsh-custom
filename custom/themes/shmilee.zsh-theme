# user@host, full path, time, and return status
# on two lines for easier vgrepping
# edit duellj rkj and funky

#local blue_op="%{$fg[blue]%}[%{$reset_color%}"
local _cnt=$'%{\e[0;34m%}%B'
local _op="${_cnt}[%b"
local _cp="${_cnt}]%b%{$reset_color%}"
local _u_at_h=$'%{\e[1;32m%}%n%{\e[1;34m%}@%{\e[0;36m%}%m'
local smiley_ret="%(?,%{$fg[green]%}:%) %?%{$reset_color%},%{$fg[red]%}:( %?%{$reset_color%})"


## copy from $ZSH/themes/smt.zsh-theme
# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
function git_time_since_commit() {
    local COLOR MINUTES HOURS DAYS SUB_HOURS SUB_MINUTES
    local last_commit seconds_since_last_commit

    # Only for git dir
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        return
    fi

    # Only proceed if there is actually a commit
    if ! last_commit=$(command git -c log.showSignature=false log --pretty=format:'%at' -1 2>/dev/null); then
        echo "[$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL~%{$reset_color%}]"
        return
    fi

    # Totals
    seconds_since_last_commit=$(( EPOCHSECONDS - last_commit ))
    MINUTES=$(( seconds_since_last_commit / 60 ))
    HOURS=$(( MINUTES / 60 ))

    # Sub-hours and sub-minutes
    DAYS=$(( HOURS / 24 ))
    SUB_HOURS=$(( HOURS % 24 ))
    SUB_MINUTES=$(( MINUTES % 60 ))

    if [[ -z "$(command git status -s 2>/dev/null)" ]]; then
        COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
    else
        if [[ "$MINUTES" -gt 30 ]]; then
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
        elif [[ "$MINUTES" -gt 10 ]]; then
            COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
        else
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
        fi
    fi

    if [[ "$HOURS" -gt 24 ]]; then
        echo "[${COLOR}${DAYS}d${SUB_HOURS}h${SUB_MINUTES}m%{$reset_color%}]"
    elif [[ "$MINUTES" -gt 60 ]]; then
        echo "[${COLOR}${HOURS}h${SUB_MINUTES}m%{$reset_color%}]"
    else
        echo "[${COLOR}${MINUTES}m%{$reset_color%}]"
    fi
}

PROMPT=$'${_cnt}╭─${_op}${_u_at_h}: %{\e[1;37m%}%~${_cp}-${_op}%*${_cp} $(git_prompt_info)
${_cnt}╰─${_op}%{\e[1;37m%}%B%(!.#.$)${_cp} '
ZLE_RPROMPT_INDENT=0
RPROMPT='$(git_time_since_commit)$(git_prompt_status) ${smiley_ret}'
PS2=$'[%_] ${_cnt}>%{\e[0m%}%b '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[green]%}git:("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"

ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[green]%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$fg[cyan]%}"
