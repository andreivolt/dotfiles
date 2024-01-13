# # rbenv
# eval "$(rbenv init - zsh)"

# path+="$(gem environment gemdir)/bin"
# path+="$HOME/.gem/ruby/2.7.0/bin"
path+="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin"

# # chruby
# which chruby >/dev/null && {
#   source $(brew --prefix chruby)/share/chruby/chruby.sh
#   source /usr/local/opt/chruby/share/chruby/auto.sh
# }
