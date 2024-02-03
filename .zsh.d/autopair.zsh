autopair_path=~/.zsh-plugins/autopair

[[ ! -d $autopair_path ]] && git clone --depth 1 https://github.com/hlissner/zsh-autopair $autopair_path

source $autopair_path/autopair.zsh

autopair-init
