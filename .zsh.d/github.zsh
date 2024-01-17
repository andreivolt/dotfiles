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
