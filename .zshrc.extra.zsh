# TODO dir is writable https://github.com/Feh/configs/blob/ae95e37be019d682113b30101e03af0f1e7f5174/.zsh/zshrc#L218
# TODO kill completion
# TODO pushd
# TODO setopt pipefail
# TODO strace completion
# TODO tmux complete words from current pane https://gist.github.com/blueyed/6856354
# TODO vcs info https://github.com/grml/grml-etc-core/blob/71bdc48d190a5369fff28a97c828db7b1edf10a9/etc/zsh/zshrc#L1964

is-macos() [[ $OSTYPE == darwin* ]]

# automatically remove duplicates from these arrays
typeset -U \
  cdpath \
  fpath \
  manpath \
  path

path() printf "%s\n" $path

path=(
  ~/bin
  ~/.local/bin
  ~/go/bin
  ~/.cargo/bin
  $path
)

# standard to request colors
export COLORTERM=yes

umask u=rwx,g=x,o=x

autoload -Uz ~/.zsh-plugins/defer/zsh-defer

# prompt
# zsh-defer source ~/.zsh.d/prompt.zsh
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
source ~/.zsh-plugins/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Homebrew completions
(( ${+commands[brew]} )) && fpath=(/opt/homebrew/share/zsh/site-functions $fpath)

# history
HISTSIZE="999999"
SAVEHIST="999999"
HISTFILE="${XDG_CACHE_HOME:-$HOME/.local}/zsh/history" # prevent cloberring shell history when starting a shell with a smaller history size
mkdir -p ${HISTFILE:h}
setopt hist_fcntl_lock
setopt hist_ignore_dups
setopt hist_ignore_space # ignore commands with leading space
setopt hist_reduce_blanks # remove multiple blanks
setopt share_history
setopt extended_history # save timestamp and duration
setopt append_history

# setopt cshjunkiehistory
setopt auto_cd # if a command is issued that can't be executed as a normal command, and the command is the path of a directory, perform the cd command to that directory
setopt auto_pushd # automatically add directories to the directory stack
setopt chase_links # cd resolve symlinks
setopt extended_glob # in order to use #, ~ and ^ for filename generation grep word *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files don't forget to quote '^', '~' and '#'!
setopt hash_list_all # whenever a command completion is attempted, make sure the entire command path # is hashed first
setopt interactive_comments # allow comments
setopt magicequalsubst # filename expansion in for e.g. foo=~/bar
setopt noshwordsplit
setopt notify # report the status of backgrounds jobs immediately
setopt numeric_glob_sort # sort filename globs numerically

# modules
# is-macos && zsh-defer source ~/.zsh.d/macos.zsh
# zsh-defer source ~/.zsh.d/grc.sh
# zsh-defer source ~/.zsh.d/notify_when_done.zsh
# zsh-defer source ~/.zsh.d/npm.zsh
# zsh-defer source ~/.zsh.d/nvm.zsh
# zsh-defer source ~/.zsh.d/python.zsh
# zsh-defer source ~/.zsh.d/ruby.zsh
# zsh-defer source ~/.zsh.d/github.zsh
[ $TERM = xterm-kitty ] && zsh-defer source ~/.zsh.d/kitty.zsh
source ~/.zsh.d/vi.zsh
source ~/.zsh.d/global-aliases.zsh
# is-macos && zsh-defer source ~/.zsh.d/homebrew-command-not-found.sh
is-macos && zsh-defer source ~/.zsh.d/mac_libiconv.sh
zsh-defer source ~/.zsh-plugins/nix-shell/nix-shell.plugin.zsh
# zsh-defer source ~/.zsh-plugins/system-clipboard/zsh-system-clipboard.zsh
source ~/.zsh.d/aliases.sh
zsh-defer source ~/.zsh.d/autopair.zsh
zsh-defer source ~/.zsh.d/brotab.zsh
zsh-defer source ~/.zsh.d/completion.zsh
zsh-defer source ~/.zsh.d/delta.zsh
zsh-defer source ~/.zsh.d/direnv.zsh
zsh-defer source ~/.zsh.d/fzf.zsh
zsh-defer source ~/.zsh.d/gpg.zsh
zsh-defer source ~/.zsh.d/grep.zsh
zsh-defer source ~/.zsh.d/keephack.zsh
zsh-defer source ~/.zsh.d/less-colors.sh
zsh-defer source ~/.zsh.d/ls-colors.sh
zsh-defer source ~/.zsh.d/ripgrep.zsh
zsh-defer source ~/.zsh.d/tmux.zsh

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"
zsh-defer source ~/.zsh-plugins/autosuggestions/zsh-autosuggestions.zsh
unset ZSH_AUTOSUGGEST_USE_ASYNC # powerlevel10k

zsh-defer source ~/.zsh-plugins/history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

