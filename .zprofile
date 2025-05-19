umask u=rwx,g=,o=

export EDITOR=nvim
export PAGER=nvimpager

export XDG_CACHE_HOME=~/.cache
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local
export XDG_RUNTIME_DIR=$TMPDIR
export XDG_STATE_HOME=~/.local/state

export DENO_NO_UPDATE_CHECK=1

source ~/.zsh.d/homebrew.sh

source ~/.config/env

path=(
  ~/bin(N)
  ~/go/bin(N)
  ~/.cargo/bin(N)
  ~/.local/bin(N)
  ~/.local/gem/ruby/*/bin(N)
  ~/.npm/bin(N)
  $path
)

source ~/.orbstack/shell/init.zsh
