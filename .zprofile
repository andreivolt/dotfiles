export BROWSER=google-chrome-stable
export EDITOR=nvim
export GPG_TTY="$(tty)"

export PAGER=nvimpager
export MANPAGER='nvim +Man!'
export MANWIDTH=100
export LESS='--RAW-CONTROL-CHARS --LONG-PROMPT --ignore-case --no-init --quit-if-one-screen'
export DELTA_PAGER='less -R'

export XDG_CACHE_HOME=~/.cache
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local
export XDG_RUNTIME_DIR=$TMPDIR
export XDG_STATE_HOME=~/.local/state

export NIXPKGS_ALLOW_UNFREE=1
export DENO_NO_UPDATE_CHECK=1
export PYTHONDONTWRITEBYTECODE=1
export PYTHONWARNINGS=ignore
export UV_TOOL_BIN_DIR=~/.local/bin

export ENABLE_BACKGROUND_TASKS=1
export CLAUDE_BASH_MAINTAIN_PROJECT_WORKING_DIR=1
export MAX_THINKING_TOKENS=31999

[[ -f ~/.local/ca-certificates/combined-ca-bundle.pem ]] && export CURL_CA_BUNDLE=~/.local/ca-certificates/combined-ca-bundle.pem

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
[[ "$OSTYPE" == darwin* ]] && source ~/.config/zsh/homebrew.sh

source ~/.config/env
