export FZF_DEFAULT_OPTS="\
--bind='ctrl-y:execute-silent(pbcopy <<< {})+abort' \
--info=inline \
--border \
--cycle \
--wrap \
--ansi \
--preview-window=wrap \
--color=border:bright-black \
--color=fg+:white:bold \
--color=bg:-1,gutter:-1 \
--color=hl+:yellow:bold,bg+:236 \
--color=pointer:blue \
--color=hl:yellow \
--color=prompt:blue \
--color=border:8 \
--color=info:240 \
--color=spinner:blue \
--color=marker:green
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
      BUFFER="vi $selected"
      zle accept-line
    fi
  else
    zle expand-or-complete
  fi
}
zle -N fzf-file-widget-vi
bindkey '^I' fzf-file-widget-vi
