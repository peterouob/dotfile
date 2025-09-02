
return {
  "kawre/leetcode.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  opts = {
    lang = "cpp",
    cn = {
      enabled = false,
      translate_problems = true,
      translator = true,
    },
    console = {
      dir = "row",
      open_on_runcode = true,
      result = { size = "60%" },
      size = { height = "75%", width = "90%" },
      testcase = { size = "40%", virt_text = true },
    },
    description = { position = "left", show_stats = true, width = "40%" },
    keys = {
      confirm = { "<CR>" },
      focus_result = "L",
      focus_testcases = "H",
      reset_testcases = "r",
      toggle = { "q" },
      use_testcase = "U",
    },
    storage = {
      cache = "/Users/peter/.cache/nvim/leetcode",
      home = "/Users/peter/.local/share/nvim/leetcode",
    },
    logging = true,
  },
  config = function(_, opts)
    require("leetcode").setup(opts)
  end,
}
