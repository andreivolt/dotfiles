umask u=rwx,g=,o=

# automatically remove duplicates from these arrays
typeset -U \
  cdpath \
  fpath \
  manpath \
  path

path=(
  ~/bin
  ~/.local/bin
  ~/go/bin
  ~/.cargo/bin
  $path
)

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

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
