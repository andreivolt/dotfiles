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
setopt interactive_comments
setopt null_glob
setopt numeric_glob_sort

READNULLCMD=$PAGER

# history expansion
bindkey ' ' magic-space

source ~/.local/share/zsh/plugins/zsh-defer/zsh-defer.plugin.zsh

source ~/.zsh.d/vi.zsh

source ~/.zsh.d/prompt.zsh

# source ~/.zsh.d/accept-line.zsh
# zsh-defer source ~/.local/share/zsh/plugins/zummoner/zummoner.plugin.zsh
(( $+commands[orbctl] )) && zsh-defer source ~/.zsh.d/orbstack.zsh
[[ $TERM == xterm-kitty ]] && zsh-defer source ~/.zsh.d/kitty.zsh
[[ -n "$TMUX" ]] && zsh-defer source ~/.zsh.d/tmux.zsh
zsh-defer eval "$(dircolors -b ~/.dircolors)"
zsh-defer source ~/.local/share/zsh/plugins/nix-shell/nix-shell.plugin.zsh
zsh-defer source ~/.local/share/zsh/plugins/zsh-fzf-history-search/zsh-fzf-history-search.zsh
zsh-defer source ~/.zsh.d/aliases-global.zsh
zsh-defer source ~/.zsh.d/aliases.zsh
zsh-defer source ~/.zsh.d/autopair.zsh
zsh-defer source ~/.zsh.d/autosuggestions.zsh
zsh-defer source ~/.zsh.d/completion.zsh
zsh-defer source ~/.zsh.d/direnv.zsh
zsh-defer source ~/.zsh.d/fzf.zsh
zsh-defer source ~/.zsh.d/history-substring-search.zsh

zsh-defer source ~/.local/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
