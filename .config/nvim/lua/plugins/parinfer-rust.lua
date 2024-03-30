return {
  "eraserhd/parinfer-rust",
  build = "cargo build --release",
  event = "InsertCharPre",
  ft = {
    "clojure",
    "elisp",
    "lisp",
    "racket",
    "scheme",
  }
}
