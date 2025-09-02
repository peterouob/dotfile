
return {
  "yamatsum/nvim-cursorline",
  event = "VeryLazy",
  opts = {
    cursorline = { enable = true, timeout = 0 },
    cursorword = { enable = true, min_length = 3 },
  },
}
