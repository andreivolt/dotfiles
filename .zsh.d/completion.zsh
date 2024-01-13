# # completion
# autoload -Uz compinit && compinit
# [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ] && compinit || compinit -C

_comp_options+=(globdots) # include hidden files

# completion: auto correct misspellings
zstyle ':completion:*' completer _complete _approximate
# completion: expand // to / instead of /*/
zstyle ':completion:*' squeeze-slashes yes
# TODO completion: menu selection highlight color
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=05;44' # blue
# remove files from selection menu if already present in command line
zstyle ':completion::*:(mv|cp|rm|chmod|chown|vim):*' ignore-line true
# completion: format warnings
zstyle ':completion:*:warnings' format "%B$fg[red]%}No matches for: $fg[white]%d%b"

# completion: man: group by section
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections true

zstyle ':completion:*:man:*' menu yes select # completion: man
zstyle ':completion:*' menu yes=long select # completion: menu
is-macos && bindkey -M menuselect '^o' accept-and-menu-complete # completion: menu: select multiple
zstyle ':completion:*' file-sort date # completion: sort files by date
setopt no_list_ambiguous # completion: complete unambiguous matches

setopt glob_complete # completion: when the current word has a glob pattern, do not insert all the words resulting from the expansion
setopt complete_in_word # completion: if the cursor is inside a word, completion is done from both ends
zstyle ':completion:*' rehash true # completion: automatic rehash
# completion: separate matches into groups
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''

setopt list_packed # compact multi-column completion list

zstyle ':completion:*' format 'Completing %d'

# completion ignore case
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
# TODO zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## press ^xh (control-x h) for getting tags in context; ^x? (control-x ?) to run complete_debug with trace output
# # allow one error for every three characters typed in approximate completer
# zstyle ':completion:*:approximate:' max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'

# # insert all expansions for expand completer
# zstyle ':completion:*:expand:*' tag-order all-expansions
# zstyle ':completion:*:history-words' list false

# zstyle ':completion:*:messages' format '%d'
# zstyle ':completion:*:options' auto-description '%d'

# # describe options in full
# zstyle ':completion:*:options' description 'yes'

# # on processes completion complete all user processes
# zstyle ':completion:*:processes' command 'ps -au$USER'

# # offer indexes before parameters in subscripts
# zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# # provide verbose completion information
# zstyle ':completion:*' verbose true

# # recent (as of Dec 2007) zsh versions are able to provide descriptions for commands (read: 1st word in the line) that it will list for the user to choose from. The following disables that, because it's not exactly fast.
# zstyle ':completion:*:-command-:*:' verbose false

# # Ignore completion functions for commands you don't have:
# zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

# zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

# # run rehash on completion so new installed program are found automatically:
# _force_rehash() {
# (( CURRENT == 1 )) && rehash
# return 1
# }

## completer: easy and low-profile for first try,
## approximation on second and extreme approximation
## on consecutive tries
# zstyle -e ':completion:*' completer '
# case $_last_try in
# $HISTNO$BUFFER$CURSOR)
# reply=(_ignored _approximate _complete)
# _last_try="$HISTNO$BUFFER${CURSOR}x"
# ;;
# $HISTNO$BUFFER${CURSOR}x)
# reply=(_approximate:-extreme _complete)
# ;;
# *)
# _last_try="$HISTNO$BUFFER$CURSOR"
# reply=(_expand_alias _complete _prefix)
# ;;
# esac
# '

# general settings
zstyle ':completion:*' menu select
# zstyle ':completion::complete:*' rehash true
# zstyle ':completion:*:expand-alias:*' global true

## _approximate completer configuration
# zstyle -e ':completion:*:approximate:*' max-errors \
# '(( reply=($#PREFIX+$#SUFFIX)/3 ))'
# zstyle -e ':completion:*:approximate-extreme:*' max-errors \
# '(( reply=($#PREFIX+$#SUFFIX)/1.2 ))'
# zstyle ':completion:*:(correct|approximate[^:]#):*' original false
# zstyle ':completion:*:(correct|approximate[^:]#):*' tag-order '! original'

zstyle ':completion::*:(bindkey|zle):*:widgets' ignored-patterns '.*'
# zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

## format of informational and error messages
zstyle ':completion:*' auto-description 'specify: %d'

# when matches don't fit screen
zstyle ':completion:*:default' select-prompt '%SMatch %M Line %L %P%s'

# cache completions and force prefix matches
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

# colors for scp remote completion
zstyle ':completion::*:(scp|rsync):*' list-colors \
  "=(#b)(*)/=0="${${${(s.:.)LS_COLORS}[(r)di=<->]}/di=/} \
  '='${^${(M)${(s.:.)LS_COLORS}:#\**}}

# menu completion
bindkey '^n' expand-or-complete
bindkey '^p' reverse-menu-complete
