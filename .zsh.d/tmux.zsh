tm() {
  [[ -z "$1" ]] && { echo "usage: tm <session>" >&2; return 1; }
  tmux has -t $1 && tmux attach -t $1 || tmux new -s $1
}

function __tmux-sessions() {
    local expl
    local -a sessions
    sessions=( ${${(f)"$(command tmux list-sessions)"}/:[ $'\t']##/:} )
    _describe -t sessions 'sessions' sessions "$@"
}

compdef __tmux-sessions tm

if [[ -n "$TMUX" ]]; then
  function set-tmux-title() {
    printf "\033kzsh\033\\"
  }
  precmd_functions+=(set-tmux-title)
fi

