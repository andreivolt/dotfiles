# typeset -A global_aliases

# global_aliases=(
#   BG '& exit'
#   C '| wc -l'
#   E '| $EDITOR -'
#   G "|& grep '${grep_options:+"${grep_options[*]} "}'"
#   H '| head -n $(( +LINES?LINES-4:10 ))'
#   HL '--help |& less -r'
#   J '| jq -r'
#   L '| nvimpager'
#   LL '|& less -r'
#   N '&>/dev/null'
#   NE '2>/dev/null'
#   NO '&>|/dev/null'
#   NUL '&>/dev/null'
#   S '| sort -u'
#   SL '| sort | less'
#   T '| tail -n $(( +LINES?LINES-4:10 ))'
#   UUID '$(uuidgen | tr -d \\n)'
#   X '| xargs'
# )

# for alias_key alias_value in ${(kv)global_aliases}; do
#     alias -g $alias_key="$alias_value"
# done

alias -g BG='& exit'
alias -g C='| wc -l'
alias -g E='| $EDITOR -'
# alias -g G='|& grep '${grep_options:+"${grep_options[*]} "}
alias -g G='|& grep'
alias -g H='| head -n $(( +LINES?LINES-4:10 ))'
alias -g HL='--help |& less -r'
alias -g J='| jq -r'
alias -g L='| nvimpager'
alias -g LL='|& less -r'
alias -g N='&>/dev/null'
alias -g NE='2>/dev/null'
alias -g NO='&>|/dev/null'
alias -g NUL='&>/dev/null'
alias -g S='| sort -u'
alias -g SL='| sort | less'
alias -g T='| tail -n $(( +LINES?LINES-4:10 ))'
alias -g UUID='$(uuidgen | tr -d \\n)'
alias -g X='| xargs'
