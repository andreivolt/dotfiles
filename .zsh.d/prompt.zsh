if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/.local/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh.d/p10k.zsh

# TODO vcs info https://github.com/grml/grml-etc-core/blob/71bdc48d190a5369fff28a97c828db7b1edf10a9/etc/zsh/zshrc#L1964
# setopt prompt_subst # perform parameter expansion/command substitution in prompt

# source ~/.zsh.d/prompt-vi-mode.zsh && RPROMPT='${vim_mode}'

# TODO toggle right prompt
# if [[ ${(M)RPROMPT#??} == "%/" ]]; then
#   RPROMPT=${RPROMPT#%/}
# else
#   RPROMPT="%/"$RPROMPT # <- PWD
# fi
# zle reset-prompt
# }
# zle -N display-pwd
# bindkey '^F' display-pwd

## minimalistic prompt - way better!
# PROMPT='%B%U'${SSH_HOSTNAME:-zsh}'%u>%b '
# is_root_shell && PROMPT="%{$fg[red]%}$PROMPT%{$fg[red]%}"
# SPROMPT='zsh: correct '%R' to '%r' ? ([Y]es/[N]o/[E]dit/[A]bort) '

# setopt transient_rprompt # hide right prompt when accepting line

# prompt_precmd() {
#   rehash
#   setopt promptsubst
#
#   local jobs; unset jobs
#   local prompt_jobs
#   for a (${(k)jobstates}) {
#     j=$jobstates[$a];i="${${(@s,:,)j}[2]}"
#     jobs+=($a''${i//[^+-]/})
#   }
#   prompt_jobs=""
#   [[ -n $jobs ]] && prompt_jobs="%F{242}["${(j:,:)jobs}"] "
#
#   [[ -n $IN_NIX_SHELL ]] && nix_shell_indicator='%K{3}%F{0} nix-shell %f%k '
#
#   PROMPT="%(?.%F{green}.%F{red})%~ $ %f%K{black}%F{white}$prompt_jobs%f%k$nix_shell_indicator
#   $ "
# }
# prompt_opts=(cr percent sp subst)
# autoload -U add-zsh-hook
# add-zsh-hook precmd prompt_precmd
