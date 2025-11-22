export XDG_CACHE_HOME=~/.cache
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-$TMPDIR}
export XDG_STATE_HOME=~/.local/state

(( ${+commands[google-chrome-stable]} )) && BROWSER=google-chrome-stable
(( ${+commands[termux-open-url]} )) && BROWSER=termux-open-url
[[ -f ~/.local/ca-certificates/combined-ca-bundle.pem ]] && export CURL_CA_BUNDLE=~/.local/ca-certificates/combined-ca-bundle.pem
export DELTA_PAGER='less -R'
export DENO_NO_UPDATE_CHECK=1
export EDITOR=nvim
export TERMINAL=foot
export GPG_TTY="$(tty)"
export LESS='--RAW-CONTROL-CHARS --LONG-PROMPT --ignore-case --no-init --quit-if-one-screen'
export MANPAGER='nvim +Man!' MANWIDTH=100
export NIXPKGS_ALLOW_UNFREE=1
export PAGER=nvimpager
export PYTHONDONTWRITEBYTECODE=1 PYTHONWARNINGS=ignore
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export UV_TOOL_BIN_DIR=~/.local/bin

# disable Apple Terminal.app session restoration
export SHELL_SESSIONS_DISABLE=1

export HOMEBREW_CELLAR=/opt/homebrew/Cellar
export HOMEBREW_PREFIX=/opt/homebrew
export HOMEBREW_REPOSITORY=/opt/homebrew
export INFOPATH=/opt/homebrew/share/info${INFOPATH:+:$INFOPATH}
export MANPATH=/opt/homebrew/share/man${MANPATH:+:$MANPATH}:
export LIBRARY_PATH=/opt/homebrew/opt/libiconv/lib${LIBRARY_PATH:+:$LIBRARY_PATH}
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin${PATH:+:$PATH}

[[ -n "$TERMUX_VERSION" ]] && export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib:$LD_LIBRARY_PATH

typeset -U path

path+=(
  ~/go/bin(N)
  ~/.npm/bin(N)
  ~/.local/gem/ruby/*/bin(N)
  ~/.cargo/bin(N)
  ~/.cache/.bun/bin(N)
  ~/.local/bin(N)
  ~/bin(N)
)

source ~/.config/env

source ~/.orbstack/shell/init.zsh 2>/dev/null

# Fix PATH order after path_helper reorders it in login shells
# Ensure Nix paths come before system paths
path=(
  /run/current-system/sw/bin(N)
  ~/.nix-profile/bin(N)
  /nix/var/nix/profiles/default/bin(N)
  ${path:#/run/current-system/sw/bin}(N)
)

# Start Hyprland on TTY1
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec systemctl --user start hyprland.service
fi
