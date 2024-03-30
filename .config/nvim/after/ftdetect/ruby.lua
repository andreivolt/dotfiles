vim.filetype.add({
  filename = {
    [".pryrc"] = "ruby",
  },
  pattern = {
    [".*/.*%.json.jbuilder"] = "ruby",
  },
})
