# Set tmux window title to current command
preexec() {
  local cmd=${1%% *}
  printf "\033k$cmd\033\\"
}

# Reset tmux window title when command finishes
precmd() {
  printf "\033kzsh\033\\"
}

# Add to hook arrays
preexec_functions+=(preexec)
precmd_functions+=(precmd)
