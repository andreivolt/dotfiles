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
setopt null_glob
setopt numeric_glob_sort
# setopt interactive_comments

cdt() cd $(mktemp -d)
hgrep() { fc -ifl -m "*(#i)$1*" 1 | grep -i --color $1 }
path() printf "%s\n" $path

# function expand-alias() {
# 		zle _expand_alias
# 		zle self-insert
# }
#
# zle -N expand-alias
#
# bindkey -M main ' ' expand-alias

# Moved to after vi-mode setup

# history expansion
bindkey ' ' magic-space

export DELTA_PAGER='less -R'
export LESS='--RAW-CONTROL-CHARS --LONG-PROMPT --ignore-case --no-init --quit-if-one-screen'

export GPG_TTY="$(tty)"

eval "$(dircolors -b ~/.dircolors)"

export MANPAGER='nvim +Man!'
export MANWIDTH=100

export READNULLCMD=$PAGER

eval "$(direnv hook zsh)"
export DIRENV_LOG_FORMAT= # suppress loading messages

source ~/.local/share/zsh/plugins/zsh-defer/zsh-defer.plugin.zsh

source ~/.zsh.d/vi.zsh
source ~/.zsh.d/prompt.zsh
source ~/.zsh.d/aliases.zsh
alias -- +x='chmod +x'
source ~/.zsh.d/aliases-global.zsh
# source ~/.zsh.d/case-correct-cd.zsh
zsh-defer source ~/.zsh.d/completion.zsh
# zsh-defer eval "$(fzf --zsh)" # Disabled - using zsh-fzf-history-search plugin instead

(( $+commands[orbctl] )) && zsh-defer source ~/.zsh.d/orbstack.zsh
[[ $TERM == xterm-kitty ]] && source ~/.zsh.d/kitty.zsh

zsh-defer source ~/.local/share/zsh/plugins/nix-shell/nix-shell.plugin.zsh

# source ~/.zsh.d/accept-line.zsh
zsh-defer source ~/.zsh.d/autopair.zsh
zsh-defer source ~/.zsh.d/autosuggestions.zsh
zsh-defer source ~/.zsh.d/fzf.zsh
zsh-defer source ~/.local/share/zsh/plugins/zsh-fzf-history-search/zsh-fzf-history-search.zsh
zsh-defer source ~/.zsh.d/history-substring-search.zsh
[[ -n "$TMUX" ]] && zsh-defer source ~/.zsh.d/tmux-term-title.zsh

# zsh-defer source ~/.local/share/zsh/plugins/zummoner/zummoner.plugin.zsh

zsh-defer source ~/.local/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
