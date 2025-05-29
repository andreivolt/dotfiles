export EDITOR=nvim
export PAGER=nvimpager
export BROWSER=google-chrome-stable

export CURL_CA_BUNDLE=~/.local/ca-certificates/combined-ca-bundle.pem

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

[[ "$OSTYPE" == darwin* ]] && source ~/.zsh.d/homebrew.sh
source ~/.config/env 2>/dev/null
[[ "$OSTYPE" == darwin* ]] && source ~/.orbstack/shell/init.zsh
