function expand-alias() {
    zle _expand_alias
    zle self-insert
}

zle -N expand-alias

bindkey -M main ' ' expand-alias
