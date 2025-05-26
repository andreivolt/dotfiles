set-tmux-title() printf "\033kzsh\033\\"

precmd_functions+=(set-tmux-title)
