export XDG_CACHE_HOME=~/.cache
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local
export XDG_RUNTIME_DIR=$TMPDIR
export XDG_STATE_HOME=~/.local/state

export BROWSER=google-chrome-stable
export EDITOR=nvim
export PAGER=nvimpager
export MANPAGER='nvim +Man!'
export MANWIDTH=100
export GPG_TTY="$(tty)"

export LESS='--RAW-CONTROL-CHARS --LONG-PROMPT --ignore-case --no-init --quit-if-one-screen'
export DELTA_PAGER='less -R'

export NIXPKGS_ALLOW_UNFREE=1
export DENO_NO_UPDATE_CHECK=1
export PYTHONDONTWRITEBYTECODE=1
export PYTHONWARNINGS=ignore
export UV_TOOL_BIN_DIR=~/.local/bin

export ENABLE_BACKGROUND_TASKS=1
export CLAUDE_BASH_MAINTAIN_PROJECT_WORKING_DIR=1
export MAX_THINKING_TOKENS=31999

[[ -f ~/.local/ca-certificates/combined-ca-bundle.pem ]] && export CURL_CA_BUNDLE=~/.local/ca-certificates/combined-ca-bundle.pem

[[ "$OSTYPE" == darwin* ]] && source ~/.orbstack/shell/init.zsh

if [[ "$OSTYPE" == darwin* ]]; then
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
  export HOMEBREW_PREFIX="/opt/homebrew";
  export HOMEBREW_REPOSITORY="/opt/homebrew";
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
  export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";

  export LIBRARY_PATH=/opt/homebrew/opt/libiconv/lib:$LIBRARY_PATH
fi

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