(( ${+commands[vi]} )) && export EDITOR='vi'
(( ${+commands[vim]} )) && export EDITOR='vim'
(( ${+commands[nvim]} )) && export EDITOR='nvim'

# # better sudo prompt
# alias sudo="sudo -p '%u->%U, enter password: ' "

# ctrl-z to toggle fg/bg
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word

# suffix aliases, open files with just filename
alias -s txt=cat
alias -s md=mdcat
alias -s json='jq .'
alias -s {flac,mp3,wav,ogg}='mpv --no-audio-display'
is-macos && alias -s {gif,jpg,jpeg,mp4,pdf}=quicklook

# report on cpu-/system-/user-time of long-running commands
REPORTTIME=30

autoload -Uz zsh-mime-setup

# do history expansion on space
bindkey ' ' magic-space

# # load the lookup subsystem if it's available on the system
# zrcautoload lookupinit && lookupinit

# export READNULLCMD=${READNULLCMD:-$PAGER}

# man
export MANWIDTH=100
export MANPAGER='nvim +Man!'

## autoload own functions. _*-functions will be loaded by the compinit builtin
# fpath=(~/.zfunc $fpath)
# (: ~/.zfunc/(^_*)(.)) 2>|/dev/null && \
# autoload -Uz ${fpath[1]}/(^_*)(.:t)
# autoload -Uz zcalc zmv zargs

# history grep
hgrep() {
  fc -ifl -m "*(#i)$1*" 1 |
    grep -i --color $1
}

# cd to temp dir
cdt() {
  builtin cd $(mktemp -d)
}

alias -- +x='chmod +x'

## TODO
## quote line
#__quote-line () {
# zle beginning-of-line
# zle forward-word

# RBUFFER=${(q)RBUFFER}
# zle end-of-line
#}
#zle -N mquote && bindkey '^q' __quote-line
## quote word or region
#__quote_word_or_region() {
#  emulate -L zsh
#    if (( $REGION_ACTIVE )); then
#      zle quote-region
#    else
#      # Alternative:{{{
#      #
#      #     RBUFFER+="'"
#      #     zle vi-backward-blank-word
#      #     LBUFFER+="'"
#      #     zle vi-forward-blank-word
#      #}}}
#      zle set-mark-command
#      zle vi-backward-blank-word
#      zle quote-region
#    fi
#}
#zle -N __quote_word_or_region
##    │
##    └ -N widget [ function ]
## Create a user-defined widget.  When the  new widget is invoked from within the
## editor, the specified shell function is called.
## If no function name is specified, it defaults to the same name as the widget.
#bindkey '^Q' __quote_word_or_region

# # just type '...' to get '../..'
# rationalise-dot() {
# local MATCH
# if [[ $LBUFFER =~ '(^|/| |	|'$'\n''|\||;|&)\.\.$' ]]; then
#   LBUFFER+=/
#   zle self-insert
#   zle self-insert
# else
#   zle self-insert
# fi
# }
# zle -N rationalise-dot
# bindkey . rationalise-dot
# # without this, typing a . aborts incremental history search
# bindkey -M isearch . self-insert

# use lf to switch directories and bind it to ctrl-o
lfcd () {
  tmp="$(mktemp -uq)"
  trap 'rm -f $tmp >/dev/null 2>&1' HUP INT QUIT TERM PWR EXIT
  lf -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
  fi
}
bindkey -s '^o' '^ulfcd\n'

# source $(which env_parallel.zsh) # allow using functions in parallel

# TODO
# highlight-pid-pstree() {
#   pstree -p --show-parents --arguments $$ --unicode |
#     rg --passthru --colors "match:fg:yellow" --color always --pcre2 "(?<=,)[0-9]*"
# }

# highlight() {
#   rg \
#   --passthru \
#   --colors "match:fg:$1" --color always \
#   --pcre2 "$2"
# }

# colors for macOS ls
export CLICOLOR=1

# use macOS instead of Nix versions
is-macos && {
  alias apropos=/usr/bin/apropos
  alias whatis=/usr/bin/whatis
}

# bind ctrl-left/right to move back and forward word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# autocorrect
# setopt correct # spelling correction
setopt correct_all
autoload -U colors && colors
export SPROMPT="Correct $fg_bold[red]%R$reset_color to $fg_bold[green]%r?$reset_color ($fg_bold[green]Yes$reset_color, $fg_bold[yellow]No$reset_color, $fg_bold[red]Abort$reset_color, $fg_bold[blue]Edit$reset_color) "

# ignore likely errors beginning of command
alias \$=''
alias \%=''

# syntax highlighting: needs to be sourced after anything else that add hooks to modify the command-line buffer
zsh-defer source ~/.zsh-plugins/syntax-highlighting/zsh-syntax-highlighting.zsh
