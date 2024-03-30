return {
  "ms-jpq/coq_nvim",
  enable = false,
  branch = "coq",
  lazy = true,
  dependencies = {
    {
      "ms-jpq/coq.artifacts",
      branch = "artifacts",
    },
    {
      "ms-jpq/coq.thirdparty",
      branch = "3p",
    },
  },
}
