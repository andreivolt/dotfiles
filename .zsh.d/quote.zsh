__quote-line () {
 zle beginning-of-line
 zle forward-word
 RBUFFER=${(q)RBUFFER}
 zle end-of-line
}
zle -N mquote && bindkey '^q' __quote-line

__quote_word_or_region() {
  emulate -L zsh
    if (( $REGION_ACTIVE )); then
      zle quote-region
    else
      # Alternative:{{{
      #
      #     RBUFFER+="'"
      #     zle vi-backward-blank-word
      #     LBUFFER+="'"
      #     zle vi-forward-blank-word
      #}}}
      zle set-mark-command
      zle vi-backward-blank-word
      zle quote-region
    fi
}
zle -N __quote_word_or_region
bindkey '^Q' __quote_word_or_region
