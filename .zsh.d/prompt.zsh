# setopt prompt_subst # perform parameter expansion/command substitution in prompt

# # git on right prompt
# source ~/.zsh.d/git-prompt.zsh
# RPROMPT='%(?..%(130?::%S[%?]%s))%1(j.%B(%j%)%b.)$(__git_prompt_info)'
# add-zsh-hook chpwd __git_info

# source ~/.zsh.d/prompt-vi-mode.zsh && RPROMPT='${vim_mode}'

# source ~/drive/nixos-config/modules/zsh/prompt.zsh

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
