# only regenerate completion cache once a day
autoload -Uz compinit
[[ -n ''${ZDOTDIR}/.zcompdump(#qN.mh+24) ]] && compinit || compinit -C
