export FZF_DEFAULT_OPTS="--ansi --bind='ctrl-y:execute-silent(pbcopy <<< {})+abort' --border --cycle --highlight-line --info=inline --preview-window=wrap --wrap --tiebreak=index"

export FZF_DEFAULT_COMMAND="rg -uu --files -H"

export FZF_CTRL_R_OPTS="--nth=2.."

# <tab> at beginning of line opens fzf file selector
function fzf-file-widget-open() {
  if [[ -z "$BUFFER" ]]; then
    local selected=$(rg --hidden --follow --files --sort modified --follow 2>/dev/null | tac | fzf --preview '~/.zsh.d/preview {}')
    if [[ -n "$selected" ]]; then
      if ! head -c 1024 "$selected" | file - | grep -q "text"; then
        if [[ -n "$TERMUX_VERSION" ]]; then
          BUFFER="termux-open '$selected'"
        else
          BUFFER="open '$selected'"
        fi
      else
        BUFFER="nvim '$selected'"
      fi
      zle accept-line
    fi
  else
    zle expand-or-complete
  fi
}
zle -N fzf-file-widget-open
bindkey '^I' fzf-file-widget-open
bindkey -M vicmd '^I' fzf-file-widget-open
