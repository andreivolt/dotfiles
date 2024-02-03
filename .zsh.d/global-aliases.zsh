typeset -A global_aliases

global_aliases=(
  BG '& exit'
  C '| wc -l'
  E '| $EDITOR -'
  G "|& grep '${grep_options:+"${grep_options[*]} "}'"
  H '| head -n $(( +LINES?LINES-4:10 ))'
  HL '--help |& less -r'
  J '| jq -r'
  L '| nvimpager'
  LL '|& less -r'
  N '&>/dev/null'
  NE '2>/dev/null'
  NO '&>|/dev/null'
  NUL '&>/dev/null'
  S '| sort -u'
  SL '| sort | less'
  T '| tail -n $(( +LINES?LINES-4:10 ))'
  UUID '$(uuidgen | tr -d \\n)'
  X '| xargs'
)

for alias_key alias_value in ${(kv)global_aliases}; do
    alias -g $alias_key="$alias_value"
done
