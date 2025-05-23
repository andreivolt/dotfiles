autoload -Uz compinit
[[ -f ~/.cache/zsh/zcompdump(#qN.mh+24) ]] && {
  compinit -d ~/.cache/zsh/zcompdump
  zcompile ~/.cache/zsh/zcompdump
} || compinit -C -d ~/.cache/zsh/zcompdump

(( ${+commands[brew]} )) && fpath=(/opt/homebrew/share/zsh/site-functions $fpath)

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
# Maps lowercase characters to their uppercase equivalents for completion
# Example: typing 'doc' will match 'Documents' but typing 'DOC' won't match 'documents'
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