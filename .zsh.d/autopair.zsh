autopair_path=~/.zsh-autopair
if [[ ! -d $autopair_path ]]; then
  git clone --depth 1 https://github.com/hlissner/zsh-autopair $autopair_path
fi

source $autopair_path/autopair.zsh
autopair-init
