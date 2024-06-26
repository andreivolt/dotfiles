# alias -g G='|& grep '${grep_options:+"${grep_options[*]} "}
alias -g C='| wc -l'
alias -g CA="2>&1 | cat -A"
alias -g DN=/dev/null
alias -g EG='|& egrep'
alias -g EH='|& head'
alias -g EL='|& less'
alias -g ELS='|& less -S'
alias -g ET='|& tail'
alias -g ETL='|& tail -20'
alias -g F=' | fmt -'
alias -g G='| egrep'
alias -g H='| head'
alias -g HL='|& head -20'
alias -g L="| $PAGER"
alias -g LL="2>&1 | $PAGER"
alias -g LS='| less -S'
alias -g M='| more'
alias -g MM='| most'
alias -g NE="2> /dev/null"
alias -g NS='| sort -n'
alias -g NUL="> /dev/null 2>&1"
alias -g PIPE='|'
alias -g RNS='| sort -nr'
alias -g S='| sort'
alias -g T='| tail'
alias -g TL='| tail -20'
alias -g US='| sort -u'
alias -g X0='| xargs -0'
alias -g X0G='| xargs -0 egrep'
alias -g X='| xargs'
alias -g XG='| xargs egrep'
