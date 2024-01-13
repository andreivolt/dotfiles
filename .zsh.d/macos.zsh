# macos setsid
[ ! -f /usr/local/opt/util-linux/bin/setsid ] && which brew >/dev/null && brew install util-linux
alias setsid=/usr/local/opt/util-linux/bin/setsid

# macos gnu find
PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
