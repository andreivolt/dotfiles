alias eza="eza --icons never"
alias ls="eza"
alias l="ls -1"
alias la="ls -a"
alias ll="ls -l --classify=auto --git"
alias lla="ll -a"

alias cdt='cd $(mktemp -d)'
alias diff="diff --color"
alias edir="edir -r"
alias gc='git clone --depth 1'
alias gist="gh gist"
alias gron="fastgron"
alias hgrep='history | grep -i --color'
alias j="jobs"
alias path='printf "%s\n" $path'
alias reload-history='fc -p && fc -R'
alias rg='rg --smart-case --colors match:bg:yellow --colors match:fg:black'
alias rm="rm --verbose"
alias vi="nvim"
alias yt-dlp="yt-dlp --cookies-from-browser chrome"

alias -- +x='chmod +x'
