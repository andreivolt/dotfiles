umask u=rwx,g=,o=

export EDITOR=nvim
export PAGER=nvimpager

export XDG_CACHE_HOME=~/.cache
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local
export XDG_RUNTIME_DIR=$TMPDIR
export XDG_STATE_HOME=~/.local/state && mkdir -p $XDG_STATE_HOME

source ~/.zsh.d/homebrew.sh

source ~/.config/env

path=(
  ~/bin
  ~/go/bin
  ~/.cargo/bin
  ~/.local/bin
  ~/.local/gem/ruby/*/bin
  $path
)

source ~/.orbstack/shell/init.zsh
