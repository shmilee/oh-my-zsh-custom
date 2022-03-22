# user@host, full path, time, and return status
# on two lines for easier vgrepping
# edit duellj rkj and funky

#local blue_op="%{$fg[blue]%}[%{$reset_color%}"
local _cnt=$'%{\e[0;34m%}%B'
local _op="${_cnt}[%b"
local _cp="${_cnt}]%b%{$reset_color%}"
local _u_at_h=$'%{\e[1;32m%}%n%{\e[1;34m%}@%{\e[0;36m%}%m'
local smiley_ret="%(?,%{$fg[green]%}:%) %?%{$reset_color%},%{$fg[red]%}:( %?%{$reset_color%})"

PROMPT=$'${_cnt}┌─${_op}${_u_at_h}:%{\e[1;37m%}%~${_cp}-${_op}%*${_cp} $(git_prompt_info)
${_cnt}└─${_op}%{\e[1;37m%}%B%(!.#.$)${_cp} '
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
