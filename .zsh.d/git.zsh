git-delete-merged() {
  git branch --merged | grep -Ev '(main|master)' | xargs git branch -d
}

git-remote-delete-current-branch() {
  git push origin :$(git branch --show-current)
}

git-delete-remote-branch() {
  git push origin :$1
}

