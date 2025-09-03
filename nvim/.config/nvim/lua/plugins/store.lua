return{
  "alex-popov-tech/store.nvim",
  lazy = false,
  dependencies = {
     -- optional, for pretty readme preview / help window
    "MeanderingProgrammer/render-markdown.nvim"
  },
  cmd = "Store",
  keys = {
    { "<leader>s", "<cmd>Store<cr>", desc = "Open Plugin Store" },
  },
  opts = {
    -- optional configuration here
  },
}
