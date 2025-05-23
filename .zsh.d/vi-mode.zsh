bindkey -v

export KEYTIMEOUT=1

autoload -Uz edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

bindkey -M vicmd 'H' run-help

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