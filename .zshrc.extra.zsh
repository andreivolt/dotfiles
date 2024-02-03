# TODO dir is writable https://github.com/Feh/configs/blob/ae95e37be019d682113b30101e03af0f1e7f5174/.zsh/zshrc#L218
# TODO kill completion
# TODO pushd
# TODO setopt pipefail
# TODO strace completion
# TODO tmux complete words from current pane https://gist.github.com/blueyed/6856354
# TODO vcs info https://github.com/grml/grml-etc-core/blob/71bdc48d190a5369fff28a97c828db7b1edf10a9/etc/zsh/zshrc#L1964
#

# is-macos() { [ $(uname -s) = Darwin ] }
is-macos() {
  [[ $OSTYPE == darwin* ]]
}

add-to-path() {
  path+=("$@")
}

# prepend-to-path() {
#   for dir in "$@"; do
#     if [[ ! ":$PATH:" == *":$dir:"* ]]; then
#       path=("$dir" $path)
#     fi
#   done
# }

# prepend-to-path ~/.local/bin

export PATH=~/.local/bin:$PATH

setopt auto_pushd # automatically add directories to the directory stack

# # set terminal title
# source ${./modules/zsh/terminal-title.zsh}

autoload -Uz colors && colors

# standard to request colors
export COLORTERM=yes

umask u=rwx,g=x,o=x

export PATH=~/drive/bin:$PATH

autoload -Uz ~/.zsh-plugins/defer/zsh-defer


# MODULES
# is-macos && zsh-defer source ~/.zsh.d/macos.zsh
# zsh-defer source ~/.zsh.d/grc.sh
# zsh-defer source ~/.zsh.d/notify_when_done.zsh
# zsh-defer source ~/.zsh.d/npm.zsh
# zsh-defer source ~/.zsh.d/nvm.zsh
# zsh-defer source ~/.zsh.d/python.zsh
# zsh-defer source ~/.zsh.d/ruby.zsh
# zsh-defer source ~/.zsh.d/github.zsh
[ $TERM = xterm-kitty ] && zsh-defer source ~/.zsh.d/kitty.zsh
is-macos && source ~/drive/nixos-config/modules/zsh/vi.zsh
is-macos && zsh-defer source ~/.zsh.d/homebrew-command-not-found.sh
is-macos && zsh-defer source ~/.zsh.d/mac_libiconv.sh
zsh-defer source ~/.zsh-plugins/nix-shell/nix-shell.plugin.zsh
zsh-defer source ~/.zsh-plugins/system-clipboard/zsh-system-clipboard.zsh
zsh-defer source ~/.zsh.d/aliases.sh
zsh-defer source ~/.zsh.d/autopair.zsh
zsh-defer source ~/.zsh.d/brotab.zsh
zsh-defer source ~/.zsh.d/completion.zsh
zsh-defer source ~/.zsh.d/delta.zsh
zsh-defer source ~/.zsh.d/direnv.zsh
zsh-defer source ~/.zsh.d/fzf.zsh
zsh-defer source ~/.zsh.d/global-aliases.zsh
zsh-defer source ~/.zsh.d/go.zsh
zsh-defer source ~/.zsh.d/gpg.zsh
zsh-defer source ~/.zsh.d/keephack.zsh
zsh-defer source ~/.zsh.d/less-colors.sh
zsh-defer source ~/.zsh.d/ls-colors.sh
zsh-defer source ~/.zsh.d/rust.zsh
zsh-defer source ~/.zsh.d/tmux.zsh

zsh-defer source ~/.zsh-plugins/history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# homebrew completions
# if type brew &>/dev/null; then
#   FPATH=/opt/homebrew/share/zsh-completions:$FPATH
# fi

# prompt
which starship >/dev/null && eval "$(starship init zsh)"
# source ~/.zsh.d/prompt.zsh

which vi >/dev/null && export EDITOR='vi'
which vim >/dev/null && export EDITOR='vim'
which nvim >/dev/null && export EDITOR='nvim'

# # better sudo prompt
# alias sudo="sudo -p '%u->%U, enter password: ' "

