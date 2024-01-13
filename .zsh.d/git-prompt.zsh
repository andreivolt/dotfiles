__is_git_repo() {
  git rev-parse --git-dir &>/dev/null
}

__git_info() {
  if __is_git_repo; then
    __git_repo=1
    __git_project_name=${__git_project_name:-${${$(readlink -f $(git rev-parse --git-dir 2>|/dev/null)):h}##*/}}
  else
    __git_repo=0
    __git_project_name=
  fi
}

__git_branch_name() {
  print ${${${${(f)"$(git branch --no-color 2>/dev/null)"}:#[^*]*}##\* }:-no branch}
}

__git_status_dirty() {
  [[ -n "$(git status -uno --porcelain)" ]] &&
    print -n "%{$fg[red]%}★" ||
    print -n "%{$fg[green]%}∴" print "%{$fg[default]%}"
}

__git_prompt_info() {
  [[ __git_repo -eq 1 ]] || return
  [[ -z "$__git_project_name" ]] && __git_info
  print " %B$(__git_status_dirty)%b %B${__git_project_name}%b" "on %B$(__git_branch_name)%b"
}
