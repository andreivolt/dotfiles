# notify long-running commands

function timer_start { timer=${timer:-$SECONDS} }

# run timer_start for every command
trap 'timer_start' DEBUG

function notify_when_done {
  timer_show=$(($SECONDS - $timer))
  unset timer
  notification_threshold=60
  # notification threshold in seconds
  if (( ${timer_show} > ${notification_threshold} )); then
    terminal-notifier -title "Terminal" -message "Done with task $1! Exit status: $? Time: ${timer_show}s"
  fi
}

# export command we are about to run, so we can inject it in the notification once done
preexec() { export _CMD=$1 }

excluded_re='^(vim|nvim|ssh|fg)'
precmd() {
  if ! [[ ${_CMD} =~ "${excluded_re}" ]] {
    notify_when_done ${_CMD}
  }
}