# setopt auto_cd # if a command is issued that can't be executed as a normal command, and the command is the path of a directory, perform the cd command to that directory
# setopt cshjunkiehistory
# setopt hash_list_all # whenever a command completion is attempted, make sure the entire command path # is hashed first
# setopt noglobdots # make * not match dotfiles
# setopt nohup # Don't send SIGHUP to background processes when the shell exits.
# setopt noshwordsplit # use zsh style word splitting
# setopt unset # don't error out when unset parameters are used
setopt auto_pushd # make cd push the old directory onto the directory stack
setopt chase_links # cd resolve symlinks
setopt correct # spelling correction
setopt extended_glob # in order to use #, ~ and ^ for filename generation grep word *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files don't forget to quote '^', '~' and '#'!
setopt inc_append_history # TODO which
setopt interactive_comments # allow comments
setopt magicequalsubst # filename expansion in for e.g. foo=~/bar
setopt notify # report the status of backgrounds jobs immediately
setopt numeric_glob_sort # sort filename globs numerically


# HISTORY
HISTSIZE="999999"
SAVEHIST="999999"
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history" # prevent cloberring shell history when starting a shell with a smaller history size
mkdir -p ${HISTFILE:h}
setopt hist_fcntl_lock
setopt hist_ignore_dups
setopt hist_ignore_space # don't store commands with leading space
setopt hist_reduce_blanks # remove multiple blanks
setopt share_history
setopt extended_history # history: save timestamp and duration
# setopt append_history # import new commands from the history file also in other zsh session

# TODO: not on nix
# # completion: use bash completion
# autoload -U bashcompinit && bashcompinit

# trigger completion when tab is pressed on empty command line
complete-or-list() {
  [[ $#BUFFER != 0 ]] && { zle complete-word ; return 0 }
  echo
  ls
  zle reset-prompt
}
zle -N complete-or-list
bindkey '^I' complete-or-list

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

bindkey -s '^[l' " | less\n"
bindkey -s '^[b' " &\n"

# # shift-tab TODO error
# bindkey ''${terminfo[kcbt]:-^\[\[Z} reverse-menu-complete

# suffix aliases, open files with just filename
alias -s txt=cat
alias -s md=mdcat
alias -s json='jq .'
alias -s {flac,mp3,wav,ogg}='mpv --no-audio-display'
is-macos && alias -s {gif,jpg,jpeg,mp4,pdf}=quicklook

 # report on cpu-/system-/user-time of long-running commands
REPORTTIME=30

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

autoload -U zsh-mime-setup

# auto-quote URLs
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# do history expansion on space
bindkey ' ' magic-space

# # load the lookup subsystem if it's available on the system
# zrcautoload lookupinit && lookupinit

# export READNULLCMD=${READNULLCMD:-$PAGER}

# man
export MANWIDTH=100

## autoload own functions. _*-functions will be loaded by the compinit builtin
# fpath=(~/.zfunc $fpath)
# (: ~/.zfunc/(^_*)(.)) 2>|/dev/null && \
# autoload -U ${fpath[1]}/(^_*)(.:t)
# autoload -U zcalc zmv zargs

# history grep
hgrep() {
  fc -ifl -m "*(#i)$1*" 1 |
    grep -i --color $1
}

# cd to temp dir
cdt() {
  local t
  t=$(mktemp -d)
  builtin cd "$t"
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

################################################################################
# syntax highlighting: needs to be sourced after anything else that add hooks to modify the command-line buffer
################################################################################
# source ~/.zsh.d/syntax-highlighting.zsh

trim() {
  awk '{$1=$1};1'
}

# # Use lf to switch directories and bind it to ctrl-o TODO
# lfcd () {
#     tmp="$(mktemp -uq)"
#     trap 'rm -f $tmp >/dev/null 2>&1' HUP INT QUIT TERM PWR EXIT
#     lf -last-dir-path="$tmp" "$@"
#     if [ -f "$tmp" ]; then
#         dir="$(cat "$tmp")"
#         [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
#     fi
# }
# bindkey -s '^o' '^ulfcd\n'

# source $(which env_parallel.zsh) # allow using functions in parallel

last_created_file() {
  dir="${1:-.}"
  find "$dir" -type f -printf '%T+ %p\n' | sort -r | head -n 1 | cut -d' ' -f 2-
}

xlsx_column_names() {
  xlsx_file="$1"
  if [[ -z "$xlsx_file" ]]; then
    echo "Usage: xlsx_column_names <xlsx_file>"
    return 1
  fi

  in2csv "$xlsx_file" | head -n 1 | tr ',' '\n'
}

zsh-defer source ~/.zsh-plugins/syntax-highlighting/zsh-syntax-highlighting.zsh
if [[ -n "$TMUX" ]]; then
  function set-tmux-title() {
    printf "\033kzsh\033\\"
  }
  precmd_functions+=(set-tmux-title)
fi
