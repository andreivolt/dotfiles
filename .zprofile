umask u=rwx,g=,o=

# Homebrew
# # cache 'brew shellenv'
# typeset _brew_shellenv=$__zsh_cache_dir/brew_shellenv.zsh
# typeset -a _brew_cache=($brew_shellenv(Nmh-20))
# if ! (( $#_brew_cache )); then
#   ${brewcmd[1]} shellenv 2> /dev/null >| $_brew_shellenv
# fi
# echo $_brew_shellenv

# eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

export XDG_CONFIG_HOME=~/.config

source ~/.env.private

source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# automatically remove duplicates
typeset -Ug cdpath
typeset -Ug fpath
typeset -Ug manpath

typeset -Ug path
path=(
  ~/bin
  ~/go/bin
  ~/.cargo/bin
  ~/.local/bin
  $path
)

(( ${+commands[vi]} )) && export EDITOR='vi'
(( ${+commands[vim]} )) && export EDITOR='vim'
(( ${+commands[nvim]} )) && export EDITOR='nvim'
