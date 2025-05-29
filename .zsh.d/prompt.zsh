if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.local/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.zsh.d/p10k.zsh ]] && source ~/.zsh.d/p10k.zsh
