gh-url-slugify() {
  url-parser --part path $1 |
    sed "s/^.//; s/.git$//; s/\/$//; s/\//_/g"
}

gh-save() {
  git clone --depth 1 $1 $(github-url-slugify $1)
}

gh-review-requested() {
  gh pr list --search 'review-requested:andreivolt' --json headRefName --jq '.[].headRefName'
}

gh-has-pending-reviews() {
  $(gh pr list --search 'review-requested:andreivolt' --json url --jq length) -gt 0
}

gh-automerge() {
  for i in reviewed-by review-requested; do
    gh pr list --search $i:@me --json number,isDraft --jq '.[] | select(.isDraft == false).number'
  done |
    xargs -I% -n1 gh pr merge % --merge --auto
}
