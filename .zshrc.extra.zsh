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
setopt interactive_comments
setopt magic_equal_subst
setopt no_sh_word_split
setopt notify
setopt null_glob
setopt numeric_glob_sort

fpath+=~/.local/share/zsh/site-functions
mkdir -p ${fpath[-1]}
autoload -Uz $fpath[-1]/*(.:t)

bindkey -v

export KEYTIMEOUT=1

autoload -Uz edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

bindkey -M vicmd 'H' run-help

bindkey ''${terminfo[kcbt]:-^\[\[Z} reverse-menu-complete

bindkey '^n' expand-or-complete
bindkey '^p' reverse-menu-complete

bindkey -M viins '\e[1;5C' forward-word
bindkey -M viins '\e[1;5D' backward-word

autoload -Uz select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}''${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

autoload -Uz select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

autoload -U surround
zle -N add-surround surround
zle -N change-surround surround
zle -N delete-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround

# change cursor according to mode
function zle-keymap-select zle-line-init zle-line-finish {
  case $KEYMAP in
    vicmd) print -n '\033[1 q' ;; # block
    viins|main) print -n '\033[6 q' ;; # line
  esac
}
zle -N zle-line-init; zle -N zle-line-finish; zle -N zle-keymap-select

# completion menu
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'i' accept-and-menu-complete
bindkey -M menuselect 'u' undo
# jump between categories of matches
bindkey -M menuselect 'n' vi-forward-blank-word
bindkey -M menuselect 'b' vi-backward-blank-word

bindkey '^G' push-line-or-edit
bindkey -M vicmd '^G' push-line-or-edit
bindkey -M viins '^G' push-line-or-edit

source ~/.zsh.d/aliases.sh
source ~/.zsh.d/global-aliases.zsh
source ~/.zsh.d/prompt.zsh

export DELTA_PAGER='less -R'

export GPG_TTY="$(tty)"

export LS_COLORS="di=1;34:ln=1;35:so=1;35:pi=1;33:ex=1;32:bd=1;33:cd=1;33:su=1;31:sg=1;31:tw=1;34:ow=1;33:"

export MANPAGER='nvim +Man!' MANWIDTH=100

export READNULLCMD=$PAGER

autoload -Uz compinit
[[ -f ~/.cache/zsh/zcompdump(#qN.mh+24) ]] && compinit -d ~/.cache/zsh/zcompdump || compinit -C -d ~/.cache/zsh/zcompdump

(( ${+commands[brew]} )) && fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
# eval "$(register-python-argcomplete pipx)"
# eval "$(register-python-argcomplete textract)"
# complete -C aws_completer aws

bindkey '^n' expand-or-complete
bindkey '^p' reverse-menu-complete

_comp_options+=(globdots)

bindkey -M menuselect '^o' accept-and-menu-complete
bindkey -M menuselect "+" accept-and-menu-complete

setopt no_list_ambiguous
setopt glob_complete
setopt complete_in_word
setopt list_packed

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' auto-description 'specify: %d' # format of informational and error messages
zstyle ':completion:*' completer _complete _approximate # auto correct misspellings
# zstyle ':completion:*' file-sort date
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' # match case-sensitive only if there are no case-sensitive matches
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*' # ignore case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # match lowercase to uppercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' menu yes=long select
zstyle ':completion:*' rehash true # automatic rehash
zstyle ':completion:*' squeeze-slashes yes # expand // to / instead of /*/
zstyle ':completion:*' verbose true
zstyle ':completion:*:(correct|approximate[^:]#):*' original false
zstyle ':completion:*:(correct|approximate[^:]#):*' tag-order '! original'
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters # configure completion for array subscripts: prioritize completing array indexes first, then parameters. This affects how completions are offered when the user is entering an array subscript (e.g., $array[...]).
zstyle ':completion:*:approximate:' max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )' # allow one error for every three characters typed in approximate completer
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=30;46'
zstyle ':completion:*:default' select-prompt '%SMatch %M Line %L %P%s' # when matches don't fit screen
zstyle ':completion:*:expand-alias:*' global true
zstyle ':completion:*:expand:*' tag-order all-expansions # insert all expansions for expand completer
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:man:*' menu yes select
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections true
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:processes' command 'ps -au $USER'
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'
zstyle ':completion:*:warnings' format "%B$fg[red]%}No matches for: $fg[white]%d%b"
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*' # ignore completion functions for commands you don't have
zstyle ':completion::*:(bindkey|zle):*:widgets' ignored-patterns '.*'
zstyle ':completion::*:(mv|cp|rm|chmod|chown|vi):*' ignore-line true # remove files from selection menu if already present in command line
zstyle ':completion::*:(scp|rsync):*' list-colors "=(#b)(*)/=0="${${${(s.:.)LS_COLORS}[(r)di=<->]}/di=/} '='${^${(M)${(s.:.)LS_COLORS}:#\**}}
zstyle ':completion::complete:*' rehash true
zstyle -e ':completion:*:approximate-extreme:*' max-errors \ '(( reply=($#PREFIX+$#SUFFIX)/1.2 ))'
zstyle -e ':completion:*:approximate:*' max-errors '(( reply=($#PREFIX+$#SUFFIX)/3 ))'

# completer: easy and low-profile for first try, approximation on second and extreme approximation on consecutive tries
zstyle -e ':completion:*' completer '
  case $_last_try in
    $HISTNO$BUFFER$CURSOR)
      reply=(_ignored _approximate _complete)
      _last_try="$HISTNO$BUFFER${CURSOR}x"
      ;;
    $HISTNO$BUFFER${CURSOR}x)
      reply=(_approximate:-extreme _complete)
    ;;
    *)
      _last_try="$HISTNO$BUFFER$CURSOR"
      reply=(_expand_alias _complete _prefix)
    ;;
  esac
'

# filenames
zstyle ':completion:*' file-patterns '%p:globbed-files' '*(-/):directories'
zstyle ':completion:*:*:*:default' menu yes select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true

# TODO tmux complete words from current pane https://gist.github.com/blueyed/6856354

# setopt correct_all
# export SPROMPT="Correct $fg_bold[red]%R$reset_color to $fg_bold[green]%r?$reset_color ($fg_bold[green]Yes$reset_color, $fg_bold[yellow]No$reset_color, $fg_bold[red]Abort$reset_color, $fg_bold[blue]Edit$reset_color) "

# # run rehash on completion so new installed program are found automatically:
# _force_rehash() {
# (( CURRENT == 1 )) && rehash
# return 1
# }

(( $+commands[orbctl] )) && source ~/.zsh.d/orbstack.zsh
[[ $OSTYPE == darwin* ]] && source ~/.zsh.d/mac.zsh
[[ $TERM == xterm-kitty ]] && source ~/.zsh.d/kitty.zsh
source ~/.local/share/zsh/plugins/nix-shell/nix-shell.plugin.zsh
source ~/.zsh.d/accept-line.zsh
source ~/.zsh.d/autopair.zsh
source ~/.zsh.d/autosuggestions.zsh
source ~/.zsh.d/direnv.zsh
source ~/.zsh.d/fzf.zsh
source ~/.zsh.d/grc.sh
source ~/.zsh.d/grep.sh
source ~/.zsh.d/history-substring-search.zsh
source ~/.zsh.d/keep.zsh
source ~/.zsh.d/tmux.zsh

# history expansion
bindkey ' ' magic-space

alias -- +x='chmod +x'

source ~/.local/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

export FZF_CTRL_R_OPTS="--nth=2.."
