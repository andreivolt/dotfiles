export FZF_DEFAULT_OPTS="\
--ansi \
--bind='ctrl-y:execute-silent(pbcopy <<< {})+abort' \
--border \
--cycle \
--highlight-line \
--info=inline \
--preview-window=wrap \
--wrap \
--tiebreak=index \
"

export FZF_DEFAULT_COMMAND="\
rg -uu \
--files \
-H"

export FZF_CTRL_R_OPTS="--nth=2.."

# Tab at beginning of line opens fzf file selector in vi
function fzf-file-widget-vi() {
  if [[ -z "$BUFFER" ]]; then
    local selected=$(rg --files --sort modified --follow -g '!Library' -g '!.git' | tac | fzf)
    if [[ -n "$selected" ]]; then
      BUFFER="vi '$selected'"
      zle accept-line
    fi
  else
    zle expand-or-complete
  fi
}
zle -N fzf-file-widget-vi
bindkey '^I' fzf-file-widget-vi
