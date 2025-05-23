export EDITOR=nvim
export PAGER=nvimpager
export BROWSER=google-chrome-stable

export XDG_CACHE_HOME=~/.cache
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local
export XDG_RUNTIME_DIR=$TMPDIR
export XDG_STATE_HOME=~/.local/state

export DENO_NO_UPDATE_CHECK=1

path=(
  ~/bin(N)
  ~/.local/bin(N)

  ~/.cache/.bun/bin(N)
  ~/.cargo/bin(N)
  ~/.local/gem/ruby/*/bin(N)
  ~/.npm/bin(N)
  ~/go/bin(N)

  $path
)

source ~/.zsh.d/homebrew.sh
source ~/.config/env
source ~/.orbstack/shell/init.zsh
