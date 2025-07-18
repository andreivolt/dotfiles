HISTSIZE="999999" SAVEHIST=$HISTSIZE
HISTFILE=$XDG_STATE_HOME/zsh/history
setopt append_history
setopt extended_history
setopt hist_fcntl_lock
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt share_history

setopt auto_cd
setopt auto_pushd
setopt extended_glob
setopt interactive_comments
setopt null_glob
setopt numeric_glob_sort

READNULLCMD=$PAGER

alias -g C="| wc -l"
alias -g G="| rg"
alias -g H="| head"
alias -g L="| $PAGER"
alias -g N="&> /dev/null"
alias -g NE="2> /dev/null"
alias -g X="| xargs"

alias -- +x="chmod +x"
alias cat="bat"
alias cdt="cd $(mktemp -d)"
alias claude="claude --dangerously-skip-permissions"
alias diff="diff --color"
alias edir="edir -r"
alias eza="eza --icons never"
alias gc="git clone --depth 1"
alias gron="fastgron"
alias http="xh"
alias jq="gojq"
alias l="ls -1"
alias la="ls -a"
alias ll="ls -l --classify=auto --git"
alias lla="ll -a"
alias ls="eza"
alias path='printf "%s\n" $path'
alias rg="rg --smart-case --colors match:bg:yellow --colors match:fg:black"
alias rm="rm --verbose"
alias scrcpy="scrcpy --render-driver opengl"
alias vi="nvim"
alias yt-dlp="yt-dlp --cookies-from-browser chrome"

bindkey ' ' magic-space # history expansion

source ~/.local/share/zsh/plugins/zsh-defer/zsh-defer.plugin.zsh

source ~/.config/zsh/vi.zsh
source ~/.config/zsh/completion.zsh

source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
source ~/.local/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
source ~/.config/zsh/p10k.zsh

[[ "$OSTYPE" == darwin* ]] && zsh-defer source ~/.config/zsh/orbstack.zsh
[[ $TERM == xterm-kitty ]] && zsh-defer source ~/.config/zsh/kitty.zsh
[[ -n "$TMUX" ]] && zsh-defer source ~/.config/zsh/tmux.zsh
zsh-defer eval "$(dircolors -b ~/.config/dircolors)"
zsh-defer source ~/.local/share/zsh/plugins/nix-shell/nix-shell.plugin.zsh
zsh-defer source ~/.config/zsh/autopair.zsh
zsh-defer source ~/.config/zsh/autosuggestions.zsh
zsh-defer source ~/.config/zsh/direnv.zsh
zsh-defer source ~/.config/zsh/fzf.zsh
zsh-defer source ~/.config/zsh/history-search/history-search.zsh; export ZSH_HISTORY_RELATIVE_DATES=1
zsh-defer source ~/.config/zsh/history-substring-search.zsh

zsh-defer source ~/.local/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
