# Rust-based fzf history search plugin

# Bind for fzf history search
(( ! ${+ZSH_FZF_HISTORY_SEARCH_BIND} )) &&
typeset -g ZSH_FZF_HISTORY_SEARCH_BIND='^r'

# Cursor to end-of-line
(( ! ${+ZSH_FZF_HISTORY_SEARCH_END_OF_LINE} )) &&
typeset -g ZSH_FZF_HISTORY_SEARCH_END_OF_LINE=''

# Include full date timestamps in ISO8601 `yyyy-mm-dd hh:mm' format
(( ! ${+ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH} )) &&
typeset -g ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=1

# Relative dates support
(( ! ${+ZSH_HISTORY_RELATIVE_DATES} )) &&
typeset -g ZSH_HISTORY_RELATIVE_DATES=''

fzf_history_search() {
  setopt extendedglob

  # Check if Rust history search is available
  local rust_script="${${(%):-%x}:A:h}/history-search"
  if [[ ! -f "$rust_script" ]]; then
    echo "Error: Rust history search script not found at $rust_script" >&2
    return 1
  fi

  # Ensure script is executable
  [[ ! -x "$rust_script" ]] && chmod +x "$rust_script"

  local rust_args=""

  # Check if relative dates should be used
  if (( $ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH )); then
    if [[ -n "${ZSH_HISTORY_RELATIVE_DATES}" ]]; then
      rust_args="--relative"
    fi
  fi

  local selected_command
  selected_command=$(eval "$rust_script $rust_args")
  local ret=$?

  if [[ -n "$selected_command" ]]; then
    BUFFER="$selected_command"
    zle vi-fetch-history -n $BUFFER
    if [ -n "${ZSH_FZF_HISTORY_SEARCH_END_OF_LINE}" ]; then
      zle end-of-line
    fi
  fi

  zle reset-prompt
  return $ret
}

autoload fzf_history_search
zle -N fzf_history_search

bindkey $ZSH_FZF_HISTORY_SEARCH_BIND fzf_history_search
