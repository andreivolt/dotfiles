# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zprofile.pre.zsh" ]] && . "$HOME/.fig/shell/zprofile.pre.zsh"
# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# pipx
export PATH="$PATH:$HOME/.local/bin"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zprofile.post.zsh" ]] && . "$HOME/.fig/shell/zprofile.post.zsh"


# Added by Toolbox App
export PATH="$PATH:/usr/local/bin"


# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
