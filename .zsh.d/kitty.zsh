export KITTY_SHELL_INTEGRATION="enabled"
autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
kitty-integration
unfunction kitty-integration

alias ssh='kitty +kitten ssh'
