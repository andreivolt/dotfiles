export BROWSER=google-chrome-stable
export CURL_CA_BUNDLE=~/.local/ca-certificates/combined-ca-bundle.pem
export DELTA_PAGER='less -R'
export DENO_NO_UPDATE_CHECK=1
export EDITOR=nvim
export GPG_TTY="$(tty)"
export LESS='--RAW-CONTROL-CHARS --LONG-PROMPT --ignore-case --no-init --quit-if-one-screen'
export MANPAGER='nvim +Man!'
export MANWIDTH=100
export PAGER=nvimpager
export PYTHONDONTWRITEBYTECODE=1 # prevent Python from creating __pycache__ directories
export PYTHONWARNINGS=ignore
export UV_TOOL_BIN_DIR=~/.local/bin
export XDG_CACHE_HOME=~/.cache
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local
export XDG_RUNTIME_DIR=$TMPDIR
export XDG_STATE_HOME=~/.local/state

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

[[ "$OSTYPE" == darwin* ]] && source ~/.orbstack/shell/init.zsh
[[ "$OSTYPE" == darwin* ]] && source ~/.zsh.d/homebrew.sh

source ~/.config/env
