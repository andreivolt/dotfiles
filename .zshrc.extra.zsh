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
mkdir -p ~/.local/share/zsh/site-functions
autoload -Uz ~/.local/share/zsh/site-functions/*(.:t)

bindkey ''${terminfo[kcbt]:-^\[\[Z} reverse-menu-complete

bindkey '^n' expand-or-complete
bindkey '^p' reverse-menu-complete

# history expansion
bindkey ' ' magic-space

export DELTA_PAGER='less -R'
export LESS='--RAW-CONTROL-CHARS --LONG-PROMPT --ignore-case --no-init --quit-if-one-screen'

export GPG_TTY="$(tty)"

export LS_COLORS="di=1;34:ln=1;35:so=1;35:pi=1;33:ex=1;32:bd=1;33:cd=1;33:su=1;31:sg=1;31:tw=1;34:ow=1;33:"

export MANPAGER='nvim +Man!' MANWIDTH=100

export READNULLCMD=$PAGER

source ~/.zsh.d/vi-mode.zsh
source ~/.zsh.d/aliases.sh
source ~/.zsh.d/global-aliases.zsh
source ~/.zsh.d/prompt.zsh
source ~/.zsh.d/completion.zsh

(( $+commands[orbctl] )) && source ~/.zsh.d/orbstack.zsh
[[ $OSTYPE == darwin* ]] && source ~/.zsh.d/mac.zsh
[[ $TERM == xterm-kitty ]] && source ~/.zsh.d/kitty.zsh
source ~/.local/share/zsh/plugins/nix-shell/nix-shell.plugin.zsh
source ~/.zsh.d/accept-line.zsh
source ~/.zsh.d/autopair.zsh
source ~/.zsh.d/autosuggestions.zsh
source ~/.zsh.d/direnv.zsh
source ~/.zsh.d/fzf.zsh
source ~/.zsh.d/history-substring-search.zsh
source ~/.zsh.d/tmux-term-title.zsh

alias -- +x='chmod +x'

source ~/.local/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
