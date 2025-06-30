HISTSIZE="999999"
SAVEHIST="999999"
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
mkdir -p ${HISTFILE:h}
setopt append_history
setopt extended_history
setopt share_history
setopt hist_fcntl_lock
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

setopt auto_cd
setopt auto_pushd
setopt extended_glob
setopt interactive_comments
setopt null_glob
setopt numeric_glob_sort

READNULLCMD=$PAGER

alias -g C='| wc -l'
alias -g G="| rg"
alias -g H='| head'
alias -g L="| $PAGER"
alias -g N="&> /dev/null"
alias -g X='| xargs'

alias eza="eza --icons never"
alias ls="eza"
alias l="ls -1"
alias la="ls -a"
alias ll="ls -l --classify=auto --git"
alias lla="ll -a"

alias cdt='cd $(mktemp -d)'
alias diff="diff --color"
alias edir="edir -r"
alias fd="fd --follow"
alias find="find -L"
alias gc='git clone --depth 1'
alias gron="fastgron"
alias path='printf "%s\n" $path'
alias rg='rg --smart-case --colors match:bg:yellow --colors match:fg:black'
alias rm="rm --verbose"
alias vi="nvim"
alias yt-dlp="yt-dlp --cookies-from-browser chrome"

alias -- +x='chmod +x'

# history expansion
bindkey ' ' magic-space

source ~/.local/share/zsh/plugins/zsh-defer/zsh-defer.plugin.zsh

source ~/.zsh.d/vi.zsh

source ~/.zsh.d/prompt.zsh
source ~/.zsh.d/completion.zsh

# source ~/.zsh.d/accept-line.zsh
# zsh-defer source ~/.local/share/zsh/plugins/zummoner/zummoner.plugin.zsh

[[ "$OSTYPE" == darwin* ]] && zsh-defer source ~/.zsh.d/orbstack.zsh
[[ $TERM == xterm-kitty ]] && zsh-defer source ~/.zsh.d/kitty.zsh
[[ -n "$TMUX" ]] && zsh-defer source ~/.zsh.d/tmux.zsh
zsh-defer eval "$(dircolors -b ~/.dircolors)"
zsh-defer source ~/.local/share/zsh/plugins/nix-shell/nix-shell.plugin.zsh
zsh-defer source ~/.zsh.d/autopair.zsh
zsh-defer source ~/.zsh.d/autosuggestions.zsh
zsh-defer source ~/.zsh.d/direnv.zsh
zsh-defer source ~/.zsh.d/fzf.zsh
zsh-defer source ~/.zsh.d/history-search/history-search.zsh
zsh-defer source ~/.zsh.d/history-substring-search.zsh

zsh-defer source ~/.local/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
