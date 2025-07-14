HISTSIZE="999999" SAVEHIST=$HISTSIZE

HISTFILE=$XDG_STATE_HOME/zsh/history
[[ -f $HISTFILE ]] || mkdir $HISTFILE:h

setopt append_history
setopt extended_history
setopt share_history
setopt hist_fcntl_lock
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

setopt auto_cd
setopt auto_pushd
setopt extended_glob
setopt interactive_comments
setopt null_glob
setopt numeric_glob_sort

READNULLCMD=$PAGER

alias -g C='| wc -l'
alias -g G="| rg"
alias -g H='| head'
alias -g L="| $PAGER"
alias -g N="&> /dev/null"
alias -g NE="2> /dev/null"
alias -g X='| xargs'

alias -- +x='chmod +x'
alias cat="bat"
alias cdt='cd $(mktemp -d)'
alias claude="claude --dangerously-skip-permissions"
alias diff="diff --color"
alias edir="edir -r"
alias eza="eza --icons never"
alias gc='git clone --depth 1'
alias gron="fastgron"
alias http="xh"
alias jq="gojq"
alias l="ls -1"
alias la="ls -a"
alias ll="ls -l --classify=auto --git"
alias lla="ll -a"
alias ls="eza"
alias path='printf "%s\n" $path'
alias rg='rg --smart-case --colors match:bg:yellow --colors match:fg:black'
alias rm="rm --verbose"
alias scrcpy="scrcpy --render-driver opengl"
alias vi="nvim"
alias yt-dlp="yt-dlp --cookies-from-browser chrome"

source ~/.zsh.d/vi.zsh

autoload -Uz compinit
zcompdump=$XDG_CACHE_HOME/zsh/zcompdump
[[ -f $zcompdump ]] || mkdir $zcompdump:h
[[ -f $zcompdump(#qN.mh+24) ]] && { compinit -d $zcompdump && zcompile $zcompdump } || compinit -C -d $zcompdump

(( ${+commands[brew]} )) && fpath=(/opt/homebrew/share/zsh/site-functions $fpath)

setopt no_list_ambiguous
setopt glob_complete
setopt complete_in_word
setopt list_packed

_comp_options+=(globdots)

bindkey -M menuselect '^o' accept-and-menu-complete
bindkey -M menuselect "+" accept-and-menu-complete

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

zcompcache_path="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompcache"
[[ -d $zcompcache_path ]] || mkdir $zcompcache_path

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' rehash true
zstyle ':completion:*' squeeze-slashes yes
zstyle ':completion:*' verbose true
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' file-patterns '%p:globbed-files' '*(-/):directories'

zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:warnings' format "%B$fg[red]%}No matches for: $fg[white]%d%b"
zstyle ':completion:*:default' select-prompt '%SMatch %M Line %L %P%s'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=30;46'
zstyle ':completion:*:matches' group 'yes'

zstyle -e ':completion:*' completer '
	case $_last_try in
		$HISTNO$BUFFER$CURSOR)
			reply=(_ignored _approximate _complete)
			_last_try="$HISTNO$BUFFER${CURSOR}x"
			;;
		$HISTNO$BUFFER${CURSOR}x)
			reply=(_approximate:-extreme _complete)
		;;
		*)
			_last_try="$HISTNO$BUFFER$CURSOR"
			reply=(_complete _expand_alias _prefix)
		;;
	esac
'

zstyle ':completion:*:approximate:*' max-errors '(( reply=($#PREFIX+$#SUFFIX)/3 ))'
zstyle -e ':completion:*:approximate-extreme:*' max-errors '(( reply=($#PREFIX+$#SUFFIX)/1.2 ))'
zstyle ':completion:*:(correct|approximate[^:]#):*' original false
zstyle ':completion:*:(correct|approximate[^:]#):*' tag-order '! original'

zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'
zstyle ':completion::*:(bindkey|zle):*:widgets' ignored-patterns '.*'
zstyle ':completion::*:(mv|cp|rm|chmod|chown|vi):*' ignore-line true
zstyle ':completion::*:(scp|rsync):*' list-colors "=(#b)(*)/=0="${${${(s.:.)LS_COLORS}[(r)di=<->]}/di=/} '='${^${(M)${(s.:.)LS_COLORS}:#\**}}

zstyle ':completion:*:man:*' menu yes select
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections true

zstyle ':completion:*:processes' command 'ps -au $USER'
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

zstyle ':completion:*:expand:*' tag-order all-expansions
zstyle ':completion:*:expand-alias:*' global true
zstyle ':completion:*:history-words' list false

zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# history expansion
bindkey ' ' magic-space

source ~/.local/share/zsh/plugins/zsh-defer/zsh-defer.plugin.zsh

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/.local/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.zsh.d/p10k.zsh ]] && source ~/.zsh.d/p10k.zsh

[[ "$OSTYPE" == darwin* ]] && zsh-defer source ~/.zsh.d/orbstack.zsh
[[ $TERM == xterm-kitty ]] && zsh-defer source ~/.zsh.d/kitty.zsh
[[ -n "$TMUX" ]] && zsh-defer source ~/.zsh.d/tmux.zsh
zsh-defer eval "$(carapace _carapace zsh)"
zsh-defer eval "$(dircolors -b ~/.dircolors)"
zsh-defer source ~/.local/share/zsh/plugins/nix-shell/nix-shell.plugin.zsh
zsh-defer source ~/.zsh.d/autopair.zsh
zsh-defer source ~/.zsh.d/autosuggestions.zsh
zsh-defer source ~/.zsh.d/direnv.zsh
zsh-defer source ~/.zsh.d/fzf.zsh
zsh-defer source ~/.zsh.d/history-search/history-search.zsh
zsh-defer source ~/.zsh.d/history-substring-search.zsh

zsh-defer source ~/.local/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
