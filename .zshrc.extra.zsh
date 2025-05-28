HISTSIZE="999999"
SAVEHIST="999999"
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
mkdir -p ${HISTFILE:h}
setopt hist_fcntl_lock
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt share_history
setopt extended_history
setopt append_history

setopt auto_cd
setopt auto_pushd
setopt extended_glob
setopt hash_list_all
# setopt interactive_comments
setopt no_sh_word_split
setopt notify
setopt null_glob
setopt numeric_glob_sort

fpath+=~/.local/share/zsh/site-functions
autoload -Uz ~/.local/share/zsh/site-functions/*(.:t)

# function expand-alias() {
# 		zle _expand_alias
# 		zle self-insert
# }
#
# zle -N expand-alias
#
# bindkey -M main ' ' expand-alias

bindkey "${terminfo[kcbt]:-^[[Z}" reverse-menu-complete

# history expansion
bindkey ' ' magic-space

export DELTA_PAGER='less -R'
export LESS='--RAW-CONTROL-CHARS --LONG-PROMPT --ignore-case --no-init --quit-if-one-screen'

export GPG_TTY="$(tty)"

export EZA_COLORS="reset"
export LS_COLORS="di=34:ln=35:so=1;35:pi=1;33:ex=32:bd=1;33:cd=1;33:su=1;31:sg=1;31:tw=1;34:ow=1;33:"

export MANPAGER='nvim +Man!'
export MANWIDTH=100

export READNULLCMD=$PAGER

eval "$(direnv hook zsh)"
export DIRENV_LOG_FORMAT=

source ~/.local/share/zsh/plugins/zsh-defer/zsh-defer.plugin.zsh

source ~/.zsh.d/vi-mode.zsh
source ~/.zsh.d/prompt.zsh
source ~/.zsh.d/aliases.sh
alias -- +x='chmod +x'
source ~/.zsh.d/aliases-global.zsh
zsh-defer source ~/.zsh.d/completion.zsh

(( $+commands[orbctl] )) && zsh-defer source ~/.zsh.d/orbstack.zsh
[[ $TERM == xterm-kitty ]] && source ~/.zsh.d/kitty.zsh
source ~/.local/share/zsh/plugins/nix-shell/nix-shell.plugin.zsh
source ~/.zsh.d/accept-line.zsh
source ~/.zsh.d/autopair.zsh
source ~/.zsh.d/autosuggestions.zsh
source ~/.zsh.d/fzf.zsh
source ~/.zsh.d/history-substring-search.zsh
[[ -n "$TMUX" ]] && source ~/.zsh.d/tmux-term-title.zsh

zsh-defer source ~/.local/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
